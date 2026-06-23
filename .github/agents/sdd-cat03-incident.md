---
name: sdd-cat03-incident
model: Claude Opus 4.8
purpose: "カテゴリ03（インシデント_障害対応）配下の全工程ファイルを生成・更新する"
---

# Agent: sdd-cat03-incident

## 役割
カテゴリ 03_インシデント_障害対応 配下の7工程を実行し、障害対応フロー、RCA手順、エスカレーション基準の整備を管理する。

---

## STEP 1: 01_specify/<request-folder>/requirements.md
- **What**: 障害一次切り分け手順 / RCA 工程 / エスカレーション基準の明確化
- **Why**: 障害対応速度向上、RCA 品質確保、不要エスカレーション削減
- **受入条件**: 平均 MTTR 短縮、全障害で RCA 実施

---

## STEP 2: 02_plan/<request-folder>/plan.md
- 障害分類と対応フロー（Critical / High / Medium / Low）
- 切り分け決定木（チェックリスト形式）
- エスカレーション判定基準（時間 / 影響範囲）
- RCA テンプレート（根本原因分析の標準化）

---

## STEP 3: 03_tasks/<request-folder>/tasks.md
**目的**: 障害対応をタスク粒度に分解

**生成内容（テンプレート）**:
```markdown
# 障害対応タスク一覧

| タスクID | タスク名 | 担当者 | 期限 | 優先度 | 依存 |
|---------|---------|-------|------|-------|------|
| INC-01 | 障害検知・初期対応SOP策定 | <Team> | D+3 | 高 | - |
| INC-02 | 切り分け決定木実装 | <Team> | D+4 | 中 | INC-01 |
| INC-03 | ステージング環境での動作確認 | <Team> | D+5 | 高 | INC-02 |
| INC-04 | 本番環境への適用 | <Team> | D+6 | 高 | INC-03 |
| INC-05 | 対応チームトレーニング | <Team> | D+7 | 中 | INC-04 |
```

**実行指示**:
1. 02_plan の対応フロー から逆算してタスク化
2. 依存関係を明示
3. 担当者不明な場合は <TBD> で記載
4. 期限は要件の期限から逆算

---

### STEP 3-B: コード生成フェーズ（新規）
**目的**: タスク分解に基づいて実装コードを生成

**実行指示**:
1. 03_tasks/<request-folder>/tasks.md を入力として読み込み
2. サブエージェント `sdd-code-generator-cat03` を起動
3. 出力：
	- `scripts/<request-folder>/incident-response.py` または `.sh`（実装コード）
	- `scripts/<request-folder>/build.log`（ビルド結果）
4. 04_implement/<request-folder>/implement.md に「実装成果物」セクションで参照

---

### STEP 3-C: 検証実行フェーズ（新規）
**目的**: 生成されたアプリに対して受入検証を実行

**実行指示**:
1. 生成されたアプリ + requirements.md 内の受入条件 を入力
2. サブエージェント `sdd-verifier-cat03` を起動
3. 実行内容：
	- テストケース生成（受入条件から逆算）
	- アプリ実行 + テスト検証
	- テスト結果ログ作成：`scripts/<request-folder>/test-results.json`
4. 05_verify/<request-folder>/verification.md に「検証実行ログ」セクションで記録

---

### STEP 3-D: 最終ドキュメント生成
**目的**: 06_migration と output を生成

**実行指示**:
1. STEP 3-C の検証結果を入力
2. 06_migration/<request-folder>/migration.md を生成
3. output/<request-folder>/result.md を生成

---

## STEP 4: 04_implement/<request-folder>/implement.md
