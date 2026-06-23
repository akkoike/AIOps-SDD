---
name: agents-registry
purpose: "SDD Agent エコシステム - Phase 1-2（フェーズ1-2完了版）"
scope: "全エージェント集計、ルーティング、実装状況"
---

# Agent Registry: SDD エージェント完全マッピング

---

## 1. Agent: sdd-router（ルーター）

### 役割
- ユーザー依頼からカテゴリを判定する。
- 適切なカテゴリエージェントへ委譲する。
- 品質ゲートを実行する。

### ルーティング判定キーワード
- 監視 アラート ダッシュボード 異常検知 SLO 根拠トレーサビリティ:
  - カテゴリ: **01 監視_モニタリング**
  - 実行エージェント: **sdd-cat01-monitoring**
- 自動化 スクリプト ワークフロー DevOps CI/CD ツール開発:
  - カテゴリ: **02 運用補佐ツール開発_管理**
  - 実行エージェント: **sdd-cat02-ops-tooling**
- 障害 インシデント MTTR RCA エスカレーション:
  - カテゴリ: **03 インシデント_障害対応**
  - 実行エージェント: **sdd-cat03-incident**
- サポート FAQ ナレッジ 回答テンプレート ヘルプデスク:
  - カテゴリ: **04 問い合わせ対応_サポート**
  - 実行エージェント: **sdd-cat04-support**
- 変更 リリース CAB デプロイ リスク管理:
  - カテゴリ: **05 変更_リリース管理**
  - 実行エージェント: **sdd-cat05-change-release**
- 構成 資産 CMDB 差分検知 棚卸し:
  - カテゴリ: **06 構成管理_資産管理**
  - 実行エージェント: **sdd-cat06-config-asset**
- セキュリティ 脆弱性 ペネトレーション 暗号化 パッチ:
  - カテゴリ: **07 セキュリティ管理**
  - 実行エージェント: **sdd-cat07-security**
- バックアップ DR RPO RTO リカバリ 可用性:
  - カテゴリ: **08 バックアップ_リカバリ**
  - 実行エージェント: **sdd-cat08-backup-recovery**
- キャパシティ リソース 予測 スケーリング 拡張計画:
  - カテゴリ: **09 キャパシティ管理**
  - 実行エージェント: **sdd-cat09-capacity**
- 権限 RBAC アクセス IAM 認可 棚卸し:
  - カテゴリ: **10 権限管理**
  - 実行エージェント: **sdd-cat10-access**
- コスト 予算 請求分析 最適化 削減:
  - カテゴリ: **11 コスト管理**
  - 実行エージェント: **sdd-cat11-cost**
- 監査 内部統制 コンプライアンス 統制証跡:
  - カテゴリ: **12 統制管理**
  - 実行エージェント: **sdd-cat12-governance**
- 要件品質 整合 証跡 監査対応:
  - 品質ゲートを並走または最終工程で実行。
  - 実行エージェント: **sdd-quality-gate**

### 実行フロー
1. 依頼から目的、制約、期待成果物を抽出する。
2. カテゴリを判定する。
3. 該当カテゴリエージェントへ委譲する。
4. 品質ゲートを実行する。
5. 変更ファイルと次アクションをユーザーへ返す。

### 出力契約
- 必須出力:
  - 判定カテゴリ
  - 実行エージェント名
  - 対象ファイルパス
  - 完了条件チェック結果

---

## 2. Agent: sdd-hearing-subagent-sample（ヒアリング実行例）

### 役割
- ユーザー依頼を深掘りするためのヒアリング実行
- テンプレートベースの実行例を示す
- 各カテゴリの代表的なヒアリングフロー

---

## 3. Agent: sdd-category-executor（共通カテゴリ実行）

### 役割
- 判定されたカテゴリの成果物を作成 更新する。
- 仕様、設計、タスク、実装、受入、展開、output の全工程で一貫性を維持する。
- **実装**: 各カテゴリ別エージェント実装ファイルに委譲

