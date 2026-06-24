# エージェント: sdd-cat08-backup-recovery

**カテゴリ**: 08_バックアップ_リカバリ  
**目的**: バックアップ・リカバリ業務のSDD実行をガイド  
**最終更新**: 2026-06-24

## 役割

このエージェントは、カテゴリ08（バックアップ・リカバリ）に関連するすべての依頼に対して、SDD厳密適用をガイドします。

---

## 🚫 Specify優先実行フロー（必須）

### STEP 1 [MUST]: 要件定義（Specify）→ STEP 2-4 [MUST] → STEP 5 [ONLY THEN]

**前提条件**: requirements.md なし → 実装禁止  
**実行内容**: What/Why のみ定義 + 品質ゲート合格確認  
**出力**: 01_specify/<request-folder>/requirements.md

---

## ❌ 禁止事項

- ❌ RPO/RTO 未定義でのバックアップ実装
- ❌ Specify段階でのバックアップツール導入
- ❌ 品質ゲート不合格での次工程進行

---

**最終原則**: 「仕様なき実装は許さず。常に仕様駆動で。」

---

## STEP 3: 03_tasks/<request-folder>/tasks.md
**目的**: バックアップ・DR をタスク粒度に分解

**生成内容（テンプレート）**:
```markdown
# バックアップ・DR タスク一覧

| タスクID | タスク名 | 担当者 | 期限 | 優先度 | 依存 |
|---------|---------|-------|------|-------|------|
| BKP-01 | バックアップツール選定・構築 | <Team> | D+3 | 高 | - |
| BKP-02 | DR 環境構築と復旧手順確立 | <Team> | D+4 | 中 | BKP-01 |
| BKP-03 | ステージング環境での動作確認 | <Team> | D+5 | 高 | BKP-02 |
| BKP-04 | 本番環境への適用 | <Team> | D+6 | 高 | BKP-03 |
| BKP-05 | インフラチームトレーニング | <Team> | D+7 | 中 | BKP-04 |
```

**実行指示**:
1. 02_plan のストレージ戦略 から逆算してタスク化
2. 依存関係を明示
3. 担当者不明な場合は <TBD> で記載
4. 期限は要件の期限から逆算

---

### STEP 3-B: コード生成フェーズ（新規）
**目的**: タスク分解に基づいて実装コードを生成

**実行指示**:
1. 03_tasks/<request-folder>/tasks.md を入力として読み込み
2. サブエージェント `sdd-code-generator-cat08` を起動
3. 出力：
	- `scripts/<request-folder>/backup-dr.py` または `.sh`（実装コード）
	- `scripts/<request-folder>/build.log`（ビルド結果）
4. 04_implement/<request-folder>/implement.md に「実装成果物」セクションで参照

---

### STEP 3-C: 検証実行フェーズ（新規）
**目的**: 生成されたアプリに対して受入検証を実行

**実行指示**:
1. 生成されたアプリ + requirements.md 内の受入条件 を入力
2. サブエージェント `sdd-verifier-cat08` を起動
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
