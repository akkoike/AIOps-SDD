---
name: sdd-spec-plan-alignment
description: 各カテゴリのSpecifyとPlanの整合を確認し、ドリフトを検知して低トークンで集中修正案を作成する。
---

# SDD Specify-Plan 整合チェック

## 使用するタイミング
- `01_specify/<request-folder>/requirements.md` と `02_plan/<request-folder>/` 文書が存在するとき。
- Tasks/Implement に進む前に、要件ドリフトを検出したいとき。
- 全文再レビューではなく、差分中心の短いレポートが必要なとき。

## 使用しないタイミング
- `02_plan/<request-folder>/` が未作成のとき。
- コード品質や実行時挙動をレビューしているとき。

## 必須入力
- カテゴリルートパス（`categories/<category>/`）
- `01_specify/<request-folder>/requirements.md`
- 主要Plan文書（例: `02_plan/<request-folder>/architecture.md`, `02_plan/<request-folder>/assessment-design.md`, `02_plan/<request-folder>/adr-summary.md`）

## 出力契約
以下の順序で必ず出力すること:
1. `整合結果`（整合/ドリフト）
2. `差分一覧`（要件のみ、計画のみ、競合）
3. `優先修正順`（上位3件）
4. `適用パッチ方針`（どのファイルから直すか）

## 整合判定ルール
1. 要件トレーサビリティ:
- 主要な What 要件には、Plan 側で対応する How 判断が存在すること。

2. スコープ保持:
- Plan は、Specify で根拠のないスコープ外機能を追加しないこと。

3. ADR 完結性:
- Plan の重要判断には、採用理由と不採用代替案を含むこと。

4. 制約継承:
- Plan はカテゴリ内の出力境界と Constitution の制約を遵守すること。

5. 用語一貫性:
- 主要ドメイン用語は Specify と Plan で一致していること。

## 手順
1. `01_specify/<request-folder>/requirements.md` から主要要件を抽出する。
2. `02_plan/<request-folder>/*` から設計判断を抽出する。
3. トレース行列（要件 -> Plan判断）を作成する。
4. 不足・過剰・衝突の項目を抽出する。
5. 優先ファイル付きで最小修正順を返す。

## すぐ使えるプロンプト例
- 「カテゴリ01に `sdd-spec-plan-alignment` を実行して、ドリフトだけ表示して」
- 「カテゴリ11の spec-plan 整合を上位3修正つきで確認して」

## 応答テンプレート
```markdown
## 整合結果
- 状態: 整合|ドリフト
- カテゴリ: <name>

## 差分一覧
- 要件のみ:
- 計画のみ:
- 競合:

## 優先修正順
1. <item>
2. <item>
3. <item>

## 適用パッチ方針
- 最初に修正するファイル:
- 理由:
- 最小修正内容:
```
