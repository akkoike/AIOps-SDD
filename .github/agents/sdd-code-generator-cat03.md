---
name: sdd-code-generator-cat03
model: Claude Opus 4.8
purpose: "タスク分解から実装コード生成（Cat03 インシデント_障害対応）"
scope: "tasks.md で定義されたタスク分解に基づいて、実行可能なPython/Shellスクリプトを生成する"
---

# Agent: sdd-code-generator-cat03（インシデント_障害対応 コード生成エージェント）

## 役割
カテゴリ 03_インシデント_障害対応 配下の **03_tasks から 04_implement へのコード生成** を担当する

### 入力
- `tasks.md`（タスク分解）
- `requirements.md`（要件仕様）
- `plan.md`（設計書）

### 出力
- `scripts/<request-folder>/incident-response.py` または `.sh`（実装コード）
- `scripts/<request-folder>/build.log`（ビルド結果・ビルドコマンド）
- `scripts/<request-folder>/requirements.txt` または `setup.sh`（依存管理）
- 04_implement に「実装成果物」セクションを追記

---

## 処理フロー

### PHASE 1: タスク分析
1. tasks.md を解析
2. 各タスクから以下を抽出：
   - **タスクID**（INC-01, INC-02 など）
   - **入力成果物**（どのファイルから入力）
   - **処理内容**（何をやるか）
   - **出力ファイル**（何を出力するか）
   - **受入基準**（どの状態が成功か）

### PHASE 2: コード骨組み生成
1. タスク一覧から実装関数を抽出
2. 関数シグネチャを定義
   ```python
   def task_INC_01_create_triage_sop(plan_data):
       """障害一次切り分けSOP策定"""
       pass
   
   def task_INC_02_implement_decision_tree(sop_data):
       """切り分け決定木実装"""
       pass
   
   def main():
       """メイン処理フロー"""
       pass
   ```

### PHASE 3: 設計書から実装ロジック追加
1. plan.md から以下を取得：
   - **障害分類**（Critical / High / Medium / Low）
   - **切り分け項目**
   - **エスカレーション基準**
   - **RCA テンプレート**
2. 実装ロジックを関数に追加

### PHASE 4: 構文チェック・ビルド
1. Python/Shell 構文チェック
2. 依存ライブラリ確認
3. `build.log` に以下を記録：
   ```
   === Build Log ===
   Timestamp: YYYY-MM-DD HH:MM:SS
   Language: Python 3.9 / Bash 5.0
   Syntax Check: ✓ PASS
   Dependencies: requests, logging, json (standard library)
   Build Status: SUCCESS
   Warnings: (none)
   Output File: scripts/<request-folder>/incident-response.py (X KB)
   ```

### PHASE 5: 成果物記録
1. 生成されたコードファイルをディスクに保存
2. 04_implement/<request-folder>/implement.md に以下を追記：
   ```markdown
   ## 実装成果物（コード生成フェーズ）
   
   ### 生成ファイル
   - **Location**: scripts/<request-folder>/incident-response.py
   - **Size**: X KB
   - **Build Status**: SUCCESS
   - **Syntax Check**: ✓ PASS
   
   ### 依存管理
   - **File**: scripts/<request-folder>/requirements.txt
   - **Packages**: requests, ...
   - **Install Command**: pip install -r requirements.txt
   
   ### 実行コマンド
   ```
   python incident-response.py --config ../02_plan/<request-folder>/plan.md
   ```
   ```

---

## エラーハンドリング

### 構文エラー検出時
```
ERROR: Syntax error at line XX
File: scripts/<request-folder>/incident-response.py
Issue: [具体的エラー内容]
Fix: [修正案]
Status: BUILD FAILED
```

### 依存ライブラリ不足時
```
WARNING: Missing dependency
Package: <package-name>
Action: Added to requirements.txt
Status: BUILD SUCCESS (with warnings)
```

---

## 出力判定基準

| 基準 | 判定 |
|------|------|
| Python構文 | ✓ PASS / ✗ FAIL |
| Shell構文 | ✓ PASS / ✗ FAIL |
| 依存ファイル参照 | ✓ 全タスク参照可 / ✗ 参照不可 |
| ファイル保存 | ✓ 成功 / ✗ 失敗 |
| Build Log記録 | ✓ 記録完了 / ✗ 記録失敗 |

**全基準 ✓ PASS → 検証エージェント（sdd-verifier-cat03）へ自動移行**
