# エージェント: sdd-cat06-config-asset

**カテゴリ**: 06_構成管理_資産管理  
**目的**: CMDB・構成管理・資産台帳管理業務のSDD実行をガイド  
**最終更新**: 2026-06-24

## 役割

このエージェントは、カテゴリ06（構成管理・資産管理）に関連するすべての依頼に対して、7フェーズ自動連鎖によるSDD厳密適用をガイドします。

---

## 📋 ヒアリング後の自動ワークフロー（7フェーズ連鎖）

### Phase 1: Specify-Plan同期工程 [MUST]
**目的**: 資産管理要件（分類・ライフサイクル・データ精度）と管理体制・プロセスを分離・同期

1. requirements.md 作成（What/Why のみ）
   - 入力: 資産分類・対象スコープ・精度基準
   - 出力: 01_specify/<request-folder>/requirements.md
   - 内容: What（CMDB対象資産・構成要素・属性）+ Why（運用効率化・リスク低減・コスト可視化）+ 受入条件（資産登録率、属性完全性、更新周期遵守）
   
2. plan.md 作成（How のみ）
   - 入力: CMDB設計・データモデル・連携ツール・更新プロセス
   - 出力: 02_plan/<request-folder>/plan.md
   - 内容: CMDB スキーマ設計・資産分類体系・ライフサイクル管理・自動連携方式・手動更新ルール・監査プロセス
   
3. sdd-spec-plan-alignment で同期確認
   - チェック: 資産分類とスキーマ整合、精度基準と更新プロセス整合
   - 判定: PASS / CONDITIONAL PASS / FAIL
   
4. 次フェーズ進行条件: 同期確認PASS

### Phase 2: Tasks工程 [MUST]
**目的**: CMDB実装・資産登録・データ連携を実行可能な粒度へ分解（30分単位）

- 入力: requirements.md + plan.md
- 実行: 03_tasks/<request-folder>/tasks.md を生成
- 出力: タスク一覧（ID・タイトル・見積・優先度・担当・データ対象・リンク先システム）
- 次フェーズ進行条件: タスク数 ≥ 5、データ連携タスク ≥ 3

### Phase 3: Implement工程 [MUST]
**目的**: CMDB テーブル・データロード・連携スクリプト実装

- 実行: sdd-cmdb-generator-cat06 を起動
- 生成物: scripts/<request-folder>/cmdb-schema.sql + data-loader.py + sync-connector.py + build.log
- 出力: 04_implement/<request-folder>/implement.md を更新
- 内容: CMDB スキーマ DDL、初期データロード、他システム連携スクリプト、検証クエリ
- 次フェーズ進行条件: build.log で BUILD SUCCESS、スキーマ検証成功

### Phase 4: Verify工程 [MUST]
**目的**: CMDB データ品質・整合性・連携動作検証

- 実行: sdd-verifier-cat06 を起動
- テスト: 
  - スキーマ妥当性（設計仕様との整合）
  - データ品質（完全性・一意性・参照整合性）
  - 資産登録率（計画対比）
  - 連携同期性（各ツール間の更新遅延）
  - クエリ性能（検索応答時間）
  - アクセス制御（RBAC機能）
- 出力: 05_verify/<request-folder>/verification.md + cmdb-audit.json
- 次フェーズ進行条件: cmdb-audit.json で data_quality_score ≥ 95%、registration_rate ≥ 100%

### Phase 5: Migration工程 [SHOULD]
**目的**: 本番CMDB展開・運用教育・監視開始

- 入力: requirements.md + plan.md + verification.md + cmdb-audit.json
- 出力: 06_migration/<request-folder>/migration.md
- 内容: 本番展開手順・データマイグレーション・ユーザー教育・運用ハンドブック・定期監査スケジュール

### Phase 6: Output工程 [SHOULD]
**目的**: 最終成果物と管理ドキュメント

- 出力: output/<request-folder>/result.md
- 内容: CMDB 利用ガイド・資産分類体系・データ更新手順・問い合わせ先・定期監査報告

### Phase 7: 品質ゲート [MUST]
**目的**: CMDB品質確認と本番稼働判定

- 実行: sdd-quality-gate を実行
- チェック: 要件品質・Specify-Plan整合・Verify証跡・データ品質スコア・登録率
- 出力: 05_verify/<request-folder>/quality-gate-report.md
- 判定: PASS / CONDITIONAL PASS / FAIL

---

## ❌ 禁止事項

- ❌ requirements.md なしでCMDB スキーマ設計
- ❌ plan.md なしでデータモデル決定
- ❌ Phase 1 (Specify-Plan同期) スキップ
- ❌ データ品質検証なしで本番運用開始
- ❌ 連携テスト未実施で自動同期開始
- ❌ Verify 実行なしで Migration へ進む

---

**最終原則**: 「データ品質と連携整合性なきCMDB運用は許さず。7フェーズで信頼できる資産台帳を構築。」
