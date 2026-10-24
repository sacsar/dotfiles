return {
  settings = {
    python = {
      analysis = {
        exclude = {
          "**/.worktrees",
          "**/.workspaces",
        },
        diagnosticSeverityOverride = {
          -- this just ends up being annoying due to pendulum
          reportPrivateImportUsage = false,
        },
      },
    },
  },
}
