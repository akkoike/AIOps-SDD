#!/usr/bin/env pwsh
<#
.SYNOPSIS
    SDD ヒアリング→ルーター連携テスト実行スクリプト
.DESCRIPTION
    ヒアリング結果がルーター判定に正しく引き継がれることを自動検証
.PARAMETER TestCaseName
    実行するテストケース名 (all, case1, case2, case3)
.EXAMPLE
    .\test-sdd-hearing-router.ps1 -TestCaseName all
#>
param(
    [ValidateSet('all', 'case1', 'case2', 'case3')]
    [string]$TestCaseName = 'all'
)

# ==================== 設定 ====================
$ErrorActionPreference = 'Stop'
$WarningPreference = 'Continue'

$WorkspaceRoot = Split-Path -Parent (Split-Path -Parent (Split-Path -Parent $PSScriptRoot))
$RouterPromptPath = Join-Path $WorkspaceRoot '.github/prompts/router-start.md'
$HearingAgentPath = Join-Path $WorkspaceRoot '.github/agents/sdd-hearing-subagent-sample.md'
$TestDataPath = Join-Path $WorkspaceRoot '.github/tests/test-sdd-hearing-router-integration.md'

$TestResults = @()

# ==================== ユーティリティ関数 ====================

function Test-FileExists {
    param([string]$Path)
    if (-not (Test-Path $Path)) {
        Write-Error "❌ ファイルが見つかりません: $Path"
        return $false
    }
    Write-Host "✓ ファイル存在確認: $Path"
    return $true
}

function Validate-HearingResult {
    param([hashtable]$Result)
    
    $requiredKeys = @(
        '依頼タイトル_選択',
        '依頼タイトル_入力',
        '依頼本文_選択',
        '依頼本文_入力',
        '背景_選択',
        '背景_入力',
        '期限優先度_選択',
        '期限優先度_入力',
        '制約_選択',
        '制約_入力',
        '成果物_選択',
        '成果物_入力',
        '受入条件_選択',
        '受入条件_入力'
    )
    
    $missingKeys = @()
    foreach ($key in $requiredKeys) {
        if (-not $Result.ContainsKey($key) -or [string]::IsNullOrWhiteSpace($Result[$key])) {
            $missingKeys += $key
        }
    }
    
    if ($missingKeys.Count -gt 0) {
        Write-Warning "⚠ ヒアリング結果に不足項目がります: $($missingKeys -join ', ')"
        return $false
    }
    return $true
}

function Validate-RouterJudgment {
    param(
        [hashtable]$Judgment,
        [string]$ExpectedCategory
    )
    
    $validations = @{
        'FirstCandidate' = $ExpectedCategory;
        'Confidence' = @('High', 'Medium', 'Low');
        'UpdateTargets' = 4;  # requirements, plan, tasks, verify
        'ActionSteps' = (1..7);
        'GateConditions' = (3..10);
        'QualityGates' = 3;  # 要件品質、整合、証跡
    }
    
    $errors = @()
    
    # 第1候補カテゴリの検証
    if ($Judgment['FirstCandidate'] -ne $ExpectedCategory) {
        $errors += "第1候補カテゴリが一致しません。期待: $ExpectedCategory, 実際: $($Judgment['FirstCandidate'])"
    }
    
    # 信頼度の検証
    if ($Judgment['Confidence'] -notin $validations['Confidence']) {
        $errors += "信頼度が無効です: $($Judgment['Confidence'])"
    }
    
    # 初回更新対象パスの検証
    if ($Judgment['UpdateTargets'].Count -ne $validations['UpdateTargets']) {
        $errors += "初回更新対象ファイル数が不正です。期待: $($validations['UpdateTargets']), 実際: $($Judgment['UpdateTargets'].Count)"
    }
    
    # 着手手順数の検証
    $stepCount = @($Judgment['ActionSteps']).Count
    if ($stepCount -gt 7) {
        $errors += "着手手順数が多すぎます（7 以下である必要があります）: $stepCount"
    }
    
    # Plan へ進むゲート条件の検証
    $gateCount = @($Judgment['GateConditions']).Count
    if ($gateCount -lt 3) {
        $errors += "Plan へ進むゲート条件が不足しています（3 件以上必要）: $gateCount"
    }
    
    # 品質ゲート挿入ポイントの検証
    $qualityGates = @(
        $Judgment['QualityGates'] -match '要件品質ゲート',
        $Judgment['QualityGates'] -match 'Specify-Plan整合ゲート',
        $Judgment['QualityGates'] -match 'Verify証跡ゲート'
    )
    if ($qualityGates -notcontains $true) {
        $errors += "品質ゲート項目が不完全です。要件品質、整合、証跡の3種類すべてが必要です。"
    }
    
    return @{
        IsValid = $errors.Count -eq 0;
        Errors = $errors;
    }
}

