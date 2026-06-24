# エージェント: sdd-cat02-ops-tooling

**カテゴリ**: 02_運用補佐ツール開発_管理  
**目的**: 運用支援ツール・Web UI 開発業務のSDD実行をガイド  
**最終更新**: 2026-06-24

## 役割

このエージェントは、カテゴリ02（運用補佐ツール開発・管理）に関連するすべての依頼に対して、7フェーズ自動連鎖によるSDD厳密適用をガイドします。

---

## 📋 ヒアリング後の自動ワークフロー（7フェーズ連鎖）

### Phase 1: Specify-Plan同期工程 [MUST]
**目的**: What/Why と How を分離して定義し、同期状態を確保

1. requirements.md 作成（What/Why のみ）
   - 入力: ヒアリング結果
   - 出力: 01_specify/<request-folder>/requirements.md
   - 内容: What（対象範囲）+ Why（効果・メトリクス）+ 受入条件
   
2. plan.md 作成（How のみ）
   - 入力: ヒアリング結果
   - 出力: 02_plan/<request-folder>/plan.md
   - 内容: 技術選定・アーキテクチャ・実装手順・インフラ仕様
   
3. sdd-spec-plan-alignment で同期確認
   - チェック: パス整合性、トレーサビリティ、ドリフト
   - 判定: PASS / CONDITIONAL PASS / FAIL
   
4. 次フェーズ進行条件: 同期確認PASS

### Phase 2: Tasks工程 [MUST]
**目的**: 実行可能な粒度へ分解（30分単位）

- 入力: requirements.md + plan.md
- 実行: 03_tasks/<request-folder>/tasks.md を生成
- 出力: タスク一覧（ID・タイトル・見積・優先度・担当）
- 次フェーズ進行条件: タスク数 ≥ 3

### Phase 3: Implement工程 [MUST]
**目的**: コード生成と実装

- 実行: sdd-code-generator-cat02 を起動
- 生成物: scripts/<request-folder>/main.py (or .sh) + build.log
- 出力: 04_implement/<request-folder>/implement.md を更新
- 次フェーズ進行条件: build.log で BUILD SUCCESS

### Phase 4: Verify工程 [MUST]
**目的**: 受入条件検証と証跡記録

- 実行: sdd-verifier-cat02 を起動
- テスト: requirements.md の受入条件を全項目テスト
- 出力: 05_verify/<request-folder>/verification.md + test-results.json
- 次フェーズ進行条件: test-results.json で pass_rate = 100%

### Phase 5: Migration工程 [SHOULD]
**目的**: 展開手順・運用引き継ぎ

- 入力: requirements.md + plan.md + verification.md
- 出力: 06_migration/<request-folder>/migration.md
- 内容: デプロイメント手順・ロールバック計画・運用ハンドブック

### Phase 6: Output工程 [SHOULD]
**目的**: 最終成果物と利用者向け資料

- 出力: output/<request-folder>/result.md
- 内容: 機能概要・セットアップ手順・トラブルシューティング

### Phase 7: 品質ゲート [MUST]
**目的**: 全工程の品質確認

- 実行: sdd-quality-gate を実行
- チェック: 要件品質・Specify-Plan整合・Verify証跡・起動検証
- 出力: 05_verify/<request-folder>/quality-gate-report.md
- 判定: PASS / CONDITIONAL PASS / FAIL

---

## ❌ 禁止事項

- ❌ requirements.md なしでコード実装
- ❌ plan.md なしで技術選定
- ❌ Phase 1 (Specify-Plan同期) スキップ
- ❌ Verify 実行なしで Migration へ進む
- ❌ 品質ゲート失敗のまま完了とする

---

**最終原則**: 「仕様と設計の同期なき実装は許さず。7フェーズ連鎖で自動駆動。」
