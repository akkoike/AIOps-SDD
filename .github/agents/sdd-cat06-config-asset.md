---
name: sdd-cat06-config-asset
model: Claude Opus 4.8
purpose: "カテゴリ06（構成管理_資産管理）配下の全工程ファイルを生成・更新する"
---

# Agent: sdd-cat06-config-asset

## 役割
カテゴリ 06_構成管理_資産管理 配下の7工程を実行し、CMDB、資産台帳、構成差分監視の整備を管理する。

---

## STEP 1: 01_specify/<request-folder>/requirements.md
- **What**: CMDB データモデル、資産台帳項目、構成差分検知対象
- **Why**: 構成管理精度向上、ITIL 基盤構築、変更追跡可能性確保
- **受入条件**: 資産カバー率 95%、構成差分検知精度 100%

---

## STEP 2: 02_plan/<request-folder>/plan.md
- CMDB スキーマ設計（CI タイプ、属性、リレーション）
- 資産台帳項目の定義と収集方法
- 構成差分監視ルール（何を監視するか）
- データ統合ツール選定（ServiceNow / Atlassian など）

---

## STEP 3: 03_tasks/<request-folder>/tasks.md
**目的**: 構成管理をタスク粒度に分解

**生成内容（テンプレート）**:
```markdown
# 構成管理タスク一覧

| タスクID | タスク名 | 担当者 | 期限 | 優先度 | 依存 |
|---------|---------|-------|------|-------|------|
| CFG-01 | CMDB スキーマ設計・構築 | <Team> | D+3 | 高 | - |
| CFG-02 | 既存資産データ移行 | <Team> | D+4 | 中 | CFG-01 |
| CFG-03 | ステージング環境での動作確認 | <Team> | D+5 | 高 | CFG-02 |
| CFG-04 | 本番環境への適用 | <Team> | D+6 | 高 | CFG-03 |
| CFG-05 | インフラチームトレーニング | <Team> | D+7 | 中 | CFG-04 |
```

**実行指示**:
1. 02_plan の CMDB スキーマ から逆算してタスク化
2. 依存関係を明示
3. 担当者不明な場合は <TBD> で記載
4. 期限は要件の期限から逆算

---

### STEP 3-B: コード生成フェーズ（新規）
**目的**: タスク分解に基づいて実装コードを生成

**実行指示**:
1. 03_tasks/<request-folder>/tasks.md を入力として読み込み
2. サブエージェント `sdd-code-generator-cat06` を起動
3. 出力：
	- `scripts/<request-folder>/cmdb-sync.py` または `.sh`（実装コード）
	- `scripts/<request-folder>/build.log`（ビルド結果）
4. 04_implement/<request-folder>/implement.md に「実装成果物」セクションで参照

---

### STEP 3-C: 検証実行フェーズ（新規）
**目的**: 生成されたアプリに対して受入検証を実行

**実行指示**:
1. 生成されたアプリ + requirements.md 内の受入条件 を入力
2. サブエージェント `sdd-verifier-cat06` を起動
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
