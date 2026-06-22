---
name: sdd-requirements-quality-gate
description: SDDカテゴリのSpecify要件品質を、What/Why専用ゲート、受入条件チェック、出力先整合チェックで検証する。
---

# SDD 要件品質ゲート

## 使用するタイミング
- `01_specify/<request-folder>/requirements.md` を新規作成または更新したとき。
- `02_plan/` へ進む前に、短時間で一貫した品質ゲートを行いたいとき。
- 固定チェックリストと固定出力で、レビュー時のトークン消費を抑えたいとき。

## 使用しないタイミング
- アーキテクチャやツール選定など、実装詳細（How）を設計しているとき。
- `03_tasks/` のタスク粒度を検証しているとき。

## 必須入力
- 対象ファイルパス（`categories/<category>/01_specify/<request-folder>/requirements.md`）
- カテゴリ名と対象スコープ
- 任意: 同一カテゴリの関連 `README.md`

## 出力契約
以下の順序で必ず出力すること:
1. `判定サマリー`（合格/不合格）
2. `Fail項目`（該当がある場合）
3. `修正提案`（最小変更での修正方針）
4. `次工程引き継ぎ`（What/Whyのみ）

## ゲート判定ルール
1. What/Why 分離:
- `01_specify` は What と Why のみを定義する。
- How レベルの記述（ツール選定、構成設計、実装順序）があれば Fail。

2. 要件の検証可能性:
- すべての要件は検証可能であること。
- 各要件に少なくとも1つの測定可能な受入条件を持つこと。

3. 非機能観点の網羅:
- 必要に応じて運用・セキュリティ・信頼性・コスト観点が含まれていること。

4. 制約整合:
- `Constitution.md` のルールと矛盾しないこと。
- 出力先は同一カテゴリ内スコープを維持すること。

5. 曖昧表現チェック:
- 「適切に」「迅速に」「必要に応じて」のような測定不能表現を検出して指摘する。

## 手順
1. `Constitution.md` とカテゴリ `README.md` を読む。
2. 対象の `01_specify/<request-folder>/requirements.md` を読む。
3. ルール1-5に対して評価する。
4. 出力契約に従って結果を返す。
5. Fail がある場合は、最小限の文面修正のみ提案する。

## すぐ使えるプロンプト例
- 「`sdd-requirements-quality-gate` を `categories/01_監視_モニタリング/01_specify/cpu-alert-threshold-tuning/requirements.md` に実行して」
- 「カテゴリ07のSpecifyに対して What/Why 専用ゲートを実行して」

## 応答テンプレート
```markdown
## 判定サマリー
- 判定: 合格|不合格
- カテゴリ: <name>
- ファイル: <path>

## Fail項目
- <id>: <課題>

## 修正提案
- <最小で安全な修正>

## 次工程引き継ぎ
- What:
- Why:
- Plan向け未確定事項:
```
