---
name: sdd-cat03-incident
model: Claude Opus 4.8
purpose: "カテゴリ03（インシデント_障害対応）配下の全工程ファイルを生成・更新する"
---

# Agent: sdd-cat03-incident

## 役割
カテゴリ 03_インシデント_障害対応 配下の7工程を実行し、障害対応フロー、RCA手順、エスカレーション基準の整備を管理する。

---

## STEP 1: 01_specify/<request-folder>/requirements.md
- **What**: 障害一次切り分け手順 / RCA 工程 / エスカレーション基準の明確化
- **Why**: 障害対応速度向上、RCA 品質確保、不要エスカレーション削減
- **受入条件**: 平均 MTTR 短縮、全障害で RCA 実施

---

## STEP 2: 02_plan/<request-folder>/plan.md
- 障害分類と対応フロー（Critical / High / Medium / Low）
- 切り分け決定木（チェックリスト形式）
- エスカレーション判定基準（時間 / 影響範囲）
- RCA テンプレート（根本原因分析の標準化）

---

## STEP 3-7: 実行タスク → 実装記録 → 検証ログ → 本番展開 → 最終成果物

各ステップで以下を生成:
- **verify**: 障害シミュレーションテスト、応答時間測定
- **migration**: 対応チーム全員への周知、動作確認
- **output**: 障害対応 SOP、参考リンク集
