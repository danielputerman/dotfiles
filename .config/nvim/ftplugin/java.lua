local jdtls = require('jdtls')

local root_dir = vim.fs.root(0, { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' })
local project_name = root_dir and vim.fs.basename(root_dir) or 'default'
local workspace_dir = vim.fn.stdpath('cache') .. '/jdtls/' .. project_name

jdtls.start_or_attach({
  cmd = { vim.fn.exepath('jdtls') },
  root_dir = root_dir,
  settings = {
    java = {
      eclipse = { downloadSources = true },
      maven = { downloadSources = true },
      contentProvider = { preferred = 'fernflower' },
    },
  },
  init_options = {
    workspace = workspace_dir,
  },
})
