local telescope = require('telescope')
local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local conf = require('telescope.config').values
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

local M = {
  index_path = nil,
}

-- Setup function to configure index path
function M.setup(opts)
  opts = opts or {}
  M.index_path = opts.index_path or '~/.csearchindex'
end

-- This function creates a telescope picker that prompts for a search query,
-- then runs csearch to find matches.
function M.csearch(opts)
  opts = opts or {}
  local prompt_title = opts.prompt_title or "Csearch"

  pickers.new(opts, {
    prompt_title = prompt_title,
    finder = finders.new_job(function(prompt)
      if not prompt or prompt == "" then
        return nil
      end

      -- Set the CSEARCHINDEX environment variable if provided
      local env = {}
      if M.index_path then
        env = { CSEARCHINDEX = vim.fn.expand(M.index_path) }
      end

      -- csearch command arguments:
      -- "-n" prints only the filenames and matching lines.
      -- prompt is the query typed by the user.
      return { "csearch", "-n", prompt }, env
    end, opts.entry_maker or function(line)
      -- Each line returned by csearch typically looks like:
      -- filename:linenum:match text
      -- We'll parse it into a structured entry.
      local filename, lnum, text = line:match("^([^:]+):(%d+):(.*)$")
      return {
        value = line,
        display = line,
        ordinal = line,
        filename = filename or line,
        lnum = tonumber(lnum) or 1,
        text = text or "",
      }
    end),
    sorter = conf.generic_sorter(opts),
    previewer = conf.grep_previewer(opts),  -- File previews
    attach_mappings = function(prompt_bufnr, map)
      -- Open file on <CR> and jump to matched line
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local entry = action_state.get_selected_entry()
        if entry and entry.filename then
          vim.cmd("edit " .. entry.filename)
          vim.fn.cursor(entry.lnum, 0)
        end
      end)
      return true
    end,
  }):find()
end

return M

