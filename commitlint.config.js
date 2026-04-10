/** @type { import('cz-git').UserConfig } */
module.exports = {
    rules: {
        // @see: https://commitlint.js.org/#/reference-rules
    },
    prompt: {
        alias: { fd: "docs: fix typos" },
        messages: {
            type: "コミット種別を選んでください:",
            scope: "スコープを入力してください（任意）:",
            customScope: "スコープを入力してください:",
            subject: "コミット内容を短く現在形で入力してください:\n",
            body: '詳細説明を入力してください（任意）。改行は "|" を使ってください:\n',
            breaking:
                '破壊的変更があれば入力してください（任意）。改行は "|" を使ってください:\n',
            footerPrefixesSelect:
                "Issue の種別を選んでください（任意）:",
            customFooterPrefix: "Issue プレフィックスを入力してください:",
            footer: "関連する Issue を入力してください。例: #31, #34\n",
            generatingByAI: "AIでコミットメッセージを生成中...",
            generatedSelectByAI: "AIが生成した候補から選んでください:",
            confirmCommit: "この内容でコミットしますか？",
        },
        types: [
            { value: "feat", name: "feat:     ✨  新機能の追加", emoji: "✨" },
            { value: "fix", name: "fix:      🐛  バグ修正", emoji: "🐛" },
            { value: "docs", name: "docs:     📝  ドキュメントのみの変更", emoji: "📝" },
            { value: "style", name: "style:    💄  挙動に影響しない見た目や整形の変更", emoji: "💄" },
            { value: "refactor", name: "refactor: ♻️   機能追加やバグ修正を伴わないリファクタリング", emoji: "♻️" },
            { value: "perf", name: "perf:     ⚡️  パフォーマンス改善", emoji: "⚡️" },
            { value: "test", name: "test:     ✅  テストの追加・修正", emoji: "✅" },
            { value: "build", name: "build:    📦️   ビルドや依存関係に関する変更", emoji: "📦️" },
            { value: "ci", name: "ci:       🎡  CI設定やスクリプトの変更", emoji: "🎡" },
            { value: "chore", name: "chore:    🔨  その他の雑多な変更", emoji: "🔨" },
            { value: "revert", name: "revert:   ⏪️  以前のコミットの取り消し", emoji: "⏪️" },
        ],
        useEmoji: true,
        emojiAlign: "center",

        useAI: true,
        aiNumber: 5,
        aiDiffIgnore: ["package-lock.json"],
        aiQuestionCB: ({ maxSubjectLength, diff }) =>
            `以下のGit diffコードに対して、接頭辞を付けずに、洞察に富み簡潔なGitコミットメッセージを現在形で記述してください。なお、この文の長さは${maxSubjectLength}文字を超えてはなりません！！ : \n\`\`\`diff\n${diff}\n\`\`\``,

        themeColorCode: "",
        scopes: [],
        allowCustomScopes: true,
        allowEmptyScopes: true,
        customScopesAlign: "bottom",
        customScopesAlias: "custom",
        emptyScopesAlias: "empty",
        upperCaseSubject: false,
        markBreakingChangeMode: false,
        allowBreakingChanges: ["feat", "fix"],
        breaklineNumber: 100,
        breaklineChar: "|",
        skipQuestions: [],
        issuePrefixes: [
            { value: "closed", name: "closed:   Issue対応済み" },
        ],
        customIssuePrefixAlign: "top",
        emptyIssuePrefixAlias: "skip",
        customIssuePrefixAlias: "custom",
        allowCustomIssuePrefix: true,
        allowEmptyIssuePrefix: true,
        confirmColorize: true,
        scopeOverrides: undefined,
        defaultBody: "",
        defaultIssues: "",
        defaultScope: "",
        defaultSubject: "",
    },
};
