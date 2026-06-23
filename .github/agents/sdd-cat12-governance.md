---
name: sdd-cat12-governance
model: Claude Opus 4.8
purpose: "カテゴリ12（統制管理）配下の全工程ファイルを生成・更新する"
---

# Agent: sdd-cat12-governance

## 役割
カテゴリ 12_統制管理 配下の7工程を実行し、監査、内部統制、コンプライアンス、統制証跡の整備を管理する。

---

## STEP 1: 01_specify/<request-folder>/requirements.md
- **What**: 統制対象業務、監査基準、統制証跡要件
- **Why**: コンプライアンス対応、監査対応、内部統制強化、リスク低減
- **受入条件**: 監査指摘ゼロ、統制証跡の完全性 100%

---

## STEP 2: 02_plan/<request-folder>/plan.md
- 統制の種類（予防 / 検出 / 是正）と対応業務
- 監査基準（ITIL / COBIT / 業界固有基準）
- 統制証跡の取得方法（ログ / レポート / チェックリスト）
- 監査スケジュール（内部監査 / 外部監査 / 規制監査）

---

## STEP 3: 03_tasks/<request-folder>/tasks.md
**目的**: 統制管理をタスク粒度に分解

**生成内容（テンプレート）**:
```markdown
# 統制管理タスク一覧

| タスクID | タスク名 | 担当者 | 期限 | 優先度 | 依存 |
|---------|---------|-------|------|-------|------|
| GOV-01 | 監査基準と統制マトリックス定義 | <Team> | D+3 | 高 | - |
| GOV-02 | 監査ツール導入と証跡収集自動化 | <Team> | D+4 | 中 | GOV-01 |
| GOV-03 | ステージング環境での動作確認 | <Team> | D+5 | 高 | GOV-02 |
| GOV-04 | 本番環境への適用 | <Team> | D+6 | 高 | GOV-03 |
| GOV-05 | 監査チームトレーニング | <Team> | D+7 | 中 | GOV-04 |
```

**実行指示**:
1. 02_plan の監査基準 から逆算してタスク化
2. 依存関係を明示
3. 担当者不明な場合は <TBD> で記載
4. 期限は要件の期限から逆算

---

### STEP 3-B: コード生成フェーズ（新規）
**目的**: タスク分解に基づいて実装コードを生成

**実行指示**:
1. 03_tasks/<request-folder>/tasks.md を入力として読み込み
2. サブエージェント `sdd-code-generator-cat12` を起動
3. 出力：
	- `scripts/<request-folder>/governance-audit.py` または `.sh`（実装コード）
	- `scripts/<request-folder>/build.log`（ビルド結果）
4. 04_implement/<request-folder>/implement.md に「実装成果物」セクションで参照

---

### STEP 3-C: 検証実行フェーズ（新規）
**目的**: 生成されたアプリに対して受入検証を実行

**実行指示**:
1. 生成されたアプリ + requirements.md 内の受入条件 を入力
2. サブエージェント `sdd-verifier-cat12` を起動
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
