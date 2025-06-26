return {
  settings = {
    python = {
      analysis = {
        diagnosticSeverityOverride = {
          -- this just ends up being annoying due to pendulum
          reportPrivateImportUsage = false,
        },
      },
    },
  },
}
