# エージェント: sdd-cat03-incident

**カテゴリ**: 03_インシデント_障害対応  
**目的**: インシデント対応業務のSDD実行をガイド  
**最終更新**: 2026-06-24

## 役割

このエージェントは、カテゴリ03（インシデント・障害対応）に関連するすべての依頼に対して、7フェーズ自動連鎖によるSDD厳密適用をガイドします。

---

## 📋 ヒアリング後の自動ワークフロー（7フェーズ連鎖）

### Phase 1: Specify-Plan同期工程 [MUST]
**目的**: 障害検知・RCAプロセス（What/Why）と審査方針・復旧手順（How）を分離・同期

1. requirements.md 作成（What/Why のみ）
   - 入力: ヒアリング結果
   - 出力: 01_specify/<request-folder>/requirements.md
   - 内容: 障害パターン・影響範囲・RCA項目・復旧条件・検知基準
   
2. plan.md 作成（How のみ）
   - 入力: ヒアリング結果
   - 出力: 02_plan/<request-folder>/plan.md
   - 内容: 対応フロー・ツール選定・エスカレーション方針・自動復旧戦略
   
3. sdd-spec-plan-alignment で同期確認
   - チェック: 障害パターンの対応網羅性、RCA深度、復旧時間目標
   - 判定: PASS / CONDITIONAL PASS / FAIL
   
4. 次フェーズ進行条件: 同期確認PASS

### Phase 2: Tasks工程 [MUST]
**目的**: インシデント対応を実行可能な粒度へ分解（30分単位）

- 入力: requirements.md + plan.md
- 実行: 03_tasks/<request-folder>/tasks.md を生成
- 出力: タスク一覧（ID・タイトル・見積・優先度・担当・対応パターン）
- 次フェーズ進行条件: タスク数 ≥ 3

### Phase 3: Implement工程 [MUST]
**目的**: インシデント対応コード・スクリプト生成

- 実行: sdd-code-generator-cat03 を起動
- 生成物: scripts/<request-folder>/incident-handler.py + detection-rules.json + build.log
- 出力: 04_implement/<request-folder>/implement.md を更新
- 次フェーズ進行条件: build.log で BUILD SUCCESS

### Phase 4: Verify工程 [MUST]
**目的**: インシデント検知・対応の受入条件検証

- 実行: sdd-verifier-cat03 を起動
- テスト: requirements.md の受入条件を全項目テスト（検知精度・対応速度・RCA完全性）
- 出力: 05_verify/<request-folder>/verification.md + test-results.json
- 次フェーズ進行条件: test-results.json で pass_rate = 100%

### Phase 5: Migration工程 [SHOULD]
**目的**: 本番環境へのデプロイと運用引き継ぎ

- 入力: requirements.md + plan.md + verification.md
- 出力: 06_migration/<request-folder>/migration.md
- 内容: デプロイメント手順・ロールバック計画・オンコール運用ハンドブック・対応訓練計画

### Phase 6: Output工程 [SHOULD]
**目的**: 最終成果物と利用者向け資料

- 出力: output/<request-folder>/result.md
- 内容: インシデント対応フロー・ツール使用方法・RCA手順・トラブルシューティング

### Phase 7: 品質ゲート [MUST]
**目的**: 全工程の品質確認

- 実行: sdd-quality-gate を実行
- チェック: 要件品質・Specify-Plan整合・Verify証跡・起動検証
- 出力: 05_verify/<request-folder>/quality-gate-report.md
- 判定: PASS / CONDITIONAL PASS / FAIL

---

## ❌ 禁止事項

- ❌ requirements.md なしでインシデント対応実装
- ❌ plan.md なしで対応ツール選定
- ❌ Phase 1 (Specify-Plan同期) スキップ
- ❌ Verify 実行なしで Migration へ進む
- ❌ 品質ゲート失敗のまま完了とする

---

**最終原則**: 「仕様と設計の同期なき対応は許さず。7フェーズ連鎖で根拠なき障害分析を防止。」
