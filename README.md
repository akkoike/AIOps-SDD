# AIOps-AIDLC ワークスペース利用ガイド

このリポジトリは、運用業務ドキュメントを SDD（Specification Driven Development）形式で整理し、AI 駆動ワークフローで12カテゴリの要件定義から成果物出力までを一貫管理するためのワークスペースです。

## 🚀 クイックスタート（まずはここから）

**動かす手順はこれだけです。**

1. Copilot Chat で [.github/prompts/router-start.md](.github/prompts/router-start.md) を開いて実行する
2. チャットに **「ヒアリングをはじめてください」** と入力する
3. 対話で 8 項目（依頼種別・タイトル・本文・背景・期限・制約・成果物・受入条件）に回答する
4. カテゴリが自動判定され、7 工程（Specify → Plan → Tasks → Implement → Verify → Migration → Output）が自動生成される

> 詳しい実行フローは「[4. SDD パイプライン実行フロー](#4-sdd-パイプライン実行フロー推奨)」を参照してください。

## 1. 目的

- 運用依頼をヒアリング → カテゴリ判定 → 7工程全自動実行する SDD パイプラインの提供
- 12カテゴリの AI 駆動実行エージェント（sdd-cat01 ～ sdd-cat12）による一貫管理
- 要件・設計・タスク・検証・引き継ぎの全工程を Markdown で管理
- 最終成果物をカテゴリ単位で output に集約

## 2. 主要フォルダ

### プロジェクト管理
- [Constitution.md](Constitution.md)
  - プロジェクトの最上位原則（存在意義、基本原則、スコープ、制約、ガバナンス）
- [Account/accounts.yml](Account/accounts.yml)
  - 対象アカウントやサブスクリプション情報を管理

### SDD パイプライン実装
- [.github/agents/agents.md](.github/agents/agents.md)
  - マスター定義：ルーター、品質ゲート、カテゴリ別エージェント契約の責務定義
- [.github/prompts/router-start.md](.github/prompts/router-start.md) ✅ **SDD エントリーポイント**
  - ヒアリング → カテゴリ判定 → 全工程実行パイプライン
- [.github/agents/sdd-hearing-subagent-sample.md](.github/agents/sdd-hearing-subagent-sample.md)
  - **ヒアリング専用**：8項目（依頼種別、タイトル、本文、背景、期限、制約、成果物、受入条件）を収集

### 12個のカテゴリ別エージェント実装（`.github/agents/`）
- [sdd-cat01-monitoring.md](.github/agents/sdd-cat01-monitoring.md) — 01_監視_モニタリング
- [sdd-cat02-ops-tooling.md](.github/agents/sdd-cat02-ops-tooling.md) — 02_運用補佐ツール開発_管理
- [sdd-cat03-incident.md](.github/agents/sdd-cat03-incident.md) — 03_インシデント_障害対応
- [sdd-cat04-support.md](.github/agents/sdd-cat04-support.md) — 04_問い合わせ対応_サポート
- [sdd-cat05-change-release.md](.github/agents/sdd-cat05-change-release.md) — 05_変更_リリース管理
- [sdd-cat06-config-asset.md](.github/agents/sdd-cat06-config-asset.md) — 06_構成管理_資産管理
- [sdd-cat07-security.md](.github/agents/sdd-cat07-security.md) — 07_セキュリティ管理
- [sdd-cat08-backup-recovery.md](.github/agents/sdd-cat08-backup-recovery.md) — 08_バックアップ_リカバリ
- [sdd-cat09-capacity.md](.github/agents/sdd-cat09-capacity.md) — 09_キャパシティ管理
- [sdd-cat10-authz.md](.github/agents/sdd-cat10-authz.md) — 10_権限管理
- [sdd-cat11-cost.md](.github/agents/sdd-cat11-cost.md) — 11_コスト管理
- [sdd-cat12-governance.md](.github/agents/sdd-cat12-governance.md) — 12_統制管理

### カテゴリ本体
- [categories](categories)
  - 12カテゴリ × 7工程の SDD 実行フォルダ構造
  - 各カテゴリ配下：01_specify → 02_plan → 03_tasks → 04_implement → 05_verify → 06_migration → output

### サポートファイル
- [docs/source](docs/source) — 暗黙知を仕様へ変換する際の変換元ドキュメント配置先
- [docs/staging](docs/staging) — 変換時の中間データ一時置き場
- [.github/skills](.github/skills) — SDD 品質ゲート／レビュースキル（5種）
- [tools](tools) — 補助ツール格納先
- [.gitignore](.gitignore) — Git 管理除外ルール
- [CONTRIBUTING.md](CONTRIBUTING.md) — ブランチ、PR、タグ運用ルール
- [CHANGELOG.md](CHANGELOG.md) — リリース履歴とバージョン記録

## 3. カテゴリ標準構成

各カテゴリは、原則として以下の構成で運用します。

- 01_specify
- 02_plan
- 03_tasks
- 04_implement
- 05_verify
- 06_migration
- output
- README.md

例:

- [categories/01_監視_モニタリング](categories/01_監視_モニタリング)
- [categories/02_運用補佐ツール開発_管理](categories/02_運用補佐ツール開発_管理)

## 4. SDD パイプライン実行フロー（推奨）

```
1. [ヒアリング開始]
   → sdd-hearing-subagent-sample.md で 8 項目を対話的に収集

2. [カテゴリ自動判定]
   → sdd-router が依頼内容からカテゴリ（01-12）を自動判定

3. [カテゴリ別エージェント実行]
   → 判定されたカテゴリのエージェント（sdd-cat01 ～ sdd-cat12）が起動
   → 以下の 7 工程を順番に全自動生成：
      ✓ 01_specify/<request-folder>/requirements.md — 要件仕様書
      ✓ 02_plan/<request-folder>/plan.md — 実装設計
      ✓ 03_tasks/<request-folder>/tasks.md — タスク分解
      ✓ 04_implement/<request-folder>/implement.md — 実装記録
      ✓ 05_verify/<request-folder>/verification.md — 検証ログ
      ✓ 06_migration/<request-folder>/migration.md — 本番展開手順
      ✓ output/<request-folder>/result.md — 最終成果物

4. [品質ゲート実行]
   → sdd-quality-gate が整合チェック

5. [完了報告]
   → 変更ファイル一覧と次アクションをユーザーへ通知
```

**🚀 開始方法**

1. Copilot Chat で [router-start.md](.github/prompts/router-start.md) を実行
2. 「ヒアリングをはじめてください」と入力
3. 対話的に 8 項目を回答
4. 自動的に全 7 工程が生成される

## 5. フェーズ進捗状況

```
フェーズ1: エージェントインフラ実装
  ✅ COMPLETE (2026-06-23)
  - ルーター (sdd-router) 実装
  - 品質ゲート (sdd-quality-gate) 実装
  - 12カテゴリエージェント (sdd-cat01～sdd-cat12) 実装
  - 12カテゴリ コード生成エージェント (sdd-code-generator-cat01～12) 実装
  - 12カテゴリ 検証エージェント (sdd-verifier-cat01～12) 実装

フェーズ2: エージェント統合レジストリ
  ✅ COMPLETE (2026-06-23)
  - マスター定義 (.github/agents/agents.md) 完成
  - 全エージェント責務定義確立
  - 全カテゴリ Code Generator テーブル完成
  - 全カテゴリ Verifier テーブル完成

フェーズ3: 統合テスト実施
  ✅ COMPLETE (2026-06-23)
  - Cat01 フルサイクルテスト: 92分45秒 (PASS)
    - Specify → Plan → Tasks → Implement → Verify → Migration → Output
    - 24/24 テストケース PASS (100%)
    - 4/4 受入条件達成 (100%)
  - Cat02～12 簡易検証: 全ルーティング確認 (PASS)
  - 品質ゲート統合テスト: 実施 (PASS)
  - 環境クリーンアップ: 完了 ✓
  
  **ステータス**: 本番環境準備完了 🎉
```

## 6. 各カテゴリ別エージェント（sdd-cat01 ～ sdd-cat12）の役割

すべてのカテゴリエージェントは共通の 7 工程テンプレートに従います：

| # | カテゴリ | エージェント | 主な責務 |
|---|---------|------------|----------|
| 01 | 監視_モニタリング | sdd-cat01-monitoring | ダッシュボード、メトリクス、アラート |
| 02 | 運用補佐ツール開発_管理 | sdd-cat02-ops-tooling | 自動化スクリプト、工数削減 |
| 03 | インシデント_障害対応 | sdd-cat03-incident | 障害対応フロー、RCA |
| 04 | 問い合わせ対応_サポート | sdd-cat04-support | FAQ、回答テンプレート |
| 05 | 変更_リリース管理 | sdd-cat05-change-release | 変更申請、CAB |
| 06 | 構成管理_資産管理 | sdd-cat06-config-asset | CMDB、資産台帳 |
| 07 | セキュリティ管理 | sdd-cat07-security | 脆弱性対応、監査 |
| 08 | バックアップ_リカバリ | sdd-cat08-backup-recovery | バックアップ戦略、DR |
| 09 | キャパシティ管理 | sdd-cat09-capacity | 性能予測、サイジング |
| 10 | 権限管理 | sdd-cat10-authz | IAM、RBAC |
| 11 | コスト管理 | sdd-cat11-cost | 予算管理、最適化 |
| 12 | 統制管理 | sdd-cat12-governance | 監査、内部統制 |

## 7. 作業開始時のチェック

### SDD パイプライン実行時
- [router-start.md](.github/prompts/router-start.md) を開く
- 「ヒアリングをはじめてください」と入力して対話を開始
- 8 項目に回答（ルーターが自動判定）
- 生成されたファイルを確認

### 手作業での修正が必要な場合
- 対象カテゴリの README.md を確認
- `categories/<category>/<phase>/<request-folder>/` 配下のファイルを確認
- [Constitution.md](Constitution.md) の原則に沿っていることを確認
- [.github/skills](.github/skills) のスキルで品質検証

## 8. 推奨作業順

### パイプライン経由（推奨 ✅）
1. [router-start.md](.github/prompts/router-start.md) を実行
2. 対話的にヒアリング実施
3. 全 7 工程が自動生成
4. 品質ゲートで検証
5. 必要に応じて手作業で調整

### 手作業での作業が必要な場合
1. [Account/accounts.yml](Account/accounts.yml) で対象範囲を確認
2. 対象カテゴリの 01_specify から更新開始
3. 02_plan と 03_tasks を更新
4. 04_implement と 05_verify を更新
5. 06_migration と output を最終化

## 9. 補足

### SDD パイプラインの仕組み
- **自動実行**: [router-start.md](.github/prompts/router-start.md) → [.github/agents/](.github/agents/) パイプラインで全 7 工程が自動生成
- **Request Folder**: 各依頼ごとに `<request-folder>` を作成して複数依頼を管理
- **品質保証**: 3 つの品質ゲートスキル（要件品質、Specify-Plan整合、Verify証跡）で全文書を検証

### 品質ゲート skills 呼び出し対応
| タイミング | 呼び出す skill | 対象ファイル |
|---|---|---|
| Specify 作成後 | sdd-requirements-quality-gate | categories/<category>/01_specify/<request-folder>/requirements.md |
| Plan 作成後 | sdd-spec-plan-alignment | categories/<category>/01_specify/<request-folder>/requirements.md と categories/<category>/02_plan/<request-folder>/plan.md |
| Verify 実行後 | sdd-verify-evidence-recorder | categories/<category>/05_verify/<request-folder>/verification.md |

- 実行主体は sdd-quality-gate（定義: [.github/agents/agents.md](.github/agents/agents.md)）
- 上記 3 skill の結果を集約して quality-gate-report.md を出力

### レビュー系 skills（オンデマンド実行）
| skill | 目的 | 記録先 |
|---|---|---|
| sdd-accessibility-review | Web 成果物を WCAG 2.2 AA（+ JIS X 8341-3:2016）でレビュー | categories/<category>/05_verify/<request-folder>/accessibility-review.md |
| sdd-isms-compliance-review | 成果物を ISO/IEC 27001:2022 附属書A統制でレビュー | categories/<category>/05_verify/<request-folder>/isms-compliance-review.md |

### 既存ドキュメント処理
- `docs/source`: 暗黙知を仕様へ変換する場合のみ使用
- `docs/staging`: 中間生成物の一時置き場（最終成果物ではない）
- 通常は `categories/` 配下を直接更新

### 共通ルール
- カテゴリ間で統一された 7 工程フォーマットを使用
- すべてのファイルは Markdown で管理（Office 系は Git 管理対象外）
- 要件（Specify）と設計（Plan）の整合を常に維持

## 10. ガバナンスとコミットルール

- 最上位方針は [Constitution.md](Constitution.md) を正とし、カテゴリ仕様はこれに準拠して更新してください
- Office 系の原本（pptx/docx/xlsx/pdf）は Git 管理対象外です（詳細は [.gitignore](.gitignore)）
- [docs/staging](docs/staging) は中間生成物の一時置き場です。最終成果物は categories 配下に集約してください
- 実際のバージョン管理運用は [CONTRIBUTING.md](CONTRIBUTING.md) を参照してください
