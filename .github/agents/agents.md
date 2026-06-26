# SDD カスタムエージェント定義（12カテゴリ共通）

## 🎉 実装ステータス

```
フェーズ1: 基本インフラ実装
  ✅ 完了 (2026-06-23)
  - ルーター (sdd-router)
  - 品質ゲート (sdd-quality-gate)
  - 12カテゴリエージェント (sdd-cat01～sdd-cat12)
  - 12カテゴリ コード生成エージェント
  - 12カテゴリ 検証エージェント

フェーズ2: 統合レジストリ
  ✅ 完了 (2026-06-23)
  - マスター定義完成
  - 全エージェント責務定義確立
  - Code Generator テーブル (12/12)
  - Verifier テーブル (12/12)

フェーズ3: 統合テスト
  ✅ 完了 (2026-06-23)
  - Cat01 フルサイクル: 92分45秒 / 24テスト PASS / 4/4受入条件達成
  - Cat02～12 簡易検証: ルーティング 100% 正確
  - 品質ゲート統合テスト: PASS
  - 本番環境クリーンアップ: 完了

**運用状態**: ✅ 本番実行可能 (Production Ready)
```

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
- 依頼種別による `<request-folder>` の扱い:
  - 新規: 依頼タイトルを正規化した新規フォルダを作成する。
  - 既存更新: 新規フォルダを作成せず、ヒアリングで特定した既存フォルダを読み込み上書きする。

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
3. **依頼種別を判定する（新規 / 既存更新）**。
   - **新規**: 該当カテゴリエージェントへ委譲し、依頼タイトルを正規化した**新規 request-folder** 配下に `01_specify` から `output` までの全工程を生成する。
   - **既存更新**: ヒアリングで特定した**既存 request-folder** を対象として委譲する。**新規フォルダを作成せず**、対象フォルダ配下の既存 7 工程ファイルを読み込み、操作種別（追加/修正/削除/複合）に従って反映し、同じフォルダへ上書き保存する。
4. 実装成果物は `categories/<category>/04_implement/<request-folder>/` を正とし、`tools/` 単独配置で完了扱いにしない。
5. 品質ゲートを実行する。
6. 変更ファイルと次アクションをユーザーへ返す。

### 出力契約
- 必須出力:
  - 判定カテゴリ
  - 実行エージェント名
  - 対象ファイルパス
  - 完了条件チェック結果

---

## 3. フェーズ連鎖定義（7フェーズ自動連鎖ワークフロー）

### ワークフロー全体図
```
[ヒアリング結果]
    ↓
【Phase 1】Specify-Plan同期工程
  ├─ 01_specify/<req>/requirements.md (What/Why)
  ├─ 02_plan/<req>/plan.md (How)
  └─ sdd-spec-plan-alignment 実行
    ↓ [同期PASS]
【Phase 2】Tasks工程
  └─ 03_tasks/<req>/tasks.md 生成
    ↓
【Phase 3】Implement工程
  ├─ sdd-code-generator-cat## 起動
  └─ 04_implement/<req>/implement.md 更新
    ↓ [BUILD SUCCESS]
【Phase 4】Verify工程
  ├─ sdd-verifier-cat## 起動
  └─ 05_verify/<req>/verification.md + test-results.json
    ↓ [PASS RATE 100%]
【Phase 5】Migration工程
  └─ 06_migration/<req>/migration.md
    ↓
【Phase 6】Output工程
  └─ output/<req>/result.md
    ↓
【Phase 7】品質ゲート
  └─ 05_verify/<req>/quality-gate-report.md
    ↓ [QUALITY PASS]
[完了]
```

### フェーズ間進行条件（明文化）
| フェーズ | 次フェーズ進行条件 | 失敗時アクション |
|---------|------------------|------------------|
| Phase 1 | sdd-spec-plan-alignment: PASS | 修正 → 再実行 |
| Phase 2 | タスク数 ≥ 3 | タスク追加 |
| Phase 3 | build.log: BUILD SUCCESS | コード修正 → リビルド |
| Phase 4 | test-results.json: pass_rate = 100% | テスト失敗分析 → 修正 |
| Phase 5 | 出力完了（条件なし） | - |
| Phase 6 | 出力完了（条件なし） | - |
| Phase 7 | quality-gate-report.md: PASS | 指摘項目修正 → 再ゲート |

### 各フェーズ実行エージェントマッピング
| フェーズ | 実行エージェント | 担当タスク |
|---------|-----------------|----------|
| Phase 1 | sdd-cat01～12 (カテゴリ別) | requirements.md + plan.md 生成 + sdd-spec-plan-alignment |
| Phase 2 | sdd-cat01～12 (カテゴリ別) | tasks.md 生成 |
| Phase 3 | sdd-code-generator-cat01～12 | コード生成 + build.log |
| Phase 4 | sdd-verifier-cat01～12 | テスト実行 + verification.md + test-results.json |
| Phase 5 | sdd-cat01～12 (カテゴリ別) | migration.md 生成 |
| Phase 6 | sdd-cat01～12 (カテゴリ別) | result.md 生成 |
| Phase 7 | sdd-quality-gate | 全工程品質チェック + quality-gate-report.md |

