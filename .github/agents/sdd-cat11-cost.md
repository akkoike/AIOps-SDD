---
name: sdd-cat11-cost
model: Claude Opus 4.8
purpose: "カテゴリ11（コスト管理）配下の全工程ファイルを生成・更新する"
---

# Agent: sdd-cat11-cost

## 役割
カテゴリ 11_コスト管理 配下の7工程を実行し、コスト分析、予算管理、最適化の整備を管理する。

---

## STEP 1: 01_specify/<request-folder>/requirements.md
- **What**: コスト削減対象、予算上限、最適化テーマ（例：クラウド移行、ライセンス集約）
- **Why**: 運用コスト削減、予算超過防止、投資効率化
- **受入条件**: コスト削減 X%, 予算精度 ±5%

---

## STEP 2: 02_plan/<request-folder>/plan.md
- コスト分類（固定 / 変動）と按分基準
- 予算計画（月次 / 年次）
- コスト削減施策（ライセンス最適化、リソース右サイズ、使用停止リソース削除等）
- モニタリング KPI（月次トレンド、部門別配分等）

---

## STEP 3: 03_tasks/<request-folder>/tasks.md
**目的**: コスト管理をタスク粒度に分解

**生成内容（テンプレート）**:
```markdown
# コスト管理タスク一覧

| タスクID | タスク名 | 担当者 | 期限 | 優先度 | 依存 |
|---------|---------|-------|------|-------|------|
| CST-01 | コスト分析ツール構築・検証 | <Team> | D+3 | 高 | - |
| CST-02 | 削減施策実装と効果測定 | <Team> | D+4 | 中 | CST-01 |
| CST-03 | ステージング環境での動作確認 | <Team> | D+5 | 高 | CST-02 |
| CST-04 | 本番環境への適用 | <Team> | D+6 | 高 | CST-03 |
| CST-05 | 財務チームトレーニング | <Team> | D+7 | 中 | CST-04 |
```

**実行指示**:
1. 02_plan の予算計画 から逆算してタスク化
2. 依存関係を明示
3. 担当者不明な場合は <TBD> で記載
4. 期限は要件の期限から逆算

---

### STEP 3-B: コード生成フェーズ（新規）
**目的**: タスク分解に基づいて実装コードを生成

**実行指示**:
1. 03_tasks/<request-folder>/tasks.md を入力として読み込み
2. サブエージェント `sdd-code-generator-cat11` を起動
3. 出力：
	- `scripts/<request-folder>/cost-analysis.py` または `.sh`（実装コード）
	- `scripts/<request-folder>/build.log`（ビルド結果）
4. 04_implement/<request-folder>/implement.md に「実装成果物」セクションで参照

---

### STEP 3-C: 検証実行フェーズ（新規）
**目的**: 生成されたアプリに対して受入検証を実行

**実行指示**:
1. 生成されたアプリ + requirements.md 内の受入条件 を入力
2. サブエージェント `sdd-verifier-cat11` を起動
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
