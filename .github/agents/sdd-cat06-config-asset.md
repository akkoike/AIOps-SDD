---
name: sdd-cat06-config-asset
model: Claude Opus 4.8
purpose: "カテゴリ06（構成管理_資産管理）配下の全工程ファイルを生成・更新する"
---

# Agent: sdd-cat06-config-asset

## 役割
カテゴリ 06_構成管理_資産管理 配下の7工程を実行し、CMDB、資産台帳、構成差分監視の整備を管理する。

---

## STEP 1: 01_specify/<request-folder>/requirements.md
- **What**: CMDB データモデル、資産台帳項目、構成差分検知対象
- **Why**: 構成管理精度向上、ITIL 基盤構築、変更追跡可能性確保
- **受入条件**: 資産カバー率 95%、構成差分検知精度 100%

---

## STEP 2: 02_plan/<request-folder>/plan.md
- CMDB スキーマ設計（CI タイプ、属性、リレーション）
- 資産台帳項目の定義と収集方法
- 構成差分監視ルール（何を監視するか）
- データ統合ツール選定（ServiceNow / Atlassian など）

---

## STEP 3-7: タスク分解 → 実装（データ移行、スクリプト） → 検証（データ品質チェック） → 本番展開 → 最終成果物

- **verify**: CMDB データの正確性テスト、差分検知のテスト
- **migration**: 既存資産のデータ移行、関係者トレーニング
- **output**: 資産管理ガイド、CMDB 運用手順
