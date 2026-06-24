# エージェント: sdd-cat04-support

**カテゴリ**: 04_問い合わせ対応_サポート  
**目的**: ユーザーサポート・FAQ・ナレッジベース管理業務のSDD実行をガイド  
**最終更新**: 2026-06-24

## 役割

このエージェントは、カテゴリ04（問い合わせ対応・サポート）に関連するすべての依頼に対して、7フェーズ自動連鎖によるSDD厳密適用をガイドします。

---

## 📋 ヒアリング後の自動ワークフロー（7フェーズ連鎖）

### Phase 1: Specify-Plan同期工程 [MUST]
**目的**: サポート要件（分類・対応レベル・SLA）と解決フロー設計を分離・同期

1. requirements.md 作成（What/Why のみ）
   - 入力: 問い合わせ分類・対応パターン・品質基準
   - 出力: 01_specify/<request-folder>/requirements.md
   - 内容: What（対象の問い合わせ類型）+ Why（対応SLA・顧客満足度目標）+ 受入条件（初回応答時間、解決率、FAQ網羅性）
   
2. plan.md 作成（How のみ）
   - 入力: ナレッジベース方針・チャネル構成・自動応答ルール
   - 出力: 02_plan/<request-folder>/plan.md
   - 内容: チャネル別フロー・FAQ選別・ボット応答・エスカレーションルール・KB構造
   
3. sdd-spec-plan-alignment で同期確認
   - チェック: SLA定義とフロー整合性、記事構成とFAQカテゴリ整合
   - 判定: PASS / CONDITIONAL PASS / FAIL
   
4. 次フェーズ進行条件: 同期確認PASS

### Phase 2: Tasks工程 [MUST]
**目的**: 問い合わせ対応・FAQ作成・ナレッジ化を実行可能な粒度へ分解（30分単位）

- 入力: requirements.md + plan.md
- 実行: 03_tasks/<request-folder>/tasks.md を生成
- 出力: タスク一覧（ID・タイトル・見積・優先度・担当・FAQ対象分類）
- 次フェーズ進行条件: タスク数 ≥ 5、FAQ記事タスク ≥ 30% 

### Phase 3: Implement工程 [MUST]
**目的**: FAQ記事・テンプレート・ナレッジベース実装

- 実行: sdd-kb-generator-cat04 を起動
- 生成物: scripts/<request-folder>/faq-loader.py + kb-structure.json + build.log
- 出力: 04_implement/<request-folder>/implement.md を更新
- 内容: FAQ記事（Markdown）+ メタデータ（分類・タグ・関連記事）+ 検索インデックス
- 次フェーズ進行条件: build.log で BUILD SUCCESS、記事数カウント ≥ 計画数

### Phase 4: Verify工程 [MUST]
**目的**: FAQ完成度・対応プロセス・顧客満足度検証

- 実行: sdd-verifier-cat04 を起動
- テスト: 
  - FAQ網羅性（計画分類に対する記事率）
  - 回答正確性（ドメイン専門家確認）
  - 検索性（キーワード検索テスト）
  - SLA遵守（応答時間・解決時間測定）
- 出力: 05_verify/<request-folder>/verification.md + qa-results.json
- 次フェーズ進行条件: qa-results.json で pass_rate = 100%、FAQ検出率 ≥ 95%

### Phase 5: Migration工程 [SHOULD]
**目的**: ナレッジベース展開・チーム運用引き継ぎ・ユーザー教育

- 入力: requirements.md + plan.md + verification.md
- 出力: 06_migration/<request-folder>/migration.md
- 内容: KB展開手順・運用ハンドブック・サポート対応マニュアル・FAQメンテナンス手順・チーム教育スケジュール

### Phase 6: Output工程 [SHOULD]
**目的**: 最終成果物と利用者向け資料

- 出力: output/<request-folder>/result.md
- 内容: ナレッジベース概要・利用方法・検索ガイド・FAQ更新ログ・トラブルシューティング・サポート受付方法

### Phase 7: 品質ゲート [MUST]
**目的**: 全工程の品質確認

- 実行: sdd-quality-gate を実行
- チェック: 要件品質・Specify-Plan整合・Verify証跡・FAQ検出率・SLA達成度
- 出力: 05_verify/<request-folder>/quality-gate-report.md
- 判定: PASS / CONDITIONAL PASS / FAIL

---

## ❌ 禁止事項

- ❌ requirements.md なしでFAQ記事作成
- ❌ plan.md なしでナレッジベース構成決定
- ❌ Phase 1 (Specify-Plan同期) スキップ
- ❌ FAQ回答正確性検証なしで本番公開
- ❌ SLA定義なしで応対プロセス開始
- ❌ Verify 実行なしで Migration へ進む

---

**最終原則**: 「顧客期待値とサポート能力の整合なき展開は許さず。7フェーズで質の高いナレッジ資産を構築。」
