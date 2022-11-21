local present, telescope = pcall(require, "telescope")

if not present then
  return
end
-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
require('telescope').setup {
  defaults = {
    -- ...
  },
  pickers = {
    find_files = {
      theme = "ivy",
    },
    git_files = {
      theme = "ivy",
    },
    buffers = {
      theme = "ivy",
    },
    live_grep = {
      theme = "ivy",
    },
  },
  extensions = {
    frecency = {
--        db_root = "~/nvim-db/kj",
      show_scores = false,
      show_unindexed = true,
      ignore_patterns = {"*.git/*", "*/tmp/*"},
      disable_devicons = false,
      workspaces = {
        ["dev"]       = "~/repos",
        ["silver"]    = "~/repos/software_dev/silver",
      }
    },
    project = {
      base_dirs = {
        '~/repos',
      },
      hidden_files = true, -- default: false
      theme = "dropdown",
      order_by = "asc",
      sync_with_nvim_tree = false, -- default false
    },
    ["zf-native"] = {
        -- options for sorting file-like items
        file = {
            -- override default telescope file sorter
            enable = true,

            -- highlight matching text in results
            highlight_results = true,

            -- enable zf filename match priority
            match_filename = true,
        },

        -- options for sorting all other items
        generic = {
            -- override default telescope generic item sorter
            enable = true,

            -- highlight matching text in results
            highlight_results = true,

            -- disable zf filename match priority
            match_filename = false,
        },
    },
    file_browser = {
        theme = "ivy",
        mappings = {
            ["i"] = {
                -- your custom insert mode mappings
            },
            ["n"] = {
                -- your custom normal mode mappings
            },
        },
    },
  },
}

-- TODO: make this work on linux as well
vim.g.sqlite_clib_path = 'C:\\Users\\adrianc\\scoop\\apps\\sqlite\\dll\\sqlite3.dll'

require("telescope").load_extension("zf-native")
require('telescope').load_extension('project')
require('telescope').load_extension('frecency')
require("telescope").load_extension('file_browser')
