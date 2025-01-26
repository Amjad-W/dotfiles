local overseer = require "overseer"
overseer.setup {
  strategy = {
    "toggleterm",
    direction = "vertical",
    size = 100,
    auto_scroll = true,
  },
}

-- Templates
overseer.register_template {
  name = "go run",
  builder = function()
    return {
      cmd = { "go", "run" },
      args = { "." },
      cwd = ".",
      components = {
        "unique",
        "default",
      },
    }
  end,
  condition = {
    filetype = { "go" },
  },
}
