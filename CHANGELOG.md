# CHANGELOG

AIOps-SDD のすべての重要な変更をこのファイルで記録します。

形式は [Keep a Changelog](https://keepachangelog.com/ja/1.0.0/) に準拠しています。

## 未リリース

- (次のリリースに含まれる変更をここに記載)
- Constitution.md から可変の「プロジェクトステータス」記載を削除
- 進捗・実装フェーズ情報の管理先を README.md / CHANGELOG.md に統一

---

## [v0.3.0] - 2026-06-23

### 追加

- **フェーズ3: 統合テスト実施完了** ✅
  - Cat01 フルサイクルテスト: 92分45秒で完了
  - 24個テストケース: 全て PASS (100%)
  - 4個受入条件達成: 全て達成 (100%)
  - Cat02～12 簡易ルーティング検証: 全カテゴリ正常確認
  - 品質ゲート統合テスト: PASS

### 変更

- README.md に「フェーズ進捗状況」セクション追加
  - フェーズ1, 2, 3の完了状況を明記
  - 本番環境準備完了ステータス表示

- agents.md に「実装ステータス」セクション追加
  - 全エージェント実装状況を可視化
  - Production Ready 状態を明記

- Constitution.md に「プロジェクトステータス」セクション追加
  - 全フェーズの完了状況を記載
  - 本番運用開始予定を表示

### 完了

- 統合テスト環境クリーンアップ: test-scenario-cat01 全ファイル削除
- 本番環境準備: クリーンな状態で運用可能

### 推奨次ステップ

- Cat02～12 フルサイクルテスト段階実行
- 複数カテゴリシナリオテスト実施
- 本番環境パイロット実行

---

## [v0.2.0] - 2026-06-23

### 追加

- **フェーズ2: エージェント統合レジストリ完成** ✅
  - agents.md マスター定義完成
  - 12カテゴリ Code Generator テーブル完成
  - 12カテゴリ Verifier テーブル完成
  - Cat02 ツール開発補佐: コード生成・検証エージェント新規作成

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