---

## 4. Agent: sdd-category-executor（共通カテゴリ実行）

### 役所
- 判定されたカテゴリの成果物を作成・更新する。
- 7フェーズ連鎖ワークフローに従い、各フェーズを自動実行する。
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

### カテゴリ別コード生成エージェント実装ファイル（フェーズ1-2: 全カテゴリ実装済）
| カテゴリID | カテゴリ名 | コード生成エージェント | 機能 |
|-----------|-----------|-----|------|
| 01 | 監視_モニタリング | [sdd-code-generator-cat01.md](../agents/sdd-code-generator-cat01.md) | タスク分解からコード生成 → 構文チェック → build.log 出力 |
| 02 | 運用補佐ツール開発_管理 | [sdd-code-generator-cat02.md](../agents/sdd-code-generator-cat02.md) | 運用自動化スクリプト生成 → 構文チェック → build.log 出力 |
| 03 | インシデント_障害対応 | [sdd-code-generator-cat03.md](../agents/sdd-code-generator-cat03.md) | 障害対応フロー自動化 → 構文チェック → build.log 出力 |
| 04 | 問い合わせ対応_サポート | [sdd-code-generator-cat04.md](../agents/sdd-code-generator-cat04.md) | FAQ/回答テンプレート自動生成 → 構文チェック → build.log 出力 |
| 05 | 変更_リリース管理 | [sdd-code-generator-cat05.md](../agents/sdd-code-generator-cat05.md) | 変更管理ワークフロー生成 → 構文チェック → build.log 出力 |
| 06 | 構成管理_資産管理 | [sdd-code-generator-cat06.md](../agents/sdd-code-generator-cat06.md) | CMDB同期スクリプト生成 → 構文チェック → build.log 出力 |
| 07 | セキュリティ管理 | [sdd-code-generator-cat07.md](../agents/sdd-code-generator-cat07.md) | セキュリティスキャン自動化 → 構文チェック → build.log 出力 |
| 08 | バックアップ_リカバリ | [sdd-code-generator-cat08.md](../agents/sdd-code-generator-cat08.md) | バックアップ/DR自動化 → 構文チェック → build.log 出力 |
| 09 | キャパシティ管理 | [sdd-code-generator-cat09.md](../agents/sdd-code-generator-cat09.md) | キャパシティ予測自動化 → 構文チェック → build.log 出力 |
| 10 | 権限管理 | [sdd-code-generator-cat10.md](../agents/sdd-code-generator-cat10.md) | RBAC/アクセス制御自動化 → 構文チェック → build.log 出力 |
| 11 | コスト管理 | [sdd-code-generator-cat11.md](../agents/sdd-code-generator-cat11.md) | コスト分析自動化 → 構文チェック → build.log 出力 |
| 12 | 統制管理 | [sdd-code-generator-cat12.md](../agents/sdd-code-generator-cat12.md) | 統制/監査記録自動化 → 構文チェック → build.log 出力 |

### カテゴリ別検証実行エージェント実装ファイル（フェーズ1-2: 全カテゴリ実装済）
| カテゴリID | カテゴリ名 | 検証実行エージェント | 機能 |
|-----------|-----------|-----|------|
| 01 | 監視_モニタリング | [sdd-verifier-cat01.md](../agents/sdd-verifier-cat01.md) | 生成コード実行 → 受入条件テスト → test-results.json + verification-log.md 生成 |
| 02 | 運用補佐ツール開発_管理 | [sdd-verifier-cat02.md](../agents/sdd-verifier-cat02.md) | 生成コード実行 → 受入条件テスト → test-results.json + verification-log.md 生成 |
| 03 | インシデント_障害対応 | [sdd-verifier-cat03.md](../agents/sdd-verifier-cat03.md) | 生成コード実行 → 受入条件テスト → test-results.json + verification-log.md 生成 |
| 04 | 問い合わせ対応_サポート | [sdd-verifier-cat04.md](../agents/sdd-verifier-cat04.md) | 生成コード実行 → 受入条件テスト → test-results.json + verification-log.md 生成 |
| 05 | 変更_リリース管理 | [sdd-verifier-cat05.md](../agents/sdd-verifier-cat05.md) | 生成コード実行 → 受入条件テスト → test-results.json + verification-log.md 生成 |
| 06 | 構成管理_資産管理 | [sdd-verifier-cat06.md](../agents/sdd-verifier-cat06.md) | 生成コード実行 → 受入条件テスト → test-results.json + verification-log.md 生成 |
| 07 | セキュリティ管理 | [sdd-verifier-cat07.md](../agents/sdd-verifier-cat07.md) | 生成コード実行 → 受入条件テスト → test-results.json + verification-log.md 生成 |
| 08 | バックアップ_リカバリ | [sdd-verifier-cat08.md](../agents/sdd-verifier-cat08.md) | 生成コード実行 → 受入条件テスト → test-results.json + verification-log.md 生成 |
| 09 | キャパシティ管理 | [sdd-verifier-cat09.md](../agents/sdd-verifier-cat09.md) | 生成コード実行 → 受入条件テスト → test-results.json + verification-log.md 生成 |
| 10 | 権限管理 | [sdd-verifier-cat10.md](../agents/sdd-verifier-cat10.md) | 生成コード実行 → 受入条件テスト → test-results.json + verification-log.md 生成 |
| 11 | コスト管理 | [sdd-verifier-cat11.md](../agents/sdd-verifier-cat11.md) | 生成コード実行 → 受入条件テスト → test-results.json + verification-log.md 生成 |
| 12 | 統制管理 | [sdd-verifier-cat12.md](../agents/sdd-verifier-cat12.md) | 生成コード実行 → 受入条件テスト → test-results.json + verification-log.md 生成 |

