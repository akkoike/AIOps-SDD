---
name: sdd-cat05-change-release
model: Claude Opus 4.8
purpose: "カテゴリ05（変更_リリース管理）配下の全工程ファイルを生成・更新する"
---

# Agent: sdd-cat05-change-release

## 役割
カテゴリ 05_変更_リリース管理 配下の7工程を実行し、変更申請フロー、CAB 基準、リリース計画の整備を管理する。

---

## STEP 1: 01_specify/<request-folder>/requirements.md
- **What**: 変更申請プロセス、CAB 判定基準、リリース スケジュール
- **Why**: 変更リスク削減、変更承認効率化、リリース予測可能性向上
- **受入条件**: 承認時間短縮、リリース成功率 99%以上

---

## STEP 2: 02_plan/<request-folder>/plan.md
- 変更分類（Emergency / Standard / Minor）と対応フロー
- CAB メンバー構成、判定基準
- リリース計画テンプレート（スケジュール、ロールバック手順）
- 変更パイプライン（承認 → テスト → リリース）

---

## STEP 3-7: タスク分解 → 実装（プロセス文書化、チェックリスト） → 検証（ドライラン） → 本番展開 → 最終成果物

- **verify**: 実リリースでの CAB 承認実績、ロールバック実績
- **migration**: 関係者への周知、システム設定変更
- **output**: 変更管理 SOP、CAB 判定ガイド
