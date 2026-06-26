# SDD 開始プロンプト（ルーター判定用 / 対話型実行ガイド）

## 🚀 クイックスタート

### オプション 1: Copilot Chat で対話ヒアリング（推奨 / 新型7フェーズ自動連鎖）

実行方法:
1. このチャットで「ヒアリング開始」と入力する。
2. `.github/agents/sdd-hearing-subagent-sample.md` に従い、8 つの質問を順番に実施する（各質問で選択肢 + 自由入力）。
   - **依頼種別で「既存更新」が選ばれた場合は**、カテゴリ仮判定後に対象カテゴリ配下の既存 request-folder を列挙し、どのテーマを対象に「追加/修正/削除」するかを選択させる。
3. 回答内容から `.github/agents/agents.md` の sdd-router によりカテゴリを自動判定する。
4. 判定されたカテゴリのエージェント実装（例：01 なら `sdd-cat01-monitoring`、02 なら `sdd-cat02-ops-tooling`）が以下の 7 フェーズを **自動連鎖** で実行：
   - **Phase 1**: Specify-Plan同期工程 → requirements.md (What/Why) + plan.md (How) 同時生成 + sdd-spec-plan-alignment で同期確認
   - **Phase 2**: Tasks工程 → tasks.md 自動生成
   - **Phase 3**: Implement工程 → sdd-code-generator-cat# でコード生成 + build.log
   - **Phase 4**: Verify工程 → sdd-verifier-cat# で受入検証 + verification.md + test-results.json
   - **Phase 5**: Migration工程 → migration.md 自動生成
   - **Phase 6**: Output工程 → result.md 自動生成
   - **Phase 7**: 品質ゲート → sdd-quality-gate で全工程品質チェック + quality-gate-report.md
5. 全フェーズ完了後、変更ファイル一覧と品質判定をユーザーへ報告する。

**重要**: 各フェーズ進行条件は agents.md 「フェーズ連鎖定義」を参照。前フェーズが条件を満たさない場合は修正して再実行する。

### オプション 2: 手動実行（プロンプト入力）

以下のプロンプトをそのままコピーして、Claude Opus 4.8 に入力してください。

---

あなたは SDD ルーターです。必ず `.github/agents/agents.md` に従って判定してください。

## 目的
以下のパイプラインを一気通貫で実行し、依頼に対応する全工程ファイルを生成する。

```
[STEP 1] ヒアリング
  sdd-hearing-subagent-sample.md に従い 8 項目を収集する
      ↓
[STEP 2] カテゴリ判定
  agents.md の sdd-router により 01〜12 のカテゴリを判定する
      ↓
[STEP 3] 全工程ファイル生成
  判定カテゴリ別エージェント（sdd-cat01-monitoring / sdd-cat02-ops-tooling / ... / sdd-cat12-governance）により
  01_specify → 02_plan → 03_tasks → 04_implement → 05_verify → 06_migration → output
  を順番に生成・記入する
      ↓
[STEP 4] 品質ゲート
  agents.md の sdd-quality-gate により整合チェックを実施する
      ↓
[STEP 5] 報告
  変更ファイル一覧と次アクションをユーザーへ返す
```

## 入力（Claude Opus 4.8 でヒアリング）
以下のサブエージェントを呼び出し、依頼者ヒアリングを実施してから判定すること。

### サブエージェント呼び出し
- subagent: Claude Opus 4.8
- mission: SDDカテゴリ判定に必要な要件ヒアリング
- context: [.github/agents/sdd-hearing-subagent-sample.md](../agents/sdd-hearing-subagent-sample.md) に従い、全ヒアリング質問と出力フォーマットを実施する

ヒアリング手順:
1. サブエージェントに sdd-hearing-subagent-sample.md の実行プロンプトを提供する
2. 依頼種別・タイトル・本文・背景・期限・制約・成果物・受入条件の8項目をすべて収集する
3. 回答不足がある場合は、同サブエージェントで追加質問を実施する
4. 収集結果を下記のヒアリング結果テンプレートに転記する

### ヒアリング結果（今回の依頼）
- 依頼種別: {{新規 / 既存更新}}
- 対象テーマ（既存更新時のみ）: {{既存 request-folder 名 / 新規の場合は「該当なし」}}
- 操作種別（既存更新時のみ）: {{追加 / 修正 / 削除 / 複合 / 新規の場合は「該当なし」}}
- 依頼タイトル: {{依頼タイトル}}
- 依頼本文: {{依頼本文}}
- 背景: {{背景}}
- 期限/優先度: {{期限・優先度}}
- 制約: {{制約}}
- 成果物の期待形: {{成果物の期待形}}
- 受入条件: {{受入条件}}

