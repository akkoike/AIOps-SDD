# CHANGELOG

AIOps-SDD のすべての重要な変更をこのファイルで記録します。

形式は [Keep a Changelog](https://keepachangelog.com/ja/1.0.0/) に準拠しています。

## 未リリース

- (次のリリースに含まれる変更をここに記載)

---

## [v0.1.0] - 2026-06-11

### 追加

- ワークスペース全体の README ガイド（[README.md](../README.md)）
- 12カテゴリの標準フォルダ構成（01_specify 〜 output）
- 各カテゴリ配下の README.md テンプレート
- 最上位原則書（[Constitution.md](../Constitution.md)）
  - SDD の 7 工程定義
  - 12カテゴリのスコープ定義
  - What/Why/How の役割分担原則

### 設定

- Git 管理除外ルール（[.gitignore](../.gitignore)）
  - Office バイナリファイル（pptx/docx/xlsx/pdf）
  - docs/staging 中間生成物
- バージョン管理ガイド（[CONTRIBUTING.md](../CONTRIBUTING.md)）
  - ブランチ戦略（feature/fix/docs/chore）
  - コミット規約
  - PR 運用
  - タグ運用（semver）
- PR テンプレート（[.github/pull_request_template.md](.github/pull_request_template.md)）
- ブランチ保護設定ガイド（[.github/BRANCH_PROTECTION.md](.github/BRANCH_PROTECTION.md)）

### ドキュメント

- 非構造化データ入口説明（[docs/source/README.md](../docs/source/README.md)）
- 01_監視_モニタリング カテゴリ仕様
  - 要件定義（01_specify/requirements.md）
  - 設計ドキュメント（02_plan/）
  - タスク分割（03_tasks/task-list.md）
  - 検証基準（05_verify/）

---

## リリース前後のチェックリスト

### リリース前

- [ ] すべての PR が `main` にマージされている
- [ ] CHANGELOG.md にリリース内容が記載されている
- [ ] 不要なファイル（.gitignore 対象）が含まれていない確認

### リリース後

- [ ] GitHub 上でタグを確認
- [ ] GitHub Releases で説明を記載（オプション）
- [ ] 社内通知またはドキュメント通知
