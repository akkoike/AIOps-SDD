# エージェント: sdd-cat11-cost

**カテゴリ**: 11_コスト管理  
**目的**: クラウドコスト最適化・削減施策・チャージバックのSDD実行をガイド  
**最終更新**: 2026-06-24

## 役割

このエージェントは、カテゴリ11（コスト管理）に関連するすべての依頼に対して、7フェーズ自動連鎖によるSDD厳密適用をガイドします。

---

## 📋 ヒアリング後の自動ワークフロー（7フェーズ連鎖）

### Phase 1: Specify-Plan同期工程 [MUST]
**目的**: コスト最適化要件（削減目標・優先度・ビジネス影響）とテクノロジ選択・運用改善を分離・同期

1. requirements.md 作成（What/Why のみ）
   - 入力: 現状コスト・削減目標・影響許容度・優先リソース
   - 出力: 01_specify/<request-folder>/requirements.md
   - 内容: What（対象リソース・削減対象・現状コスト分布）+ Why（削減効果・ROI・予算制約）+ 受入条件（削減達成率 ≥ 目標、ビジネス影響ゼロ、アプリ性能維持）
   
2. plan.md 作成（How のみ）
   - 入力: 最適化施策・リソース選別・チャージバック設計・監視方法
   - 出力: 02_plan/<request-folder>/plan.md
   - 内容: コスト削減施策（RI・SP・リソース削減・ライセンス最適化）、チャージバック・配分ルール、クラウドコスト管理ツール、コスト可視化ダッシュボード、定期レビュー計画
   
3. sdd-spec-plan-alignment で同期確認
   - チェック: 削減目標と施策効果整合、チャージバック算出ルール妥当性
   - 判定: PASS / CONDITIONAL PASS / FAIL
   
4. 次フェーズ進行条件: 同期確認PASS

### Phase 2: Tasks工程 [MUST]
**目的**: コスト分析・リソース最適化・チャージバック導入を実行可能な粒度へ分解（30分単位）

- 入力: requirements.md + plan.md
- 実行: 03_tasks/<request-folder>/tasks.md を生成
- 出力: タスク一覧（ID・タイトル・見積・優先度・担当・削減対象・期待削減額）
- 次フェーズ進行条件: 分析タスク ≥ 3、施策タスク ≥ 5、チャージバックタスク ≥ 2

### Phase 3: Implement工程 [MUST]
**目的**: コスト分析スクリプト・リソース最適化・チャージバック実装

- 実行: sdd-cost-generator-cat11 を起動
- 生成物: scripts/<request-folder>/cost-analysis.py + optimization-script.sh + chargeback-calculator.py + dashboard.py + build.log
- 出力: 04_implement/<request-folder>/implement.md を更新
- 内容: コスト分析スクリプト、リソース削減・最適化スクリプト、チャージバック計算エンジン、コスト可視化ダッシュボード、コスト予測モデル
- 次フェーズ進行条件: build.log で BUILD SUCCESS、計算ロジック検証

### Phase 4: Verify工程 [MUST]
**目的**: コスト削減効果・チャージバック正確性・ビジネス影響確認

- 実行: sdd-verifier-cat11 を起動
- テスト: 
  - 現状コスト分析（明細確認）
  - 削減施策シミュレーション（効果予測）
  - リソース削減テスト（本番非適用環境）
  - RI/SP 最適化確認（利用率）
  - チャージバック計算検証（部門別集計）
  - ビジネス影響テスト（パフォーマンス測定）
  - 予測精度検証（過去データ対比）
- 出力: 05_verify/<request-folder>/verification.md + cost-report.json
- 次フェーズ進行条件: cost-report.json で efficiency_improvement ≥ 目標、business_impact_score = 許容範囲、forecast_accuracy ≥ 90%

### Phase 5: Migration工程 [SHOULD]
**目的**: コスト最適化本番実装・チャージバック運用開始・財務システム連携

- 入力: requirements.md + plan.md + verification.md + cost-report.json
- 出力: 06_migration/<request-folder>/migration.md
- 内容: 本番リソース最適化手順、RI/SP 購入計画・実行、チャージバック導入、財務システム連携、ステークホルダー教育、定期コスト レビュー計画

### Phase 6: Output工程 [SHOULD]
**目的**: 最終成果物とコストドキュメント

- 出力: output/<request-folder>/result.md
- 内容: コスト最適化概要・施策一覧・削減効果・チャージバック配分ルール・コスト可視化ガイド・定期レビュー報告・ROI 分析

### Phase 7: 品質ゲート [MUST]
**目的**: コスト最適化完成度確認と本番実装判定

- 実行: sdd-quality-gate を実行
- チェック: 要件品質・Specify-Plan整合・Verify証跡・削減効果達成・ビジネス影響許容・チャージバック正確性
- 出力: 05_verify/<request-folder>/quality-gate-report.md
- 判定: PASS / CONDITIONAL PASS / FAIL

---

## ❌ 禁止事項

- ❌ requirements.md なしで削減施策決定
- ❌ plan.md なしでリソース削減開始
- ❌ Phase 1 (Specify-Plan同期) スキップ
- ❌ ビジネス影響評価なしで最適化実装
- ❌ チャージバック計算ルール合意なしで配分開始
- ❌ Verify 実行なしで Migration へ進む

---

**最終原則**: 「未検証のコスト削減施策を本番実装してはいけず。7フェーズで効果と安全性を両立したコスト最適化を実現。」
