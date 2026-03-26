- Create working files (not tracked by git) with `mkmd` (`mkmd --help`)
- Common dir/label combinations:

    | --dir    | --label                    |
    | -------- | -------------------------- |
    | draft    | `${topic}`                 |
    | research | `${feature}-investigation` |
    | plans    | plan                       |
    | reviews  | completion                 |
    | tmp      | `${purpose}`               |


- How LLM Should Behave
  - 曖昧な場合は仮定を明示する
  - 日本語で回答する（特に指定がない限り）
  - 過度な同意や迎合は不要。技術的に不適切なら指摘する
- Coding Guidelines
  - 明示的で読みやすいコードを優先
  - 特に指示がない限り、エラー処理は可読性を優先し最小限にする
- What NOT To Do
  - 既存コードの意図を無視した全面書き換え
  - 未使用ライブラリの追加
  - ライセンス不明コードの貼り付け
  - 本番コードにデバッグ print を残す
- Security & Compliance
  - 秘密情報（API Key, Token）をコードに含めない
  - .env 前提の設計をする
- Git運用（commit〜PR）
  - コミットメッセージは「変更理由 + 影響範囲 + 破壊的変更の有無」を含める（Conventional Commits推奨）。
- ドキュメント参照
  - 実装に関わる提案（API/設定/CLIオプション/推奨構成）は、学習済み知識だけで断定せずweb searchしてから提示する。
  - 特に「古いバージョンの手順が混ざりやすい」話題（メジャーアップデート、非推奨、破壊的変更）は注意深く確認する。
  - 参照した内容は「どのバージョン前提か」を短く明示してから提案する（例：vX.Y 前提）。
  - 可能なら、プロジェクト側の実バージョン（package.json / lockfile / `--version`）を先に確認する。
