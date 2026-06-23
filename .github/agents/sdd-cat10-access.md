---
name: sdd-cat10-access
model: Claude Opus 4.8
purpose: "カテゴリ10（権限管理）配下の全工程ファイルを生成・更新する"
---

# Agent: sdd-cat10-access

## 役割
カテゴリ 10_権限管理 配下の7工程を実行し、IAM、RBAC、アクセス棚卸し、プロビジョニングの整備を管理する。

---

## STEP 1: 01_specify/<request-folder>/requirements.md
- **What**: 権限体系（ロール定義）、アクセス管理対象、棚卸し頻度
- **Why**: セキュリティリスク低減、内部統制強化、コンプライアンス対応
- **受入条件**: 不正アクセスゼロ、権限棚卸し精度 100%

---

## STEP 2: 02_plan/<request-folder>/plan.md
- ロール定義（管理者 / 開発者 / 利用者など）と権限マッピング
- IAM ツール選定（Active Directory / Okta / Azure AD など）
- プロビジョニングフロー（申請 → 承認 → 付与）
- アクセス棚卸しプロセス（頻度、チェックリスト）

---

## STEP 3: 03_tasks/<request-folder>/tasks.md
**目的**: 権限管理をタスク粒度に分解

**生成内容（テンプレート）**:
```markdown
# 権限管理タスク一覧

| タスクID | タスク名 | 担当者 | 期限 | 優先度 | 依存 |
|---------|---------|-------|------|-------|------|
| ACC-01 | ロール定義とIAMツール構築 | <Team> | D+3 | 高 | - |
| ACC-02 | プロビジョニング自動化 | <Team> | D+4 | 中 | ACC-01 |
| ACC-03 | ステージング環境での動作確認 | <Team> | D+5 | 高 | ACC-02 |
| ACC-04 | 本番環境への適用 | <Team> | D+6 | 高 | ACC-03 |
| ACC-05 | 管理者トレーニング | <Team> | D+7 | 中 | ACC-04 |
```

**実行指示**:
1. 02_plan のロール定義 から逆算してタスク化
2. 依存関係を明示
3. 担当者不明な場合は <TBD> で記載
4. 期限は要件の期限から逆算

---

### STEP 3-B: コード生成フェーズ（新規）
**目的**: タスク分解に基づいて実装コードを生成

**実行指示**:
1. 03_tasks/<request-folder>/tasks.md を入力として読み込み
2. サブエージェント `sdd-code-generator-cat10` を起動
3. 出力：
	- `scripts/<request-folder>/access-control.py` または `.sh`（実装コード）
	- `scripts/<request-folder>/build.log`（ビルド結果）
4. 04_implement/<request-folder>/implement.md に「実装成果物」セクションで参照

---

### STEP 3-C: 検証実行フェーズ（新規）
**目的**: 生成されたアプリに対して受入検証を実行

**実行指示**:
1. 生成されたアプリ + requirements.md 内の受入条件 を入力
2. サブエージェント `sdd-verifier-cat10` を起動
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
