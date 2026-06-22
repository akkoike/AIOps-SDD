# SDD ヒアリング→ルーター連携テスト ガイド

## 概要
このテストスイートは、SDD ヒアリング専用サブエージェント（`sdd-hearing-intake`）とルーター（`sdd-router`）の連携フローを自動検証します。

## テストファイル構成

```
.github/tests/
├── README.md                                    ← このファイル
├── test-sdd-hearing-router-integration.md       ← テストケース定義・期待値
└── test-sdd-hearing-router.ps1                 ← 自動実行スクリプト
```

## 前提条件

### 必要ファイル
- `.github/prompts/router-start.md`
- `.github/agents/sdd-hearing-subagent-sample.md`
- `.github/agents/agents.md`
- `.github/tests/test-sdd-hearing-router-integration.md`
- `.github/tests/test-sdd-hearing-router.ps1`

### 環境要件
- PowerShell 5.1 以上（Windows）またはシステムで実行可能
- 絶対パスの解決が可能な環境

## テスト内容

### テストケース 1: CPU アラート過検知の是正
**目的:** 監視改善カテゴリの適切なルーティングと完全性を検証

- **入力:** 夜間アラート多発、しきい値見直し依頼
- **期待ルーター判定:** `01_監視_モニタリング` (信頼度: High)
- **チェック項目:**
  - ヒアリング結果のすべての項目が埋まっているか
  - ルーター判定のカテゴリが妥当か
  - 初回更新対象ファイルパスが正確か
  - 品質ゲート 3 種類がすべて指定されているか

### テストケース 2: 変更管理プロセス改善
**目的:** 複数候補カテゴリ判定と既存ツール言及の検証

- **入力:** 変更申請リードタイム短縮、CAB 効率化
- **期待ルーター判定:**
  - 第1候補: `05_変更_リリース管理` (High)
  - 第2候補: `02_運用補佐ツール開発_管理`
- **チェック項目:**
  - Jira、Slack などの既存ツール言及が Specify に反映されるか
  - KPI（工数削減、リードタイム）が測定可能か
  - 複数カテゴリ候補の場合、信頼度の違いが明示されるか

### テストケース 3: あいまい依頼の追加質問
**目的:** 曖昧なヒアリング入力を検出し、追加質問を発火させることを検証

- **入力:** 「パフォーマンス向上」など具体性に欠ける依頼
- **期待動作:** 追加質問を発火
- **チェック項目:**
  - 「その他」選択の過度な使用を検出できるか
  - 具体値が不足している受入条件を検出できるか
  - 適切な追加質問が自動生成されるか

## 実行方法

### 1. 全テストケース実行

```powershell
cd '.github/tests'
.\test-sdd-hearing-router.ps1 -TestCaseName all
```

### 2. 特定のテストケースのみ実行

```powershell
# テストケース 1 のみ
.\test-sdd-hearing-router.ps1 -TestCaseName case1

# テストケース 2 のみ
.\test-sdd-hearing-router.ps1 -TestCaseName case2

# テストケース 3 のみ
.\test-sdd-hearing-router.ps1 -TestCaseName case3
```

### 3. Windows 環境での実行（実行ポリシーの確認）

```powershell
# 実行ポリシーの確認
Get-ExecutionPolicy

# 必要に応じてスコープを限定して変更
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

## テスト結果の読み方

### 成功時
```
✓ PASS: 12
❌ FAIL: 0
合計: 12

✓ すべてのテストが成功しました！
```

### 失敗時
```
✓ PASS: 10
❌ FAIL: 2
合計: 12

失敗したテスト:
  - ルーター判定の妥当性
    → 第1候補カテゴリが一致しません。期待: 01_監視_モニタリング, 実際: 09_キャパシティ管理
  - KPI 測定可能性チェック
    → KPI が測定可能な形で記載されていません
