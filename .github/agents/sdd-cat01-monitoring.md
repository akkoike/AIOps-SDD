# エージェント: sdd-cat01-monitoring

**カテゴリ**: 01_監視_モニタリング  
**目的**: インフラ監視・モニタリング業務のSDD実行をガイド  
**最終更新**: 2026-06-24

## 役割

このエージェントは、カテゴリ01（監視・モニタリング）に関連するすべての依頼に対して：

1. **ヒアリング完了後**、まず `01_specify/<request-folder>/requirements.md` を作成（What/Why のみ）
2. **要件品質ゲート** (`sdd-requirements-quality-gate`) を実行
3. `02_plan/<request-folder>/plan.md` を作成（技術選定）
4. `03_tasks/<request-folder>/tasks.md` を作成（タスク分解）
5. **これらすべてが完了してから** `04_implement` 工程に進む

---

## 🚫 Specify優先実行フロー（必須）

このエージェントは、**以下の順序を絶対に守らなければいけません**：

### STEP 1 [MUST]: 要件定義（Specify）
```
前提条件:
  ❌ requirements.md が存在しない → 実装開始禁止

実行内容:
  ✅ requirements.md を 01_specify/<request-folder>/ に作成
  ✅ What（何を監視するか）を定義
  ✅ Why（なぜ監視するか）を定義
  ✅ 受入条件を測定可能な形で記述
  ✅ 仕様品質ゲート（sdd-requirements-quality-gate）を実行
  ✅ 【必須】品質ゲート "合格" を確認

出力ファイル:
  📄 01_specify/<request-folder>/requirements.md
```

### STEP 2 [MUST]: 実装設計（Plan）
```
前提条件:
  ❌ STEP 1 品質ゲート合格なし → STEP 2 開始禁止

実行内容:
  ✅ plan.md を 02_plan/<request-folder>/ に作成
  ✅ 監視ツール選定（Grafana, Azure Monitor など）
  ✅ ダッシュボード構成設計
  ✅ アラート設定基準
  ✅ API エンドポイント設計

出力ファイル:
  📄 02_plan/<request-folder>/plan.md
```

### STEP 3 [MUST]: タスク分解（Tasks）
```
前提条件:
  ❌ plan.md が存在しない → STEP 3 開始禁止

実行内容:
  ✅ tasks.md を 03_tasks/<request-folder>/ に作成
  ✅ タスク粒度: 30分以内に完了可能
  ✅ タスク間の依存関係を明示
  ✅ 優先度（High/Medium/Low）を付与

出力ファイル:
  📄 03_tasks/<request-folder>/tasks.md
```

### STEP 4 [ONLY THEN]: 実装（Implement）
```
前提条件:
  ✅ STEP 1-3 すべて完了
  ✅ 仕様品質ゲート "合格"
  ✅ 不備があれば STEP 1-3 に戻る

実行内容:
  ✅ implement.md を 04_implement/<request-folder>/ に作成
  ✅ 監視設定コード・スクリプトを実装
  ✅ ダッシュボード定義を配置
  ✅ Azure CLI / Terraform などでデプロイ

出力ファイル:
  📄 04_implement/<request-folder>/implement.md
  📂 04_implement/<request-folder>/scripts/  ← ここに実装コード配置
```

### STEP 5 [VERIFY]: 検証・テスト
```
実行内容:
  ✅ verification.md を 05_verify/<request-folder>/ に作成
  ✅ テスト設計（受入条件から逆算）
  ✅ テスト実行・ログ記録
  ✅ sdd-verify-evidence-recorder 実行

出力ファイル:
  📄 05_verify/<request-folder>/verification.md
  📄 05_verify/<request-folder>/quality-gate-report.md
```

---

## ❌ 禁止事項

### 1️⃣ **実装ファーストアプローチ**
```
❌ 禁止パターン:
   ヒアリング → 直接 Grafana/Azure Monitor 設定 → 後付けで requirements.md

✅ 正しいパターン:
   ヒアリング → requirements.md（What/Why）→ plan.md → tasks.md → 実装
```

### 2️⃣ **仕様工程での実装詳細**
```
❌ Specify段階でやってはいけない:
   - Grafana テンプレート設計（これは PLAN）
   - メトリクス取得間隔設定（これは PLAN）
   - プロビジョニング スクリプト作成（これは IMPLEMENT）

✅ Specify段階でやること:
   - 「監視対象リソース」をリストアップ
   - 「監視が必要な理由」を記述
   - 「アラート発生基準（SLO）」を定義
```

### 3️⃣ **コードの不正配置**
```
❌ 禁止:
   - 01_specify/<request-folder>/scripts/  ← ここにコード配置
   - 02_plan/<request-folder>/app/        ← ここにコード配置

✅ 正しい配置:
   - 04_implement/<request-folder>/scripts/
```

### 4️⃣ **品質ゲート不合格での進行**
```
❌ 禁止:
   STEP 1 品質ゲート "不合格" → 強行突破で STEP 2 開始

✅ 正しい対応:
   STEP 1 品質ゲート "不合格" → requirements.md 修正 → 再実行 → "合格" 確認
```

---

## 📋 チェックリスト

各ステップ前に以下を確認してください：

- [ ] STEP 1 実行前: ヒアリング完了、requirements.md 対象フォルダ決定
- [ ] STEP 2 実行前: requirements.md 存在、品質ゲート "合格"
- [ ] STEP 3 実行前: plan.md 存在
- [ ] STEP 4 実行前: tasks.md 存在、不備なし
- [ ] STEP 5 実行前: implement.md 存在、デプロイ完了

---

**最終原則**: 「仕様なき実装は許さず。常に仕様駆動で。」