### カテゴリ別エージェント実装ファイル（STEP 1-7 実行）
| カテゴリID | カテゴリ名 | 実装ファイル |
|-----------|-----------|-----------|
| 01 | 監視_モニタリング | [sdd-cat01-monitoring.md](../agents/sdd-cat01-monitoring.md) |
| 02 | 運用補佐ツール開発_管理 | [sdd-cat02-ops-tooling.md](../agents/sdd-cat02-ops-tooling.md) |
| 03 | インシデント_障害対応 | [sdd-cat03-incident.md](../agents/sdd-cat03-incident.md) |
| 04 | 問い合わせ対応_サポート | [sdd-cat04-support.md](../agents/sdd-cat04-support.md) |
| 05 | 変更_リリース管理 | [sdd-cat05-change-release.md](../agents/sdd-cat05-change-release.md) |
| 06 | 構成管理_資産管理 | [sdd-cat06-config-asset.md](../agents/sdd-cat06-config-asset.md) |
| 07 | セキュリティ管理 | [sdd-cat07-security.md](../agents/sdd-cat07-security.md) |
| 08 | バックアップ_リカバリ | [sdd-cat08-backup-recovery.md](../agents/sdd-cat08-backup-recovery.md) |
| 09 | キャパシティ管理 | [sdd-cat09-capacity.md](../agents/sdd-cat09-capacity.md) |
| 10 | 権限管理 | [sdd-cat10-access.md](../agents/sdd-cat10-access.md) |
| 11 | コスト管理 | [sdd-cat11-cost.md](../agents/sdd-cat11-cost.md) |
| 12 | 統制管理 | [sdd-cat12-governance.md](../agents/sdd-cat12-governance.md) |

### カテゴリ別コード生成エージェント実装ファイル（フェーズ1-2: 全カテゴリ実装済）
| カテゴリID | カテゴリ名 | コード生成エージェント | 機能 |
|-----------|-----------|-----|------|
| 01 | 監視_モニタリング | [sdd-code-generator-cat01.md](../agents/sdd-code-generator-cat01.md) | タスク分解 → アラート/ダッシュボードコード生成 → 構文チェック → build.log 出力 |
| 02 | 運用補佐ツール開発_管理 | [sdd-code-generator-cat02.md](../agents/sdd-code-generator-cat02.md) | 自動化タスク → ツール実装コード生成 → パッケージ管理 → build.log 出力 |
| 03 | インシデント_障害対応 | [sdd-code-generator-cat03.md](../agents/sdd-code-generator-cat03.md) | 対応フロー → 自動化スクリプト生成 → RCA テンプレート → build.log 出力 |
| 04 | 問い合わせ対応_サポート | [sdd-code-generator-cat04.md](../agents/sdd-code-generator-cat04.md) | FAQ 項目 → 回答テンプレート自動生成 → ナレッジシステム連携 → build.log 出力 |
| 05 | 変更_リリース管理 | [sdd-code-generator-cat05.md](../agents/sdd-code-generator-cat05.md) | 変更要件 → ワークフロー自動化 → CAB 審査基準 → build.log 出力 |
| 06 | 構成管理_資産管理 | [sdd-code-generator-cat06.md](../agents/sdd-code-generator-cat06.md) | 資産定義 → CMDB 同期スクリプト → 差分検知ロジック → build.log 出力 |
| 07 | セキュリティ管理 | [sdd-code-generator-cat07.md](../agents/sdd-code-generator-cat07.md) | セキュリティ項目 → スキャン自動化コード → 脆弱性検出 → build.log 出力 |
| 08 | バックアップ_リカバリ | [sdd-code-generator-cat08.md](../agents/sdd-code-generator-cat08.md) | 復旧要件 → バックアップ自動化 → DR テスト → build.log 出力 |
| 09 | キャパシティ管理 | [sdd-code-generator-cat09.md](../agents/sdd-code-generator-cat09.md) | リソース分析 → 予測モデル生成 → スケーリングロジック → build.log 出力 |
| 10 | 権限管理 | [sdd-code-generator-cat10.md](../agents/sdd-code-generator-cat10.md) | RBAC 要件 → アクセス制御コード → プロビジョニング自動化 → build.log 出力 |
| 11 | コスト管理 | [sdd-code-generator-cat11.md](../agents/sdd-code-generator-cat11.md) | コスト分析 → コスト追跡スクリプト → 削減施策検出 → build.log 出力 |
| 12 | 統制管理 | [sdd-code-generator-cat12.md](../agents/sdd-code-generator-cat12.md) | 統制要件 → マトリックス自動化 → 監査ログ生成 → build.log 出力 |