```

## 検証される項目

### ヒアリング結果の検証
- [ ] 7 つの質問項目すべてに「選択」と「入力」が埋まっているか
- [ ] 「その他」選択時に「入力」が必須化されているか
- [ ] 入力内容が空白でないか

### ルーター判定の検証
- [ ] 第1候補カテゴリが期待値と一致するか
- [ ] 信頼度が有効な値（High/Medium/Low）か
- [ ] 初回更新対象ファイル 4 種類（requirements, plan, tasks, verify）がすべて指定されているか
- [ ] 着手手順が 7 以下か
- [ ] Plan へ進むゲート条件が 3 件以上あるか
- [ ] 品質ゲート（要件品質、整合、証跡）3 種類がすべて指定されているか

### ビジネスロジックの検証
- [ ] 依頼本文の選択肢とキーワードがルーター判定と一貫しているか
- [ ] 背景と期限/優先度の組み合わせが妥当か
- [ ] 制約がルーター判定と矛盾していないか
- [ ] 成果物の期待形が受入条件と整合しているか

## テスト結果の統合

### CI/CD への統合例（GitHub Actions）

```yaml
name: SDD Integration Tests

on: [push, pull_request]

jobs:
  sdd-tests:
    runs-on: windows-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Run SDD Hearing-Router Integration Tests
        run: |
          cd .github/tests
          .\test-sdd-hearing-router.ps1 -TestCaseName all
```

### 手動実行時の自動ログ記録

テスト実行時のログを自動保存：

```powershell
$timestamp = Get-Date -Format 'yyyyMMdd_HHmmss'
$logFile = "test-result-$timestamp.log"

.\test-sdd-hearing-router.ps1 -TestCaseName all | Tee-Object -FilePath $logFile
```

## トラブルシューティング

### スクリプト実行エラー: "ファイルが見つかりません"

**原因:** ワーキングディレクトリが正しくない

**解決:**
```powershell
cd 'C:\Users\akkoike\OneDrive - Microsoft\デスクトップ\AIOps-SDD\.github\tests'
.\test-sdd-hearing-router.ps1 -TestCaseName all
```

### テスト失敗: "第1候補カテゴリが一致しません"

**原因:** 
1. ヒアリング結果が正確でない
2. ルータープロンプトの判定ロジックが期待値と異なる

**確認手順:**
1. `.github/tests/test-sdd-hearing-router-integration.md` の期待値を確認
2. ルータープロンプト（`router-start.md`）の判定ルールを確認
3. ルータープロンプトの「12 カテゴリ判定先」セクションで対応キーワードを確認

### テスト失敗: "KPI が測定可能な形で記載されていません"

**原因:** ヒアリング入力で具体的な数値や測定基準が不足している

**解決:** ヒアリング結果の「受入条件」に具体値（百分率、SLA 値、チェックリスト数など）を追加

## 拡張とカスタマイズ

### 新しいテストケースの追加

`test-sdd-hearing-router-integration.md` に新規テストケースセクションを追加：

```markdown
## テストケース 4: 新規ケース名

### 4-1) ヒアリング結果
...

### 4-2) ルーター判定（期待値）
...
```

`test-sdd-hearing-router.ps1` に新規テスト関数を追加：

```powershell
function Test-Case4 {
    Write-Host "`n━━━━━ テストケース 4: 新規ケース名 ━━━━━"
    # テストロジック
}
```

`Test-CaseName` パラメータを拡張：

```powershell
'case4' { Test-Case4 }
```

### テスト検証ルールのカスタマイズ

`Validate-RouterJudgment` 関数を拡張してカスタム検証ルールを追加

## 既知の制限

1. **実際のエージェント呼び出しはしない** - テストはシミュレーション データで実行
2. **プロンプト解釈は未検証** - 実際のサブエージェント動作は別途確認が必要
3. **インタラクティブなフロー不可** - スクリプトベースのテストのため、会話型の分岐は検証不可

## 次のステップ

1. ✅ テストスクリプト実行
2. ✅ テスト結果を確認
3. ✅ 失敗項目があれば修正（ヒアリングプロンプト/ルータープロンプト）
4. ✅ 修正後に再実行
5. ✅ CI/CD パイプラインへ統合

## サポート

テスト実行時の問題や改善提案は、以下を確認してください：
- `.github/prompts/router-start.md`
- `.github/agents/sdd-hearing-subagent-sample.md`
- `.github/agents/agents.md`
