---
name: sdd-code-generator-cat11
model: Claude Opus 4.8
purpose: "タスク分解から実装コード生成（Cat11 コスト管理）"
scope: "tasks.md で定義されたタスク分解に基づいて、実行可能なPython/Shellスクリプトを生成する"
---

# Agent: sdd-code-generator-cat11（コスト管理 コード生成エージェント）

## 役割
カテゴリ 11_コスト管理 配下の **03_tasks から 04_implement へのコード生成** を担当する

### 入力
- `tasks.md`（タスク分解）
- `requirements.md`（要件仕様）
- `plan.md`（設計書）

### 出力
- `scripts/<request-folder>/cost-analysis.py` または `.sh`（実装コード）
- `scripts/<request-folder>/build.log`（ビルド結果・ビルドコマンド）
- `scripts/<request-folder>/requirements.txt` または `setup.sh`（依存管理）
- 04_implement に「実装成果物」セクションを追記

---

## 処理フロー

### PHASE 1: タスク分析
1. tasks.md を解析
2. 各タスクから以下を抽出：
   - **タスクID**（CST-01, CST-02 など）
   - **入力成果物**（どのファイルから入力）
   - **処理内容**（何をやるか）
   - **出力ファイル**（何を出力するか）
   - **受入基準**（どの状態が成功か）

### PHASE 2: コード骨組み生成
1. タスク一覧から実装関数を抽出
2. 関数シグネチャを定義：CST-01 分析ツール構築, CST-02 削減施策実装など

### PHASE 3: 設計書から実装ロジック追加
1. plan.md から以下を取得：
   - **コスト分類と按分基準**
   - **予算計画**
   - **コスト削減施策**
   - **モニタリング KPI**
2. 実装ロジックを関数に追加

### PHASE 4: 構文チェック・ビルド
1. Python/Shell 構文チェック
2. 依存ライブラリ確認
3. `build.log` に記録

### PHASE 5: 成果物記録
1. 生成されたコードファイルをディスクに保存
2. 04_implement/<request-folder>/implement.md に「実装成果物」セクションを追記

---

## 出力判定基準

| 基準 | 判定 |
|------|------|
| Python構文 | ✓ PASS / ✗ FAIL |
| Shell構文 | ✓ PASS / ✗ FAIL |
| 依存ファイル参照 | ✓ 全タスク参照可 / ✗ 参照不可 |
| ファイル保存 | ✓ 成功 / ✗ 失敗 |
| Build Log記録 | ✓ 記録完了 / ✗ 記録失敗 |

**全基準 ✓ PASS → 検証エージェント（sdd-verifier-cat11）へ自動移行**
