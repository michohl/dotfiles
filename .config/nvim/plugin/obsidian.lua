-- conceallevel indicates what patterns and characters should be hidden.
-- In the markdown files for Obsidian this handles making things look "pretty"
-- but in other files like JSON this can be intrusive
--[[
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt.conceallevel = 1
  end,
})
]]

require("obsidian").setup({
  workspaces = {
    {
      name = "Second Brain",
      path = "~/obsidian/second-brain",
    },
    --{
    --  name = "work",
    --  path = "~/vaults/work",
    --},
  },

  notes_subdir = "inbox",
  new_notes_location = "notes_subdir",

  disable_frontmatter = true,

  -- name new notes starting the ISO datetime and ending with note name
  -- put them in the inbox subdir
  note_id_func = function(title)
    local suffix = ""
    -- get current ISO datetime with -5 hour offset from UTC for EST
    local current_datetime = os.date("!%Y-%m-%d", os.time() - 5*3600)
    if title ~= nil then
      suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
    else
      for _ = 1, 4 do
        suffix = suffix .. string.char(math.random(65, 90))
      end
    end
    return current_datetime .. "_" .. suffix
  end,

  templates = {
      subdir = "assets/templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M:%S",
  },

  mappings = {
    -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
    ["gf"] = {
      action = function()
        return require("obsidian").util.gf_passthrough()
      end,
      opts = { noremap = false, expr = true, buffer = true },
    },
    -- Toggle check-boxes.
    ["<leader>ch"] = {
      action = function()
        return require("obsidian").util.toggle_checkbox()
      end,
      opts = { buffer = true },
    },
    -- Smart action depending on context, either follow link or toggle checkbox.
    ["<cr>"] = {
      action = function()
        return require("obsidian").util.smart_action()
      end,
      opts = { buffer = true, expr = true },
    }
  },

  -- Removing this line allows Obsidian to make the file look "pretty". This requires conceallevel to be set to 1 or 2 at the
  -- top of this file. I'm disabling this for now because I don't like the UI elements moving around just because I'm moving my cursor
  -- causing concealed objects to pop in and out of reality.
  ui = {enable = false},

  -- Specify how to handle attachments.
  attachments = {
    -- The default folder to place images in via `:ObsidianPasteImg`.
    -- If this is a relative path it will be interpreted as relative to the vault root.
    -- You can always override this per image by passing a full path to the command instead of just a filename.
    img_folder = "assets/imgs",  -- This is the default
    -- A function that determines the text to insert in the note when pasting an image.
    -- It takes two arguments, the `obsidian.Client` and an `obsidian.Path` to the image file.
    -- This is the default implementation.
    ---@param client obsidian.Client
    ---@param path obsidian.Path the absolute path to the image file
    ---@return string
    img_text_func = function(client, path)
      path = client:vault_relative_path(path) or path
      return string.format("![%s](%s)", path.name, path)
    end,
  },
})

-- Custom Functions

--[[
vim.api.nvim_create_user_command("ObsidianFormatTitle", function()
  -- Switch to the line we care about
  --vim.cmd("/\\(# \\)[^_]*_")
  vim.cmd("/# ")
  -- Update the line
  vim.cmd("s,\\(# \\)[^_]*_,\1, | s,-, ,g")
  -- Remove our search highlight
  vim.cmd("let @/ = ''")
end, {})
]]

vim.api.nvim_create_user_command("ObsidianNewFromTemplate", function()

    -- setup
    local obsidian = require("obsidian").get_client()
    obsidian.opts.disable_frontmatter = true

    -- Create new file
    vim.cmd("ObsidianNew")

    -- Delete lines before frontmatter
    vim.api.nvim_buf_set_lines(0, 0, 1, false, {})

    -- go to end of file
    --vim.cmd("normal! G")

    -- Insert our selected template
    vim.cmd("ObsidianTemplate")

    -- Make the title more human readable
    --vim.cmd("ObsidianFormatTitle")

end, {})


-- Mappings

-- Create a new note
vim.keymap.set('n', '<leader>on', ':ObsidianNewFromTemplate<cr>')

-- Pick a template to inject at your cursor
--vim.keymap.set('n', '<leader>ot', ':ObsidianTemplate<cr>')

-- Format the title of a document. Ideally this would be done when we create the document
-- but that doesn't seem to be possible at this time.
vim.keymap.set('n', '<leader>ot', ":/# <cr>:s/\\(# \\)[^_]*_/\\1/ | s/-/ /g<cr>:let @/ = ''<cr>")

-- Find all pages that link to the current page you're looking at
vim.keymap.set('n', '<leader>or', ':ObsidianBacklinks<cr>')


-- Paste images from your clipboard
--     NOTE: This requires `pngpaste` to be installed if on MacOS
vim.keymap.set('n', '<leader>oi', ':ObsidianPasteImg<cr>')


-- Fuzzy searching that is limited to Obsidian notes
vim.keymap.set('n', '<leader>of', ':Telescope find_files search_dirs={"~/obsidian/second-brain"}<cr>')
vim.keymap.set('n', '<leader>og', ':Telescope live_grep search_dirs={"~/obsidian/second-brain"}<cr>')


-- Document review shortcuts

-- If you want to move a document to be kept
vim.keymap.set('n', '<leader>ok', ":!mv '%:p' ~/obsidian/second-brain/zettelkasten<cr>:bd<cr>")

-- If you want to throw away a document
vim.keymap.set('n', '<leader>odd', ":!rm '%:p'<cr>:bd<cr>")
