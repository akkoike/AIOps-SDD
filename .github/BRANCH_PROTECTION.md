# GitHub ブランチ保護設定ガイド

このドキュメントは、GitHub 上で `main` ブランチを保護し、直接 push を禁止、PR 経由のマージを必須化するための手順を説明します。

## 前提条件

- リポジトリの管理者権限を持っていること

## 1. ブランチ保護ルール設定手順

### 1.1 GitHub リポジトリページにアクセス

1. GitHub でリポジトリを開く
2. 上部のタブから **Settings** をクリック
3. 左サイドバーから **Branches** を選択

### 1.2 ブランチ保護ルールを追加

1. **Branch protection rules** セクションで **Add rule** ボタンをクリック
2. **Branch name pattern** に `main` と入力

### 1.3 保護ルールの設定

以下の項目にチェックを入れます（推奨構成）。

| 項目 | 設定 | 理由 |
|------|------|------|
| Require pull request reviews before merging | ✓ | PR 経由でのみマージを許可 |
| Require status checks to pass before merging | ○ | 必要に応じて（CI/CD が有効な場合） |
| Dismiss stale pull request approvals when new commits are pushed | ✓ | コミット後に再レビューを要求 |
| Require branches to be up to date before merging | ✓ | マージ前に最新版と同期を要求 |
| Include administrators | ✓ | 管理者も同じルールに従う |

### 1.4 保存

**Create** ボタンをクリックして保護ルールを適用します。

## 2. テスト方法

設定後に動作確認するため、以下を試します。

1. ローカルで `feature/test` ブランチを作成
   ```bash
   git checkout -b feature/test
   ```

2. テストファイルを作成してコミット
   ```bash
   echo "test" > test.txt
   git add test.txt
   git commit -m "test: verify branch protection"
   ```

3. main に直接 push してみる
   ```bash
   git push origin feature/test
   git push origin feature/test:main
   ```
   → エラーが出て push できないことを確認

4. PR 経由でマージすることで確認
   ```bash
   git push origin feature/test
   ```
   → GitHub Web UI で PR を作成し、マージできることを確認

## 3. 注意事項

- リリース時は管理者がタグを打ちマージするプロセスを遵守する
- 緊急対応時も PR 経由を原則とする
- 必要に応じて exception rule を設定できるが、運用ルールを厳密にしてから検討する
