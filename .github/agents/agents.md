# SDD カスタムエージェント定義（12カテゴリ共通）

## 1. 共通ポリシー
- 対象カテゴリ: 01 から 12 の全カテゴリ
- 共通ルール:
  - 重複ファイルを増やさず、既存ファイルの更新を優先する。
  - 推測で完了扱いにしない。
  - Verify には具体的な証跡リンクを必ず含める。
  - Specify と Plan の整合を常に維持する。

### スコープ境界（明文化）
- 本ファイルは「ルーティングと責務定義」を扱い、実装コードや詳細設計は扱わない。
- 本ファイルに記載する内容は、役割、入出力契約、完了条件、品質ゲート条件に限定する。
- 実装の具体手順、コード変更内容、実行ログの詳細はカテゴリ配下へ委譲する。
- ただし、カテゴリに属さない共通スクリプトはリポジトリ直下の `scripts/` 配下に配置する。
  - 実装方針と手順: categories/<category>/02_plan/
  - 実装の実体と変更履歴: categories/<category>/04_implement/
  - 検証証跡と判定根拠: categories/<category>/05_verify/
- 例外として、本ファイルには「どのファイルへ委譲するか」と「再実行条件」のみ記載してよい。

### カテゴリID定義
- 01: 監視_モニタリング
- 02: 運用補佐ツール開発_管理
- 03: インシデント_障害対応
- 04: 問い合わせ対応_サポート
- 05: 変更_リリース管理
- 06: 構成管理_資産管理
- 07: セキュリティ管理
- 08: バックアップ_リカバリ
- 09: キャパシティ管理
- 10: 権限管理
- 11: コスト管理
- 12: 統制管理

### 共通出力先テンプレート
- 要件: categories/<category>/01_specify/<request-folder>/requirements.md
- 計画: categories/<category>/02_plan/<request-folder>/plan.md
- タスク: categories/<category>/03_tasks/<request-folder>/tasks.md
- 実装: categories/<category>/04_implement/<request-folder>/implement.md
- 検証: categories/<category>/05_verify/<request-folder>/verification.md
- 移行: categories/<category>/06_migration/<request-folder>/migration.md
- 出力: categories/<category>/output/<request-folder>/result.md
- 非カテゴリ共通スクリプト: scripts/

---

## 2. Agent: sdd-router

### 役割
- 受け付けた依頼を適切なカテゴリエージェントへ振り分ける。
- 必要に応じて実行前後に品質ゲートを挿入する。
- 出力先パスを明示して実行エージェントへ引き渡す。

### ルーティング条件（12カテゴリ）
- 監視 ダッシュボード メトリクス アラート しきい値 通知 監視設計:
  - 01 監視_モニタリング
  - 実行エージェント: sdd-cat01-monitoring
- 運用自動化 ツール開発 運用改善 スクリプト:
  - 02 運用補佐ツール開発_管理
  - 実行エージェント: sdd-cat02-ops-tooling
- 障害 インシデント 復旧 RCA エスカレーション:
  - 03 インシデント_障害対応
  - 実行エージェント: sdd-cat03-incident
- 問い合わせ サポート FAQ 回答テンプレート:
  - 04 問い合わせ対応_サポート
  - 実行エージェント: sdd-cat04-support
- 変更申請 リリース CAB 変更管理:
  - 05 変更_リリース管理
  - 実行エージェント: sdd-cat05-change-release
- 構成管理 CMDB 資産台帳 構成差分:
  - 06 構成管理_資産管理
  - 実行エージェント: sdd-cat06-config-asset
- 脆弱性 セキュリティ監査 セキュリティ是正:
  - 07 セキュリティ管理
  - 実行エージェント: sdd-cat07-security
- バックアップ リストア DR RPO RTO:
  - 08 バックアップ_リカバリ
  - 実行エージェント: sdd-cat08-backup-recovery
- キャパシティ 性能予測 サイジング:
  - 09 キャパシティ管理
  - 実行エージェント: sdd-cat09-capacity
- 権限 IAM RBAC アクセス棚卸し:
  - 10 権限管理
  - 実行エージェント: sdd-cat10-access
- コスト 予算 最適化 請求分析:
  - 11 コスト管理
  - 実行エージェント: sdd-cat11-cost
- 監査 内部統制 コンプライアンス 統制証跡:
  - 12 統制管理
  - 実行エージェント: sdd-cat12-governance
- 要件品質 整合 証跡 監査対応 の明示要求がある場合:
  - 品質ゲートを並走または最終工程で実行する。
  - 実行エージェント: sdd-quality-gate

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

## 3. Agent: sdd-category-executor（共通カテゴリ実行）

### 役割
- 判定されたカテゴリの成果物を作成 更新する。
- 仕様、設計、タスク、実装、受入、展開、output の全工程で一貫性を維持する。
- **実装**: 各カテゴリ別エージェント実装ファイルに委譲

### カテゴリ別エージェント実装ファイル
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
4. Verify を更新
- 検証手順
- 実行結果
- 証跡リンク
5. Migration を更新
- 展開手順
- 引き継ぎ事項
- 運用時の注意点
6. Output を更新
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
  - sdd-cat01-monitoring（または sdd-category-executor with category=01）
  - sdd-quality-gate

### 例2: 障害対応フローの改善
- 入力: 障害一次切り分け手順とエスカレーション基準を更新したい。
- ルート:
  - sdd-router
  - sdd-cat03-incident（または sdd-category-executor with category=03）
  - sdd-quality-gate

### 例3: コスト最適化施策の計画
- 入力: 月次コスト超過に対する最適化案を作成したい。
- ルート:
  - sdd-router
  - sdd-cat11-cost（または sdd-category-executor with category=11）
  - sdd-quality-gate


