return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    ---@type table<string, {updated:number, total:number, enabled: boolean, status:string[]}>
    local mutagen = {}

    local function mutagen_status()
      local cwd = vim.uv.cwd() or "."
      mutagen[cwd] = mutagen[cwd]
        or {
          updated = 0,
          total = 0,
          enabled = vim.fs.find("mutagen.yml", { path = cwd, upward = true })[1] ~= nil,
          status = {},
        }
      local now = vim.uv.now() -- timestamp in milliseconds
      local refresh = mutagen[cwd].updated + 10000 < now
      if #mutagen[cwd].status > 0 then
        refresh = mutagen[cwd].updated + 1000 < now
      end
      if mutagen[cwd].enabled and refresh then
        ---@type {name:string, status:string, idle:boolean}[]
        local sessions = {}
        local lines = vim.fn.systemlist("mutagen project list")
        local status = {}
        local name = nil
        for _, line in ipairs(lines) do
          local n = line:match("^Name: (.*)")
          if n then
            name = n
          end
          local s = line:match("^Status: (.*)")
          if s then
            table.insert(sessions, {
              name = name,
              status = s,
              idle = s == "Watching for changes",
            })
          end
        end
        for _, session in ipairs(sessions) do
          if not session.idle then
            table.insert(status, session.name .. ": " .. session.status)
          end
        end
        mutagen[cwd].updated = now
        mutagen[cwd].total = #sessions
        mutagen[cwd].status = status
        if #sessions == 0 then
          vim.notify("Mutagen is not running", vim.log.levels.ERROR, { title = "Mutagen" })
        end
      end
      return mutagen[cwd]
    end

    local error_color = LazyVim.ui.fg("DiagnosticError")
    local ok_color = LazyVim.ui.fg("DiagnosticInfo")
    table.insert(opts.sections.lualine_x, {
      cond = function()
        return mutagen_status().enabled
      end,
      color = function()
        return (mutagen_status().total == 0 or mutagen_status().status[1]) and error_color or ok_color
      end,
      function()
        local s = mutagen_status()
        local msg = s.total
        if #s.status > 0 then
          msg = msg .. " | " .. table.concat(s.status, " | ")
        end
        return (s.total == 0 and "󰋘 " or "󰋙 ") .. msg
      end,
    })
  end,
}
