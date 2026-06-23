---
name: sdd-cat07-security
model: Claude Opus 4.8
purpose: "カテゴリ07（セキュリティ管理）配下の全工程ファイルを生成・更新する"
---

# Agent: sdd-cat07-security

## 役割
カテゴリ 07_セキュリティ管理 配下の7工程を実行し、脆弱性対応、セキュリティ監査、セキュリティ是正の整備を管理する。

---

## STEP 1: 01_specify/<request-folder>/requirements.md
- **What**: 脆弱性スキャン項目、セキュリティ監査基準、パッチ適用ポリシー
- **Why**: セキュリティリスク低減、コンプライアンス対応、データ保護
- **受入条件**: 脆弱性検出率 100%、対応率 90日以内

---

## STEP 2: 02_plan/<request-folder>/plan.md
- 脆弱性分類と優先度（Critical / High / Medium / Low）
- スキャンツール選定と実行計画（頻度、スコープ）
- 対応手順（パッチテスト、本番適用、ロールバック）
- セキュリティ監査チェックリスト

---

## STEP 3: 03_tasks/<request-folder>/tasks.md
**目的**: セキュリティ対応をタスク粒度に分解

**生成内容（テンプレート）**:
```markdown
# セキュリティタスク一覧

| タスクID | タスク名 | 担当者 | 期限 | 優先度 | 依存 |
|---------|---------|-------|------|-------|------|
| SEC-01 | 脆弱性スキャンツール選定・構築 | <Team> | D+3 | 高 | - |
| SEC-02 | パッチ適用プロセス確立 | <Team> | D+4 | 中 | SEC-01 |
| SEC-03 | ステージング環境での動作確認 | <Team> | D+5 | 高 | SEC-02 |
| SEC-04 | 本番環境への適用 | <Team> | D+6 | 高 | SEC-03 |
| SEC-05 | セキュリティチームトレーニング | <Team> | D+7 | 中 | SEC-04 |
```

**実行指示**:
1. 02_plan のスキャン計画 から逆算してタスク化
2. 依存関係を明示
3. 担当者不明な場合は <TBD> で記載
4. 期限は要件の期限から逆算

---

### STEP 3-B: コード生成フェーズ（新規）
**目的**: タスク分解に基づいて実装コードを生成

**実行指示**:
1. 03_tasks/<request-folder>/tasks.md を入力として読み込み
2. サブエージェント `sdd-code-generator-cat07` を起動
3. 出力：
	- `scripts/<request-folder>/security-scan.py` または `.sh`（実装コード）
	- `scripts/<request-folder>/build.log`（ビルド結果）
4. 04_implement/<request-folder>/implement.md に「実装成果物」セクションで参照

---

### STEP 3-C: 検証実行フェーズ（新規）
**目的**: 生成されたアプリに対して受入検証を実行

**実行指示**:
1. 生成されたアプリ + requirements.md 内の受入条件 を入力
2. サブエージェント `sdd-verifier-cat07` を起動
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
