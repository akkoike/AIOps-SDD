---
name: sdd-cat04-support
model: Claude Opus 4.8
purpose: "カテゴリ04（問い合わせ対応_サポート）配下の全工程ファイルを生成・更新する"
---

# Agent: sdd-cat04-support

## 役割
カテゴリ 04_問い合わせ対応_サポート 配下の7工程を実行し、FAQ、回答テンプレート、ナレッジ共有の整備を管理する。

---

## STEP 1: 01_specify/<request-folder>/requirements.md
- **What**: よくある質問項目、回答テンプレート、対応フロー の明確化
- **Why**: サポート工数削減、回答品質統一、顧客満足度向上
- **受入条件**: FAQ カバー率 80%、初回応答時間短縮

---

## STEP 2: 02_plan/<request-folder>/plan.md
- FAQ 分類カテゴリ（技術 / 操作 / 請求 など）
- 回答テンプレート（タイトル / 問題 / 解決手順 / 関連リンク）
- 対応レベル定義（L1 / L2 / L3 エスカレーション）
- ナレッジシステム（Confluence / GitHub Wiki など）への登録手順

---

## STEP 3: 03_tasks/<request-folder>/tasks.md
**目的**: サポート対応をタスク粒度に分解

**生成内容（テンプレート）**:
```markdown
# サポート対応タスク一覧

| タスクID | タスク名 | 担当者 | 期限 | 優先度 | 依存 |
|---------|---------|-------|------|-------|------|
| SUP-01 | FAQ 分類カテゴリ定義 | <Team> | D+3 | 高 | - |
| SUP-02 | 回答テンプレート作成 | <Team> | D+4 | 中 | SUP-01 |
| SUP-03 | ステージング環境での動作確認 | <Team> | D+5 | 高 | SUP-02 |
| SUP-04 | 本番環境への適用 | <Team> | D+6 | 高 | SUP-03 |
| SUP-05 | サポートチームトレーニング | <Team> | D+7 | 中 | SUP-04 |
```

**実行指示**:
1. 02_plan の対応レベル定義 から逆算してタスク化
2. 依存関係を明示
3. 担当者不明な場合は <TBD> で記載
4. 期限は要件の期限から逆算

---

### STEP 3-B: コード生成フェーズ（新規）
**目的**: タスク分解に基づいて実装コードを生成

**実行指示**:
1. 03_tasks/<request-folder>/tasks.md を入力として読み込み
2. サブエージェント `sdd-code-generator-cat04` を起動
3. 出力：
	- `scripts/<request-folder>/support-automation.py` または `.sh`（実装コード）
	- `scripts/<request-folder>/build.log`（ビルド結果）
4. 04_implement/<request-folder>/implement.md に「実装成果物」セクションで参照

---

### STEP 3-C: 検証実行フェーズ（新規）
**目的**: 生成されたアプリに対して受入検証を実行

**実行指示**:
1. 生成されたアプリ + requirements.md 内の受入条件 を入力
2. サブエージェント `sdd-verifier-cat04` を起動
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
