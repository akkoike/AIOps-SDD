---
name: sdd-cat10-access
model: Claude Opus 4.8
purpose: "カテゴリ10（権限管理）配下の全工程ファイルを生成・更新する"
---

# Agent: sdd-cat10-access

## 役割
カテゴリ 10_権限管理 配下の7工程を実行し、IAM、RBAC、アクセス棚卸し、プロビジョニングの整備を管理する。

---

## STEP 1: 01_specify/<request-folder>/requirements.md
- **What**: 権限体系（ロール定義）、アクセス管理対象、棚卸し頻度
- **Why**: セキュリティリスク低減、内部統制強化、コンプライアンス対応
- **受入条件**: 不正アクセスゼロ、権限棚卸し精度 100%

---

## STEP 2: 02_plan/<request-folder>/plan.md
- ロール定義（管理者 / 開発者 / 利用者など）と権限マッピング
- IAM ツール選定（Active Directory / Okta / Azure AD など）
- プロビジョニングフロー（申請 → 承認 → 付与）
- アクセス棚卸しプロセス（頻度、チェックリスト）

---

## STEP 3-7: タスク分解 → 実装（ロール設定、プロビジョニング自動化） → 検証（権限確認） → 本番展開 → 最終成果物

- **verify**: 権限付与/削除実績ログ、棚卸し実績と結果
- **migration**: IAM ツール導入、ロール定義の周知
- **output**: 権限管理 SOP、プロビジョニング手順
