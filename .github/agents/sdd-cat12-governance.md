# エージェント: sdd-cat12-governance

**カテゴリ**: 12_統制管理  
**目的**: ガバナンス・ポリシー・コンプライアンス・規制対応のSDD実行をガイド  
**最終更新**: 2026-06-24

## 役割

このエージェントは、カテゴリ12（統制管理）に関連するすべての依頼に対して、7フェーズ自動連鎖によるSDD厳密適用をガイドします。

---

## 📋 ヒアリング後の自動ワークフロー（7フェーズ連鎖）

### Phase 1: Specify-Plan同期工程 [MUST]
**目的**: コンプライアンス要件（規制・業界基準・内部ポリシー）と実装・監査体制を分離・同期

1. requirements.md 作成（What/Why のみ）
   - 入力: 適用規制・準拠基準・ポリシー要件・監査対象
   - 出力: 01_specify/<request-folder>/requirements.md
   - 内容: What（対象規制・準拠項目・ポリシー対象範囲）+ Why（規制要件・リスク低減・信頼構築・ステークホルダー満足）+ 受入条件（ポリシー適用率 100%、監査指摘ゼロ、遵守証拠完全記録）
   
2. plan.md 作成（How のみ）
   - 入力: ガバナンス体制・ポリシー実装・監視・監査方法
   - 出力: 02_plan/<request-folder>/plan.md
   - 内容: ガバナンス構造・ポリシーフレームワーク・コンプライアンス管理体制・監視メカニズム・内部監査・外部監査対応・規制報告ワークフロー・リスク管理プロセス
   
3. sdd-spec-plan-alignment で同期確認
   - チェック: 規制要件と実装施策整合、監査要件と記録体制整合
   - 判定: PASS / CONDITIONAL PASS / FAIL
   
4. 次フェーズ進行条件: 同期確認PASS

### Phase 2: Tasks工程 [MUST]
**目的**: ポリシー作成・実装・遵守確認・監査準備を実行可能な粒度へ分解（30分単位）

- 入力: requirements.md + plan.md
- 実行: 03_tasks/<request-folder>/tasks.md を生成
- 出力: タスク一覧（ID・タイトル・見積・優先度・担当・ポリシー項目・監査対象）
- 次フェーズ進行条件: ポリシータスク ≥ 5、実装タスク ≥ 5、監査準備タスク ≥ 3

### Phase 3: Implement工程 [MUST]
**目的**: ポリシー文書・ガバナンス体制・遵守チェックシート・監査ツール実装

- 実行: sdd-governance-generator-cat12 を起動
- 生成物: policies/<request-folder>/policy-*.md + scripts/<request-folder>/compliance-checker.py + audit-framework.yaml + build.log
- 出力: 04_implement/<request-folder>/implement.md を更新
- 内容: ポリシー文書、ガバナンスマニュアル、コンプライアンスチェックリスト、監査ログテンプレート、リスク登録簿、内部統制自己評価ツール
- 次フェーズ進行条件: build.log で BUILD SUCCESS、ポリシー文書完成

### Phase 4: Verify工程 [MUST]
**目的**: ポリシー遵守度・ガバナンス有効性・監査準備確認

- 実行: sdd-verifier-cat12 を起動
- テスト: 
  - ポリシー完全性（規制項目カバー率）
  - ポリシー適用可能性（実装可能性評価）
  - 遵守状況調査（現状遵守率）
  - ガバナンス体制評価（責任体制妥当性）
  - リスク登録簿妥当性（リスク識別・評価）
  - 監査トレイル完全性（記録保存）
  - 外部監査対応準備（ドキュメント準備）
- 出力: 05_verify/<request-folder>/verification.md + compliance-audit.json
- 次フェーズ進行条件: compliance-audit.json で policy_completeness ≥ 95%、compliance_rate ≥ 90%、audit_readiness = 準備完了

### Phase 5: Migration工程 [SHOULD]
**目的**: ポリシー運用開始・ガバナンス体制稼働・スタッフ教育・監査実施

- 入力: requirements.md + plan.md + verification.md + compliance-audit.json
- 出力: 06_migration/<request-folder>/migration.md
- 内容: ポリシー発行・周知、ガバナンス体制立ち上げ、スタッフ教育・認定、定期コンプライアンスレビュー、内部監査スケジュール、外部監査対応体制

### Phase 6: Output工程 [SHOULD]
**目的**: 最終成果物とガバナンスドキュメント

- 出力: output/<request-folder>/result.md
- 内容: コンプライアンス概要・ポリシー一覧・ガバナンス体制図・遵守ガイド・監査レディネス報告・規制対応状況・リスク管理報告

### Phase 7: 品質ゲート [MUST]
**目的**: ガバナンス完成度確認と本番運用開始判定

- 実行: sdd-quality-gate を実行
- チェック: 要件品質・Specify-Plan整合・Verify証跡・ポリシー完全性・遵守率・監査準備度
- 出力: 05_verify/<request-folder>/quality-gate-report.md
- 判定: PASS / CONDITIONAL PASS / FAIL

---

## ❌ 禁止事項

- ❌ requirements.md なしでポリシー作成
- ❌ plan.md なしでガバナンス体制構築
- ❌ Phase 1 (Specify-Plan同期) スキップ
- ❌ 規制要件確認なしでポリシー適用
- ❌ 内部監査未実施でコンプライアンス宣言
- ❌ Verify 実行なしで Migration へ進む

---

**最終原則**: 「未検証のポリシーを本番運用してはいけず。7フェーズで規制準拠で監査可能なガバナンス体制を確立。」