### カテゴリ別検証実行エージェント実装ファイル（フェーズ1-2: 全カテゴリ実装済）
| カテゴリID | カテゴリ名 | 検証実行エージェント | 機能 |
|-----------|-----------|-----|------|
| 01 | 監視_モニタリング | [sdd-verifier-cat01.md](../agents/sdd-verifier-cat01.md) | アラート生成テスト → ダッシュボード表示検証 → test-results.json + verification-log.md 生成 |
| 02 | 運用補佐ツール開発_管理 | [sdd-verifier-cat02.md](../agents/sdd-verifier-cat02.md) | ツール実行テスト → 自動化率検証 → エラー率測定 → test-results.json 生成 |
| 03 | インシデント_障害対応 | [sdd-verifier-cat03.md](../agents/sdd-verifier-cat03.md) | 障害検知テスト → MTTR 測定 → RCA 品質検証 → test-results.json 生成 |
| 04 | 問い合わせ対応_サポート | [sdd-verifier-cat04.md](../agents/sdd-verifier-cat04.md) | FAQ カバー率テスト → テンプレート適用検証 → 回答品質確認 → test-results.json 生成 |
| 05 | 変更_リリース管理 | [sdd-verifier-cat05.md](../agents/sdd-verifier-cat05.md) | 変更フロー検証 → CAB 承認プロセステスト → リスク評価 → test-results.json 生成 |
| 06 | 構成管理_資産管理 | [sdd-verifier-cat06.md](../agents/sdd-verifier-cat06.md) | CMDB 同期検証 → 差分検知精度テスト → 整合性確認 → test-results.json 生成 |
| 07 | セキュリティ管理 | [sdd-verifier-cat07.md](../agents/sdd-verifier-cat07.md) | セキュリティスキャン検証 → 脆弱性検出精度テスト → パッチ適用確認 → test-results.json 生成 |
| 08 | バックアップ_リカバリ | [sdd-verifier-cat08.md](../agents/sdd-verifier-cat08.md) | バックアップ成功率検証 → RPO/RTO テスト → 復旧可能性確認 → test-results.json 生成 |
| 09 | キャパシティ管理 | [sdd-verifier-cat09.md](../agents/sdd-verifier-cat09.md) | 予測精度検証 → スケーリング自動テスト → 負荷試験実行 → test-results.json 生成 |
| 10 | 権限管理 | [sdd-verifier-cat10.md](../agents/sdd-verifier-cat10.md) | RBAC 定義検証 → アクセス制御テスト → プロビジョニング確認 → test-results.json 生成 |
| 11 | コスト管理 | [sdd-verifier-cat11.md](../agents/sdd-verifier-cat11.md) | コスト追跡検証 → 削減施策効果テスト → ROI 計算確認 → test-results.json 生成 |
| 12 | 統制管理 | [sdd-verifier-cat12.md](../agents/sdd-verifier-cat12.md) | 統制マトリックス検証 → 監査実績テスト → コンプライアンス確認 → test-results.json 生成 |

### 入力
- ユーザー依頼
- 既存ドキュメント
- 運用制約（SLA、SLO、体制、時間帯、依存関係）
- カテゴリID（01から12）

### 標準アクション
1. Specify を更新
- 何を実施するか
- なぜ必要か
- 受入条件
2. Plan を更新
- 実装手順
- 影響範囲
- ロールバック方針
3. Tasks を更新
- 実行可能な粒度へ分解
- 優先度と想定担当を付与
4. Implement を更新（STEP 3-B: コード生成）
- サブエージェント `sdd-code-generator-cat0X` で実装コード生成
- タスクから実装への変換
5. Verify を更新（STEP 3-C: 検証実行）
- サブエージェント `sdd-verifier-cat0X` で受入テスト実行
- テスト結果と証跡を記録
6. Migration を更新（STEP 3-D: 最終ドキュメント生成）
- 展開手順
- 引き継ぎ事項
- 運用時の注意点
7. Output を更新
- 最終成果物
- 利用者向け要約
- 参照リンク