### 入力
- ユーザー依頼
- 既存ドキュメント
- 運用制約（SLA、SLO、体制、時間帯、依存関係）
- カテゴリID（01から12）
- **依頼種別（新規 / 既存更新）**
- **対象 request-folder（既存更新時はヒアリングで特定した既存フォルダ名）**
- **操作種別（既存更新時：追加 / 修正 / 削除 / 複合）**

### 依頼種別による分岐（必須）
- **新規**: 依頼タイトルを正規化した**新規 request-folder** を作成し、7工程を新規生成する。
- **既存更新**: **新規 request-folder を作成せず**、対象の既存 request-folder 配下の各工程ファイル（requirements/plan/tasks/implement/verification/migration/result および `04_implement` のアプリ本体）を**読み込んでから**、操作種別に従って差分を反映し、**同じフォルダへ上書き保存**する。読み込まずに上書きしてはならない。

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
- **既存更新時の注意**: `<request-folder>` はヒアリングで特定した**既存フォルダ**を指す。新規フォルダは作らず、既存ファイルを読み込んで上書きする。

### 完了条件
- Specify に What と Why が明記されている。
- Plan の出力先パスが Specify と整合している。
- Verify に具体的かつ再現可能な証跡がある。
- 未解決事項と前提条件が明示されている。
- `01_specify` `02_plan` `03_tasks` `04_implement` `05_verify` `06_migration` `output` の7工程ファイルが存在する。
- 実装アプリを作成した場合、配置先がカテゴリ配下である（またはカテゴリ配下へ同期済みである）。

---

## 5. Agent: sdd-quality-gate

### 役割
- 生成された成果物全体に品質ゲートを適用する（Phase 7）。
- 不足やドリフトを検知し、修正ポイントを提示する。
- **実行タイミング**: Phase 6 (Output) 完了後に自動実行

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

### 受入動作検証ゲート（再発防止・必須）
1. 推定PASS禁止:
- 実行していない項目を PASS と記載しない。
- 手動確認未実施、またはコマンド未実行の場合は `Blocked` または `Fail` とする。

2. 起動検証必須:
- 実装に起動スクリプトがある場合、当該スクリプトを実行し、終了コードと標準出力を証跡化する。
- スクリプト実行で失敗した場合、修正して再実行し、再実行結果を追記する。

3. 初回アクセス検証必須:
- Web UI が成果物の場合、起動後に `http://localhost:<port>` への初回アクセス可否を検証する。
- 最低限、HTTP応答、またはブラウザ表示可否を確認し、時刻付きで記録する。

4. Verify記録の最小必須項目:
- 実行コマンド（そのまま再実行可能な文字列）
- 実行ディレクトリ
- 実行結果（終了コード、主要出力）
- 失敗時の修正内容と再実行結果
- 判定（Pass/Fail/Blocked/N/A）と根拠

### Skills 呼び出しマッピング（明文化）
| ゲート観点 | 呼び出す skill | 入力対象 | 期待出力 |
|---|---|---|---|
| 要件品質ゲート | sdd-requirements-quality-gate | categories/<category>/01_specify/<request-folder>/requirements.md | What/Why・受入条件・出力先整合の指摘 |
| Specify-Plan 整合ゲート | sdd-spec-plan-alignment | categories/<category>/01_specify/<request-folder>/requirements.md, categories/<category>/02_plan/<request-folder>/plan.md | ドリフト検知結果と修正提案 |
| Verify 証跡ゲート | sdd-verify-evidence-recorder | categories/<category>/05_verify/<request-folder>/verification.md | 証跡追記済みログと判定根拠の整備 |

### Skills 実行順序（明文化）
1. 要件作成後、sdd-requirements-quality-gate を実行する。
2. 設計作成後、sdd-spec-plan-alignment を実行する。
3. 検証実行後、sdd-verify-evidence-recorder を実行する。
4. Web UI/CLI/バッチ等の実行物がある場合、受入動作検証ゲート（起動検証 + 初回アクセス検証）を必須実施する。
5. 上記結果を集約し、quality-gate-report.md を出力する。

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

## 6. ルーター呼び出し例（全カテゴリ向け）

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


