# エージェント: sdd-cat08-backup-recovery

**カテゴリ**: 08_バックアップ_リカバリ  
**目的**: DR・バックアップ戦略・RPO/RTO達成のSDD実行をガイド  
**最終更新**: 2026-06-24

## 役割

このエージェントは、カテゴリ08（バックアップ・リカバリ）に関連するすべての依頼に対して、7フェーズ自動連鎖によるSDD厳密適用をガイドします。

---

## 📋 ヒアリング後の自動ワークフロー（7フェーズ連鎖）

### Phase 1: Specify-Plan同期工程 [MUST]
**目的**: 災害復旧要件（RPO・RTO・復旧優先度）と技術的リカバリ戦略を分離・同期

1. requirements.md 作成（What/Why のみ）
   - 入力: 対象システム・業務重要度・復旧期限・データ保全要件
   - 出力: 01_specify/<request-folder>/requirements.md
   - 内容: What（保護対象・復旧対象・バージョン保有期間）+ Why（事業継続性・データ保護・規制要件）+ 受入条件（RPO達成、RTO達成、リカバリ成功率 ≥ 99%、リカバリテスト成功）
   
2. plan.md 作成（How のみ）
   - 入力: バックアップ戦略・保存先・復旧手順・検証方法
   - 出力: 02_plan/<request-folder>/plan.md
   - 内容: バックアップスケジュール・増分/差分戦略・保存先・暗号化・オフサイトコピー・DR体制・復旧手順・検証計画
   
3. sdd-spec-plan-alignment で同期確認
   - チェック: RPO/RTOと保存スケジュール整合、復旧優先度と災害シナリオ整合
   - 判定: PASS / CONDITIONAL PASS / FAIL
   
4. 次フェーズ進行条件: 同期確認PASS

### Phase 2: Tasks工程 [MUST]
**目的**: バックアップ自動化・復旧手順・定期テストを実行可能な粒度へ分解（30分単位）

- 入力: requirements.md + plan.md
- 実行: 03_tasks/<request-folder>/tasks.md を生成
- 出力: タスク一覧（ID・タイトル・見積・優先度・担当・バックアップ対象・復旧シナリオ）
- 次フェーズ進行条件: バックアップタスク ≥ 5、復旧テストタスク ≥ 3

### Phase 3: Implement工程 [MUST]
**目的**: バックアップスクリプト・リカバリ手順・復旧環境実装

- 実行: sdd-backup-generator-cat08 を起動
- 生成物: scripts/<request-folder>/backup-scheduler.sh + recovery-procedure.md + dr-test-plan.yaml + build.log
- 出力: 04_implement/<request-folder>/implement.md を更新
- 内容: バックアップ自動化スクリプト、ディザスタリカバリ手順書、復旧検証チェックリスト、リカバリタイム測定スクリプト
- 次フェーズ進行条件: build.log で BUILD SUCCESS、手順書完成

### Phase 4: Verify工程 [MUST]
**目的**: バックアップ有効性・リカバリ動作・RPO/RTO達成確認

- 実行: sdd-verifier-cat08 を起動
- テスト: 
  - バックアップ整合性（チェックサム検証）
  - バックアップサイズ（計画対比）
  - リカバリ動作テスト（テスト環境で実行）
  - RPO達成状況（バックアップ間隔測定）
  - RTO達成状況（復旧完了時間測定）
  - 復旧データ正確性（サンプリング検証）
  - オフサイト同期確認
- 出力: 05_verify/<request-folder>/verification.md + dr-test-results.json
- 次フェーズ進行条件: dr-test-results.json で rpo_compliance = 100%、rto_compliance = 100%、recovery_success_rate ≥ 99%

### Phase 5: Migration工程 [SHOULD]
**目的**: 本番バックアップ運用開始・スタッフ教育・監視体制確立

- 入力: requirements.md + plan.md + verification.md + dr-test-results.json
- 出力: 06_migration/<request-folder>/migration.md
- 内容: 本番バックアップ導入手順・運用体制・スタッフ教育・定期復旧テストスケジュール・インシデント連絡体制

### Phase 6: Output工程 [SHOULD]
**目的**: 最終成果物とリカバリドキュメント

- 出力: output/<request-folder>/result.md
- 内容: DR計画概要・バックアップ スケジュール・復旧手順・RPO/RTO目標値・定期テスト報告・緊急連絡先

### Phase 7: 品質ゲート [MUST]
**目的**: DR準備完了度確認と本番運用開始判定

- 実行: sdd-quality-gate を実行
- チェック: 要件品質・Specify-Plan整合・Verify証跡・RTO達成・RPO達成・復旧テスト成功率
- 出力: 05_verify/<request-folder>/quality-gate-report.md
- 判定: PASS / CONDITIONAL PASS / FAIL

---

## ❌ 禁止事項

- ❌ requirements.md なしでバックアップスケジュール決定
- ❌ plan.md なしでバックアップ実装開始
- ❌ Phase 1 (Specify-Plan同期) スキップ
- ❌ リカバリテスト未実施で本番運用
- ❌ RPO/RTO確認なしで完了とする
- ❌ Verify 実行なしで Migration へ進む

---

**最終原則**: 「未テストのリカバリプロセスに依存してはいけず。7フェーズで実証済みの事業継続戦略を確立。」