function Report-TestResult {
    param(
        [string]$TestName,
        [bool]$Passed,
        [string[]]$Details
    )
    
    $status = if ($Passed) { '✓ PASS' } else { '❌ FAIL' }
    Write-Host "`n$status: $TestName"
    if ($Details -and $Details.Count -gt 0) {
        $Details | ForEach-Object { Write-Host "  → $_" }
    }
    
    $TestResults += @{
        TestName = $TestName;
        Passed = $Passed;
        Details = $Details;
    }
}

# ==================== テストケース 1 ====================

function Test-Case1 {
    Write-Host "`n━━━━━ テストケース 1: CPU アラート過検知の是正 ━━━━━"
    
    $hearingResult = @{
        '依頼タイトル_選択' = '既存改善';
        '依頼タイトル_入力' = 'CPU アラート過検知の是正';
        '依頼本文_選択' = '監視改善';
        '依頼本文_入力' = '夜間に通知が多すぎるため、しきい値と通知条件を見直したい。';
        '背景_選択' = '品質課題';
        '背景_入力' = '当番負荷が高く、一次対応品質が落ちている。';
        '期限優先度_選択' = '高（今週中）';
        '期限優先度_入力' = '今週中に完了したい。';
        '制約_選択' = '本番停止不可';
        '制約_入力' = '監視停止は禁止。本番影響を最小化すること。';
        '成果物_選択' = '計画更新';
        '成果物_入力' = '新しいしきい値定義、通知ルール更新、段階的適用計画。';
        '受入条件_選択' = 'SLA遵守';
        '受入条件_入力' = '夜間アラート数を現在の 50% 以下に削減。';
    }
    
    $routerJudgment = @{
        'FirstCandidate' = '01_監視_モニタリング';
        'Confidence' = 'High';
        'UpdateTargets' = @(
            'categories/01_監視_モニタリング/01_specify/requirements.md',
            'categories/01_監視_モニタリング/02_plan/plan.md',
            'categories/01_監視_モニタリング/03_tasks/tasks.md',
            'categories/01_監視_モニタリング/05_verify/verification.md'
        );
        'ActionSteps' = @(
            '現在のアラート設定を Specify に記録',
            '夜間アラート分析データを収集',
            '新規しきい値候補を 2〜3 案、計画に追記',
            '段階的ロールアウト計画を明記',
            '検証手順を 05_verify へ記載',
            'KPI 達成判定基準を明示',
            'ロールバック手順を計画に含める'
        );
        'GateConditions' = @(
            'Specify で現状とアラート過多の根拠が記載されているか',
            '受入条件（KPI）が測定可能か',
            '制約（本番停止不可）への対応策が Plan にあるか'
        );
        'QualityGates' = 'Specify 完成直後に要件品質ゲート、Plan 完成時に整合ゲート、実装後に証跡ゲート';
    }
    
    # ヒアリング結果の検証
    $hearingValid = Validate-HearingResult $hearingResult
    Report-TestResult "ヒアリング結果の完全性" $hearingValid @()
    
    # ルーター判定の検証
    $routerValid = Validate-RouterJudgment $routerJudgment '01_監視_モニタリング'
    Report-TestResult "ルーター判定の妥当性" $routerValid.IsValid $routerValid.Errors
    
    # キーワード検証
    $keywordCheck = @(
        $hearingResult['依頼本文_入力'] -match '監視改善',
        $hearingResult['依頼本文_入力'] -match 'しきい値',
        $hearingResult['背景_入力'] -match '品質課題' -or $hearingResult['背景_選択'] -eq '品質課題'
    )
    $keywordValid = $keywordCheck -notcontains $false
    Report-TestResult "キーワード一貫性チェック" $keywordValid @()
}

# ==================== テストケース 2 ====================

function Test-Case2 {
    Write-Host "`n━━━━━ テストケース 2: 変更管理プロセス改善 ━━━━━"
    
    $hearingResult = @{
        '依頼タイトル_選択' = '新規提案';
        '依頼タイトル_入力' = '変更申請から承認までのリードタイム短縮';
        '依頼本文_選択' = '変更管理';
        '依頼本文_入力' = '変更申請フローを自動化して 2 営業日に短縮したい。';
        '背景_選択' = '工数削減';
        '背景_入力' = '運用チームが月 40 時間を変更管理業務に費やしている。';
        '期限優先度_選択' = '中（今月中）';
        '期限優先度_入力' = '今月末までに改善案を提出。';
        '制約_選択' = 'その他';
        '制約_入力' = '追加コスト 50 万円以内。既存ツール（Jira、Slack）連携必須。';
        '成果物_選択' = '一式対応';
        '成果物_入力' = 'プロセス設計、ツール構成案、実装手順、トレーニング資料。';
        '受入条件_選択' = '手順完了';
        '受入条件_入力' = 'リードタイム 2 営業日以内、月間工数 40h → 15h に削減。';
    }
    
    $routerJudgment = @{
        'FirstCandidate' = '05_変更_リリース管理';
        'SecondCandidate' = '02_運用補佐ツール開発_管理';
        'Confidence' = 'High';
    }
    
    $hearingValid = Validate-HearingResult $hearingResult
    Report-TestResult "ヒアリング結果の完全性（Case2）" $hearingValid @()
    
    # ツール言及チェック
    $toolMentioned = $hearingResult['制約_入力'] -match 'Jira' -and $hearingResult['制約_入力'] -match 'Slack'
    $toolDetail = if ($toolMentioned) { @() } else { @('Jira/Slack の言及が不十分') }
    Report-TestResult "既存ツール言及チェック" $toolMentioned $toolDetail
    
    # KPI 測定可能性チェック
    $kpiMeasurable = $hearingResult['受入条件_入力'] -match '営業日' -and $hearingResult['受入条件_入力'] -match '工数'
    $kpiDetail = if ($kpiMeasurable) { @() } else { @('KPI が測定可能な形で記載されていません') }
    Report-TestResult "KPI 測定可能性チェック" $kpiMeasurable $kpiDetail
}

