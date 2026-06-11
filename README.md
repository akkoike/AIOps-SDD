# AIOps-SDD ワークスペース利用ガイド

このリポジトリは、運用業務ドキュメントを SDD（Specification Driven Development）形式で整理し、カテゴリごとに要件定義から成果物出力までを一貫管理するためのワークスペースです。

## 1. 目的

- 非構造化ドキュメント（pptx/docx/xlsx/pdf）をカテゴリ単位で管理する
- SDD の工程に沿って、要件・設計・タスク・検証・引き継ぎを Markdown で管理する
- 最終成果物をカテゴリ単位で output に集約する

## 2. 主要フォルダ

- [Constitution.md](Constitution.md)
  - プロジェクトの最上位原則（存在意義、基本原則、スコープ、制約、ガバナンス）
- [Account/accounts.yml](Account/accounts.yml)
  - 対象アカウントやサブスクリプション情報を管理
- [categories](categories)
  - 12カテゴリの SDD 管理本体
- [docs/source](docs/source)
  - 変換元の非構造化ドキュメント配置先
- [docs/staging](docs/staging)
  - 変換時の中間データ一時置き場
- [tools](tools)
  - 補助ツール格納先
- [.github/skills](.github/skills)
  - SDD運用で使うスキル定義
- [.gitignore](.gitignore)
  - バイナリファイルや中間生成物などの Git 管理除外ルール
- [CONTRIBUTING.md](CONTRIBUTING.md)
  - ブランチ、コミット、PR、タグ運用の実務ルール
- [CHANGELOG.md](CHANGELOG.md)
  - リリース履歴とバージョン記録
- [.github/pull_request_template.md](.github/pull_request_template.md)
  - PR 作成時に使用する標準テンプレート
- [.github/BRANCH_PROTECTION.md](.github/BRANCH_PROTECTION.md)
  - GitHub ブランチ保護設定手順

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

## 4. 基本運用フロー

1. 入力資料をカテゴリ別に配置する
   - 例: [docs/source](docs/source) 配下の該当カテゴリに配置
2. 必要に応じて中間変換結果を staging に出力する
   - [docs/staging](docs/staging)
3. カテゴリ配下の SDD 工程フォルダへ反映する
   - 01_specify で要件整理
   - 02_plan で設計・方針確定
   - 03_tasks で実施タスク化
   - 04_implement で実装・整備
   - 05_verify で受入/証跡確認
   - 06_migration で引き継ぎ整理
4. 最終成果物を output に集約する

## 5. 作業開始時のチェック

- 対象カテゴリの README.md を確認する
- 対象カテゴリに 01_specify から output まで揃っていることを確認する
- カテゴリ直下に README.md があることを確認する
- 入力資料の配置先が正しいカテゴリかを確認する
- [Constitution.md](Constitution.md) の原則（What/Why と How の分離など）に沿っていることを確認する
- コミット前に [.gitignore](.gitignore) の除外対象（pptx/docx/xlsx/pdf、staging 中間ファイル等）を確認する

## 6. 推奨作業順

1. [Account/accounts.yml](Account/accounts.yml) で対象範囲を確認
2. 対象カテゴリの 01_specify から更新開始
3. 02_plan と 03_tasks を更新
4. 04_implement と 05_verify を更新
5. 06_migration と output を最終化

## 7. 補足

- staging は一時置き場です。最終成果物は categories 配下へ移動して管理してください
- カテゴリ間で共通の運用ルールを使うことで、レビューや引き継ぎを効率化できます

## 8. ガバナンスとコミットルール

- 最上位方針は [Constitution.md](Constitution.md) を正とし、カテゴリ仕様はこれに準拠して更新してください
- Office 系の原本（pptx/docx/xlsx/pdf）は Git 管理対象外です（詳細は [.gitignore](.gitignore)）
- [docs/staging](docs/staging) は中間生成物の一時置き場です。最終成果物は categories 配下に集約してください
- 実際のバージョン管理運用は [CONTRIBUTING.md](CONTRIBUTING.md) を参照してください
