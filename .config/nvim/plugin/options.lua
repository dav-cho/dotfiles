local options = {
  --errorbells = false,
  belloff = 'all',
  fileencoding = 'UTF-8',
  --hidden = true,
  swapfile = false,
  --timeoutlen = 100, -- default: 1000
  incsearch = true,
  ignorecase = true,
  smartcase = true,
  --inccommand = 'nosplit',

  --showmode = false,
  termguicolors = true,
  cmdheight = 2,
  mouse = 'a',
  relativenumber = true,
  number = true,
  cursorline = true,
  signcolumn = 'yes',
  --colorcolumn = '80',
  scrolloff = 10,
  sidescrolloff = 10,
  --completeopt = { 'menuone', 'noselect' },
  completeopt = { 'menu', 'menuone', 'noselect' },
  --completeopt = { 'menuone', 'noselect', 'noinsert' },
  pumheight = 10,
  pumblend = 17,

  autoindent = true,
  smartindent = true,
  breakindent = true,
  wrap = false,

  tabstop = 2,
  softtabstop = 2,
  shiftwidth = 2,
  expandtab = true,

  splitbelow = true,
  splitright = true,

  formatoptions = (vim.opt.formatoptions
    - 'a' -- Automatic formatting of paragraphs. Every time text is inserted or deleted the paragraph will be reformatted. See |auto-format|. When the 'c' flag is present this only happens for recognized comments.
    - 't' -- Auto-wrap text using textwidth.
    + 'c' -- Auto-wrap comments using textwidth, inserting the current comment leader automatically.
    + 'q' -- Allow formatting of comments with "gq".Note that formatting will not change blank lines or lines containing only the comment leader. A new paragraph starts after such a line, or when the comment leader changes.
    + 'n' -- When formatting text, recognize numbered lists. This actually uses the 'formatlistpat' option, thus any kind of list can be used. The indent of the text after the number is used for the next line. The default is to find a number, optionally followed by '.', ':', ')', ']' or '}'.  Note that 'autoindent' must be set too.  Doesn't work well together with "2".
    + 'j' -- Where it makes sense, remove a comment leader when joining lines.
    + 'r' -- Automatically insert the current comment leader after hitting <Enter> in Insert mode.
    - 'o' -- Automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode.
    - '2' -- When formatting text, use the indent of the second line of a paragraph for the rest of the paragraph, instead of the indent of the first line.  This supports paragraphs in which the first line has a different indent than the rest.  Note that 'autoindent' must be set too. This also works inside comments, ignoring the comment leader.
  ),
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