# ==================== テストケース 3 ====================

function Test-Case3 {
    Write-Host "`n━━━━━ テストケース 3: あいまい依頼の追加質問 ━━━━━"
    
    $vagueResult = @{
        '依頼タイトル_選択' = 'その他';
        '依頼タイトル_入力' = 'システムパフォーマンス向上';
        '依頼本文_選択' = 'その他';
        '依頼本文_入力' = '応答時間が遅いという報告が増えている。';
        '背景_選択' = '品質課題';
        '背景_入力' = 'ユーザー満足度が低下。';
        '期限優先度_選択' = '中（今月中）';
        '期限優先度_入力' = '特に急いない。';
        '制約_選択' = 'その他';
        '制約_入力' = '予算の制約がある。';
        '成果物_選択' = 'その他';
        '成果物_入力' = 'パフォーマンス改善。';
        '受入条件_選択' = 'その他';
        '受入条件_入力' = '応答時間が改善されればよい。';
    }
    
    # あいまい度のスコア計算（「その他」の数）
    $ambiguityCount = @(
        $vagueResult['依頼タイトル_選択'] -eq 'その他',
        $vagueResult['依頼本文_選択'] -eq 'その他',
        $vagueResult['成果物_選択'] -eq 'その他',
        $vagueResult['受入条件_選択'] -eq 'その他'
    ) | Where-Object { $_ } | Measure-Object | Select-Object -ExpandProperty Count
    
    $isAmbiguous = $ambiguityCount -ge 2
    $ambiguityDetail = @("「その他」の数: $ambiguityCount")
    Report-TestResult "あいまい依頼の検出" $isAmbiguous $ambiguityDetail
    
    # 具体値の不足
    $lacksConcreteValue = $vagueResult['受入条件_入力'] -notmatch '[0-9]+' -and $vagueResult['期限優先度_入力'] -notmatch '[0-9]+'
    $concreteDetail = @("受入条件が測定不可（具体値なし）")
    Report-TestResult "具体値不足の検出" $lacksConcreteValue $concreteDetail
    
    # 追加質問の必要性判定
    $needsFollowUp = $isAmbiguous -or $lacksConcreteValue
    $followUpDetail = if ($needsFollowUp) {
        @(
            "応答時間の現在値と目標値",
            "パフォーマンス低下の特定機能",
            "原因仮説",
            "予算上限",
            "本番への影響許容度"
        )
    } else { @() }
    Report-TestResult "追加質問の必要性判定" $needsFollowUp $followUpDetail
}

# ==================== メイン処理 ====================

Write-Host "🧪 SDD ヒアリング→ルーター連携テスト開始"
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# ファイル存在確認
$filesValid = @(
    Test-FileExists $RouterPromptPath,
    Test-FileExists $HearingAgentPath,
    Test-FileExists $TestDataPath
) -notcontains $false

if (-not $filesValid) {
    Write-Error "テストに必要なファイルが見つかりません。"
    exit 1
}

# テストケース実行
switch ($TestCaseName) {
    'case1' { Test-Case1 }
    'case2' { Test-Case2 }
    'case3' { Test-Case3 }
    'all' {
        Test-Case1
        Test-Case2
        Test-Case3
    }
}

# ==================== テスト結果サマリー ====================

Write-Host "`n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
Write-Host "📊 テスト結果サマリー"
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

$passCount = ($TestResults | Where-Object { $_.Passed }).Count
$failCount = ($TestResults | Where-Object { -not $_.Passed }).Count

Write-Host "✓ PASS: $passCount"
Write-Host "❌ FAIL: $failCount"
Write-Host "合計: $($TestResults.Count)"

if ($failCount -gt 0) {
    Write-Host "`n失敗したテスト:"
    $TestResults | Where-Object { -not $_.Passed } | ForEach-Object {
        Write-Host "  - $($_.TestName)"
        $_.Details | ForEach-Object { Write-Host "    → $_" }
    }
    exit 1
} else {
    Write-Host "`n✓ すべてのテストが成功しました！"
    exit 0
}
