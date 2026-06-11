# AIOps-SDD バージョン管理ガイド

このドキュメントは、AIOps-SDD の最小運用ルールを定義します。

## 1. 基本方針

- `main` は常に安定状態を保つ
- 作業は必ず作業ブランチで行う
- `main` への反映は Pull Request（PR）経由のみとする
- 変更履歴はコミット、タグ、リリースノートで追跡可能にする

## 2. ブランチ運用

### 2.1 ブランチ種別

- `main`: 本線（安定版）
- `feature/*`: 通常の追加・改善
- `fix/*`: 不具合修正
- `docs/*`: ドキュメント更新
- `chore/*`: 雑多な保守（設定更新、整備など）

### 2.2 命名ルール

- 形式: `<type>/<short-description>`
- 例:
  - `feature/monitoring-gap-template`
  - `fix/readme-link-typo`
  - `docs/add-versioning-guide`

## 3. コミット運用

### 3.1 コミット粒度

- 1コミット1目的を原則とする
- 関連しない変更を同一コミットに混在させない

### 3.2 メッセージ規約（推奨）

- 形式: `<type>: <summary>`
- type 例: `feat`, `fix`, `docs`, `chore`, `refactor`
- 例:
  - `docs: add repository versioning guide`
  - `chore: create category readme placeholders`

## 4. PR 運用

- `main` へ直接 push しない
- PR テンプレートに沿って、目的・影響範囲・確認内容を明記する
- レビュー後にマージする
- 小さく分けた PR を優先する

## 5. タグ運用（バージョン管理）

### 5.1 いつタグを打つか

- 区切りのよいタイミング（例: 全カテゴリの雛形整備完了）
- 運用ルールや構成が安定したタイミング

### 5.2 タグ形式（推奨）

- `vMAJOR.MINOR.PATCH` （Semantic Versioning）
- 例: `v0.1.0`, `v0.2.0`, `v1.0.0`

### 5.3 タグ作成・発行手順

#### 5.3.1 ローカルでタグを作成

```bash
git tag -a v0.1.0 -m "initial SDD workspace baseline"
```

#### 5.3.2 リモートにプッシュ

```bash
git push origin v0.1.0
```

複数のタグを一度にプッシュする場合：
```bash
git push origin --tags
```

#### 5.3.3 タグの確認

```bash
git tag -l
git show v0.1.0
```

### 5.4 リリース時の流れ

1. `main` の内容が確定したことを確認
2. [CHANGELOG.md](../CHANGELOG.md) にリリース内容を記載
3. タグを作成
4. GitHub Releases で説明を追加（オプション）

詳細は [.github/BRANCH_PROTECTION.md](.github/BRANCH_PROTECTION.md) の ブランチ保護設定と合わせて参照してください。

## 6. 最小リリース手順

1. 作業ブランチを作成して変更する
2. コミットして GitHub に push する
3. PR を作成しレビューを受ける
4. `main` にマージする
5. 必要に応じてタグを作成する

## 7. 本リポジトリ特有の注意

- 方針判断は [Constitution.md](Constitution.md) を最上位とする
- バイナリ原本と中間生成物は [.gitignore](.gitignore) に従って管理する
- 最終成果物はカテゴリ配下（`categories/*/output`）に集約する