## 実施ルール
1. まずカテゴリを 01〜12 から1つ選ぶ（複数候補がある場合は第1候補と第2候補を提示）。
2. 判定根拠をキーワードベースで明記する。
3. 更新対象は必ず `categories/<category>/` 配下を使う。
4. **依頼種別により request-folder の扱いを分岐させる（必須）**。
   - **新規**: 初回から `01_specify` `02_plan` `03_tasks` `04_implement` `05_verify` `06_migration` `output` の全工程を、依頼タイトルを正規化した**新しい request-folder**配下に作成する。
   - **既存更新**: **新規 request-folder を作成せず**、ヒアリングで特定した**既存 request-folder** を対象とする。同フォルダ配下の既存 7 工程ファイルを読み込み、操作種別（追加/修正/削除）に従って内容を反映し、**同じフォルダへ上書き保存**する。
   - **既存更新時の差分最小化（必須）**: 変更が**大幅でない場合**（影響範囲が限定的な項目追加・小規模修正・部分削除など）は、**既存の仕様・設計・タスク工程を全面的に書き換えず、最小限の追記と更新に留める**。
     - 既存の章立て・記述・受入条件・データモデル等は**可能な限りそのまま維持**し、変更箇所のみを差分として追記・修正する（例: 受入条件は新規 AC を末尾に追加、データモデルは行追加、各工程は「変更履歴／追加要件」節への追記を基本とする）。
     - 既存記述の削除・全面改稿は、**その記述が今回の変更と直接矛盾する場合に限る**。それ以外は温存する。
     - **大幅変更（全面変更）と判断する場合のみ**、仕様・設計・タスク工程の全面的な再作成を行う。大幅変更か否かが曖昧なときは、**最小限の追記を既定**とし、全面変更が必要かをユーザーに一度確認する。
     - 確認・レビューの負荷を下げるため、変更点は「どのファイルのどこに何を追記/修正したか」が分かる形で簡潔に提示する。
5. 新規の場合のみ、`01_specify` だけでなく `02_plan` `03_tasks` `04_implement` `05_verify` `06_migration` `output` も、依頼ごとの新規フォルダ（`<request-folder>`）配下にマークダウンを配置する。
   - フォルダ名は依頼タイトルを英数字ハイフン区切りへ正規化して作成する。
   - 例: `ai-ops-task-web-ui`
6. 次に `02_plan/<request-folder>/plan.md` へ進む条件を明記する。
7. 最後に sdd-quality-gate をどのタイミングで挿入するか明記する。
8. 各カテゴリに属さないスクリプトは `scripts/` 配下に新規作成して配置する。
9. ヒアリング完了後は、**カテゴリ配下7工程のMarkdown生成を完了するまで**、`tools/` 配下への単独実装を禁止する。
10. 実装アプリは原則 `categories/<category>/04_implement/<request-folder>/` に配置し、`tools/` は補助用途（共通ツール置き場）として扱う。
11. もし先に `tools/` へ作成した場合は、同一ターン内でカテゴリ配下へ移設または複製し、工程ドキュメントへ参照を反映する。

## 12カテゴリ（判定先）
- 01: 監視_モニタリング
- 02: 運用補佐ツール開発_管理
- 03: インシデント_障害対応
- 04: 問い合わせ対応_サポート
- 05: 変更_リリース管理
- 06: 構成管理_資産管理
- 07: セキュリティ管理
- 08: バックアップ_リカバリ
- 09: キャパシティ管理
- 10: 権限管理
- 11: コスト管理
- 12: 統制管理

## 出力フォーマット（この形式を厳守）
### 1) ルーター判定
- 第1候補カテゴリ: <番号_カテゴリ名>
- 第2候補カテゴリ: <番号_カテゴリ名 or なし>
- 信頼度: <High/Medium/Low>
- 判定根拠キーワード: <3〜8個>

### 2) 初回更新対象
- 依頼種別: <新規 / 既存更新>
- 対象 request-folder: <既存更新時は既存フォルダ名 / 新規時は正規化した新規フォルダ名>
- 操作種別: <既存更新時は 追加/修正/削除/複合 / 新規時は「新規作成」>
- requirements: categories/<category>/01_specify/<request-folder>/requirements.md
- plan: categories/<category>/02_plan/<request-folder>/plan.md
- tasks: categories/<category>/03_tasks/<request-folder>/tasks.md
- implement: categories/<category>/04_implement/<request-folder>/implement.md
- verify: categories/<category>/05_verify/<request-folder>/verification.md
- migration: categories/<category>/06_migration/<request-folder>/migration.md
- output: categories/<category>/output/<request-folder>/result.md
- common-scripts: scripts/<script-name>.(ps1|py|sh)
- 備考（既存更新時）: 上記パスの `<request-folder>` は**既存フォルダ**を指す。新規フォルダは作成せず、既存ファイルを読み込んで反映する。

