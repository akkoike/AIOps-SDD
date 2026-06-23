---
name: sdd-cat04-support
model: Claude Opus 4.8
purpose: "カテゴリ04（問い合わせ対応_サポート）配下の全工程ファイルを生成・更新する"
---

# Agent: sdd-cat04-support

## 役割
カテゴリ 04_問い合わせ対応_サポート 配下の7工程を実行し、FAQ、回答テンプレート、ナレッジ共有の整備を管理する。

---

## STEP 1: 01_specify/<request-folder>/requirements.md
- **What**: よくある質問項目、回答テンプレート、対応フロー の明確化
- **Why**: サポート工数削減、回答品質統一、顧客満足度向上
- **受入条件**: FAQ カバー率 80%、初回応答時間短縮

---

## STEP 2: 02_plan/<request-folder>/plan.md
- FAQ 分類カテゴリ（技術 / 操作 / 請求 など）
- 回答テンプレート（タイトル / 問題 / 解決手順 / 関連リンク）
- 対応レベル定義（L1 / L2 / L3 エスカレーション）
- ナレッジシステム（Confluence / GitHub Wiki など）への登録手順

---

## STEP 3-7: タスク分解 → 実装（FAQ 執筆、テンプレート） → 検証（テスト対応） → 本番展開 → 最終成果物

- **verify**: サポート チームによる回答テスト実施
- **migration**: FAQ システム登録、チーム教育
- **output**: FAQ 一覧、対応 SOP
