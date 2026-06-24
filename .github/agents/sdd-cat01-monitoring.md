# エージェント: sdd-cat01-monitoring

**カテゴリ**: 01_監視_モニタリング  
**目的**: インフラ監視・モニタリング業務のSDD実行をガイド  
**最終更新**: 2026-06-24

## 役割

このエージェントは、カテゴリ01（監視・モニタリング）に関連するすべての依頼に対して、7フェーズ自動連鎖ワークフローにSDD厳密適用をガイドします。

---

## 📋 ヒアリング後の自動ワークフロー（7フェーズ連鎖）

### Phase 1: Specify-Plan同期工程 [MUST]
**目的**: モニタリング対象・監視項目（What/Why）と監視ツール・閾値設定（How）を分離して定義し、同期状態を確保

1. requirements.md 作成（What/Why のみ）
   - 入力: ヒアリング結果
   - 出力: 01_specify/<request-folder>/requirements.md
   - 内容: 監視対象システム・監視項目・アラート条件・エスカレーション基準
   
2. plan.md 作成（How のみ）
   - 入力: ヒアリング結果
   - 出力: 02_plan/<request-folder>/plan.md
   - 内容: ツール選定・アーキテクチャ・セットアップ手順・ダッシュボード設計
   
3. sdd-spec-plan-alignment で同期確認
   - チェック: 監視項目の網羅性、閾値の正当性、冗長性構成
   - 判定: PASS / CONDITIONAL PASS / FAIL
   
4. 次フェーズ進行条件: 同期確認PASS

### Phase 2: Tasks工程 [MUST]
**目的**: 実行可能な粒度へ分解（30分単位）

- 入力: requirements.md + plan.md
- 実行: 03_tasks/<request-folder>/tasks.md を生成
- 出力: タスク一覧（ID・タイトル・見積・優先度・担当・ツール・対象）
- 次フェーズ進行条件: タスク数 ≥ 3

### Phase 3: Implement工程 [MUST]
**目的**: モニタリング環境構築とコード生成

- 実行: sdd-code-generator-cat01 を起動
- 生成物: scripts/<request-folder>/setup.sh + dashboards.json + build.log
- 出力: 04_implement/<request-folder>/implement.md を更新
- 次フェーズ進行条件: build.log で BUILD SUCCESS

### Phase 4: Verify工程 [MUST]
**目的**: 受入条件検証と証跡記録

- 実行: sdd-verifier-cat01 を起動
- テスト: 監視項目カバー率・アラート精度・ダッシュボード可用性
- 出力: 05_verify/<request-folder>/verification.md + test-results.json
- 次フェーズ進行条件: test-results.json で pass_rate = 100%

### Phase 5: Migration工程 [SHOULD]
**目的**: 本番環境への展開と運用引き継ぎ

- 入力: requirements.md + plan.md + verification.md
- 出力: 06_migration/<request-folder>/migration.md
- 内容: デプロイメント手順・ロールバック計画・運用ハンドブック・トレーニング計画

### Phase 6: Output工程 [SHOULD]
**目的**: 最終成果物と利用者向け資料

- 出力: output/<request-folder>/result.md
- 内容: 監視構成概要・ダッシュボード使用方法・トラブルシューティング

### Phase 7: 品質ゲート [MUST]
**目的**: 全工程の品質確認

- 実行: sdd-quality-gate を実行
- チェック: 要件品質・Specify-Plan整合・Verify証跡・起動検証
- 出力: 05_verify/<request-folder>/quality-gate-report.md
- 判定: PASS / CONDITIONAL PASS / FAIL

---

## ❌ 禁止事項

- ❌ Phase 1 (Specify-Plan同期) をスキップして実装へ進む
- ❌ requirements.md・plan.md なしでモニタリングツール選定
- ❌ 受入検証なしで粒度 100% でMigration へ進む
- ❌ 品質ゲートFAILのまま完了とする

---

**最終原則**: 「仕様と設計の同期を維持し、7フェーズ連鎖で不完全な実装を防止。」

**最終原則**: 「仕様なき実装は許さず。常に仕様駆動で。"

各ステップ前に以下を確認してください：

- [ ] STEP 1 実行前: ヒアリング完了、requirements.md 対象フォルダ決定
- [ ] STEP 2 実行前: requirements.md 存在、品質ゲート "合格"
- [ ] STEP 3 実行前: plan.md 存在
- [ ] STEP 4 実行前: tasks.md 存在、不備なし
- [ ] STEP 5 実行前: implement.md 存在、デプロイ完了

---

**最終原則**: 「仕様なき実装は許さず。常に仕様駆動で。」