### 3) 今回の着手手順（最大7手順）
1. <手順>
2. <手順>
3. <手順>

### 4) Planへ進むゲート条件
- <条件1>
- <条件2>
- <条件3>

### 5) 品質ゲート挿入ポイント
- 要件品質ゲート: <いつ実施するか>
- Specify-Plan整合ゲート: <いつ実施するか>
- Verify証跡ゲート: <いつ実施するか>

### 6) 未確定事項（あれば）
- <確認質問1>
- <確認質問2>

---

## ▶ ルーター判定後の続行指示

ルーター判定（上記 1)〜6) の出力）が完了したら、**停止せずに直ちに以下を続行すること**。

1. 判定されたカテゴリのエージェント実装ファイルを起動する
   - **01_監視_モニタリング** → [sdd-cat01-monitoring.md](../agents/sdd-cat01-monitoring.md)
   - **02_運用補佐ツール開発_管理** → [sdd-cat02-ops-tooling.md](../agents/sdd-cat02-ops-tooling.md)
   - **03_インシデント_障害対応** → [sdd-cat03-incident.md](../agents/sdd-cat03-incident.md)
   - **04_問い合わせ対応_サポート** → [sdd-cat04-support.md](../agents/sdd-cat04-support.md)
   - **05_変更_リリース管理** → [sdd-cat05-change-release.md](../agents/sdd-cat05-change-release.md)
   - **06_構成管理_資産管理** → [sdd-cat06-config-asset.md](../agents/sdd-cat06-config-asset.md)
   - **07_セキュリティ管理** → [sdd-cat07-security.md](../agents/sdd-cat07-security.md)
   - **08_バックアップ_リカバリ** → [sdd-cat08-backup-recovery.md](../agents/sdd-cat08-backup-recovery.md)
   - **09_キャパシティ管理** → [sdd-cat09-capacity.md](../agents/sdd-cat09-capacity.md)
   - **10_権限管理** → [sdd-cat10-access.md](../agents/sdd-cat10-access.md)
   - **11_コスト管理** → [sdd-cat11-cost.md](../agents/sdd-cat11-cost.md)
   - **12_統制管理** → [sdd-cat12-governance.md](../agents/sdd-cat12-governance.md)
2. ヒアリング結果と判定カテゴリを入力として渡す
3. カテゴリ別エージェントは下記の順で全工程ファイルを生成・記入する
   - `01_specify/<request-folder>/requirements.md` — What / Why / 受入条件
   - `02_plan/<request-folder>/plan.md` — 実装手順 / 影響範囲 / ロールバック方針
   - `03_tasks/<request-folder>/tasks.md` — タスク分解 / 優先度 / 担当
   - `04_implement/<request-folder>/implement.md` — 実装内容 / 変更履歴
   - `05_verify/<request-folder>/verification.md` — 検証手順 / 証跡リンク
   - `06_migration/<request-folder>/migration.md` — 展開手順 / 引き継ぎ事項
   - `output/<request-folder>/result.md` — 最終成果物 / 利用者向け要約
4. 全工程の生成完了後、`sdd-quality-gate` を実行して品質を確認する
5. 変更ファイル一覧と次アクションをユーザーへ報告する

## 実行ガード（必須）
- ガード1: `01_specify` から `output` までの7ファイルが未作成の場合、実装工程以外を優先して生成する。
- ガード2: `04_implement` で実装物を作成した場合、`05_verify` と `06_migration` を同一ターンで作成する。
- ガード3: 最終報告時に、7工程の実ファイルパスを全て列挙する。
- ガード4: 実行可能成果物（Web UI / CLI / バッチ / スクリプト）がある場合、`05_verify` で起動コマンドを実行し、終了コードと主要出力を記録する。
- ガード5: Web UI がある場合、初回アクセス（`http://localhost:<port>`）の可否を確認し、結果と根拠を `05_verify` に記録する。未確認は PASS 禁止。
- ガード6: ヒアリング開始以降、`.github/` 配下（本プロンプト・`agents/`・`skills/` などのワークフロー定義ファイルやフォルダ）を**生成・編集・削除しない**。これらはワークフロー定義であり依頼の成果物ではない。「ヒアリング結果（今回の依頼）」テンプレートにも実回答を書き込まず、回答はチャット応答内に保持して `categories/<category>/` 配下の成果物へ反映する。`.github/` 配下の変更は、ユーザーが明示的に依頼した場合のみ許可する。


