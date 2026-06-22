# scripts

このフォルダは、特定カテゴリに属さない共通スクリプトの配置先です。

## 配置ルール
- カテゴリ専用スクリプトは `categories/<category>/` 配下に配置する。
- 複数カテゴリで再利用するスクリプト、またはカテゴリ非依存の補助スクリプトは本フォルダに配置する。
- スクリプト名は用途が分かる英数字ハイフン区切りを推奨する。

例:
- `scripts/normalize-request-folder-name.ps1`
- `scripts/export-hearing-result.ps1`