### 出力先
- 要件: categories/<category>/01_specify/<request-folder>/requirements.md
- 計画: categories/<category>/02_plan/<request-folder>/plan.md
- タスク: categories/<category>/03_tasks/<request-folder>/tasks.md
- 実装: categories/<category>/04_implement/<request-folder>/implement.md
- 検証: categories/<category>/05_verify/<request-folder>/verification.md
- 移行: categories/<category>/06_migration/<request-folder>/migration.md
- 出力: categories/<category>/output/<request-folder>/result.md

### 完了条件
- Specify に What と Why が明記されている。
- Plan の出力先パスが Specify と整合している。
- Verify に具体的かつ再現可能な証跡がある。
- 未解決事項と前提条件が明示されている。

---

## 4. Agent: sdd-quality-gate

### 役割
- 生成された成果物全体に品質ゲートを適用する。
- 不足やドリフトを検知し、修正ポイントを提示する。

### チェック観点
1. 要件品質ゲート
- What/Why 専用チェック
- 受入条件の明確性
- 出力先整合
2. Specify-Plan 整合ゲート
- 要件から計画へのトレーサビリティ
- パスと成果物のドリフト検知
3. Verify 証跡ゲート
- 実行ログの再現性
- 証跡リンクの有効性
- 判定根拠（Pass/Fail）の明示性

### 出力契約
- ゲート判定:
  - PASS
  - CONDITIONAL PASS
  - FAIL
- 指摘は重要度順に記載
- 必要修正をファイル単位で提示
- 修正後の再チェック手順を提示

### レポート出力先
- categories/<category>/05_verify/<request-folder>/quality-gate-report.md

---

## 5. ルーター呼び出し例（全カテゴリ向け）

### 例1: 監視要件の新規作成
- 入力: CPU アラートしきい値を見直し、夜間通知を抑制したい。
- ルート:
  - sdd-router
  - sdd-cat01-monitoring → STEP 1-7 実行
  - sdd-code-generator-cat01（自動起動）
  - sdd-verifier-cat01（自動起動）
  - sdd-quality-gate

### 例2: 障害対応フローの改善
- 入力: 障害一次切り分け手順とエスカレーション基準を更新したい。
- ルート:
  - sdd-router
  - sdd-cat03-incident → STEP 1-7 実行
  - sdd-code-generator-cat03（自動起動）
  - sdd-verifier-cat03（自動起動）
  - sdd-quality-gate

### 例3: コスト最適化施策の計画
- 入力: 月次コスト超過に対する最適化案を作成したい。
- ルート:
  - sdd-router
  - sdd-cat11-cost → STEP 1-7 実行
  - sdd-code-generator-cat11（自動起動）
  - sdd-verifier-cat11（自動起動）
  - sdd-quality-gate

---

## 📊 フェーズ実装状況

| フェーズ | 内容 | 対象 | 状態 |
|---------|------|------|------|
| **フェーズ1** | Cat01 STEP 3 拡張 + Code Generator + Verifier | Cat01 | ✅ 完了 |
| **フェーズ2** | Cat02～12 STEP 3 拡張 + Code Generator × 11 + Verifier × 11 | Cat02-12 | ✅ 完了 |
| **フェーズ3** | 統合テスト + 実運用検証 | 全カテゴリ | ⏳ 予定 |

---

## 🔧 新規エージェント一覧（フェーズ1-2で追加）

### Code Generator エージェント（計12個）
- `sdd-code-generator-cat01.md` ～ `sdd-code-generator-cat12.md`
- 役割: タスク分解 → 実装コード生成 → ビルド・構文チェック

### Verifier エージェント（計12個）
- `sdd-verifier-cat01.md` ～ `sdd-verifier-cat12.md`
- 役割: 受入条件抽出 → テスト実行 → テスト結果記録

**合計新規エージェント数: 24個**

---

