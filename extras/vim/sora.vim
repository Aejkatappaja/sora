" Sora colorscheme for Vim
" https://github.com/aejkatappaja/sora.nvim

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "sora"

if !has('gui_running') && &t_Co < 256
  finish
endif

" Editor
hi Normal        guifg=#c8d0e0 guibg=#0e1018
hi NormalFloat   guifg=#c8d0e0 guibg=#0a0c12
hi Cursor        guifg=#0e1018 guibg=#c8d0e0
hi CursorLine    guibg=#171a24 cterm=NONE
hi CursorLineNr  guifg=#80c8e0 gui=bold
hi LineNr        guifg=#364050
hi SignColumn    guifg=#364050 guibg=NONE
hi VertSplit     guifg=#364050 guibg=NONE
hi StatusLine    guifg=#c8d0e0 guibg=#0a0c12
hi StatusLineNC  guifg=#364050 guibg=#0a0c12
hi TabLine       guifg=#9aa4b8 guibg=#0a0c12
hi TabLineFill   guibg=#0a0c12
hi TabLineSel    guifg=#dce4f0 guibg=#0e1018 gui=bold
hi Pmenu         guifg=#c8d0e0 guibg=#0a0c12
hi PmenuSel      guifg=#dce4f0 guibg=#1e2430
hi PmenuSbar     guibg=#14161e
hi PmenuThumb    guibg=#364050
hi Visual        guibg=#1e2430
hi Search        guifg=#dce4f0 guibg=#1a3050
hi IncSearch     guifg=#0e1018 guibg=#80c8e0
hi MatchParen    guifg=#d4b878 gui=bold
hi NonText       guifg=#364050
hi SpecialKey    guifg=#364050
hi Folded        guifg=#586478 guibg=#14161e
hi ColorColumn   guibg=#171a24
hi Directory     guifg=#80c8e0
hi Title         guifg=#80c8e0 gui=bold
hi ErrorMsg      guifg=#c46c78
hi WarningMsg    guifg=#c8a860
hi MoreMsg       guifg=#80c8e0
hi Question      guifg=#80c8e0
hi ModeMsg       guifg=#dce4f0 gui=bold
hi Conceal       guifg=#9aa4b8
hi EndOfBuffer   guifg=#364050
hi WildMenu      guifg=#dce4f0 guibg=#1e2430
hi SpellBad      guisp=#c46c78 gui=undercurl
hi SpellCap      guisp=#c8a860 gui=undercurl

" Syntax
hi Comment       guifg=#586478 gui=italic
hi String        guifg=#90c8a0
hi Character     guifg=#90c8a0
hi Number        guifg=#d4b878
hi Float         guifg=#d4b878
hi Boolean       guifg=#d0909c gui=italic
hi Identifier    guifg=#b4bcd0
hi Function      guifg=#80c8e0
hi Statement     guifg=#b0a0d8
hi Conditional   guifg=#b0a0d8 gui=italic
hi Repeat        guifg=#b0a0d8 gui=italic
hi Label         guifg=#78b8b0
hi Operator      guifg=#8898b8
hi Keyword       guifg=#b0a0d8 gui=italic
hi Exception     guifg=#d0909c
hi PreProc       guifg=#b0a0d8
hi Include       guifg=#b0a0d8 gui=italic
hi Define        guifg=#b0a0d8
hi Macro         guifg=#78b8b0 gui=bold
hi Type          guifg=#d0a888
hi StorageClass  guifg=#b0a0d8 gui=italic
hi Structure     guifg=#d0a888 gui=bold
hi Typedef       guifg=#d0a888
hi Constant      guifg=#d4b878
hi Special       guifg=#78b8b0
hi SpecialChar   guifg=#78b8b0
hi Tag           guifg=#78b8b0
hi Delimiter     guifg=#9aa4b8
hi Debug         guifg=#d0909c
hi Underlined    guifg=#80c8e0 gui=underline
hi Error         guifg=#c46c78
hi Todo          guifg=#0e1018 guibg=#d4b878 gui=bold

" Diff
hi DiffAdd       guibg=#0e1c16
hi DiffChange    guibg=#101828
hi DiffDelete    guibg=#1c1014
hi DiffText      guibg=#1e2430
hi Added         guifg=#68b080
hi Changed       guifg=#6898b8
hi Removed       guifg=#b86068

" Diagnostics
hi DiagnosticError          guifg=#c46c78
hi DiagnosticWarn           guifg=#c8a860
hi DiagnosticInfo           guifg=#5ca8c8
hi DiagnosticHint           guifg=#78b0a0
hi DiagnosticUnderlineError guisp=#c46c78 gui=undercurl
hi DiagnosticUnderlineWarn  guisp=#c8a860 gui=undercurl
hi DiagnosticUnderlineInfo  guisp=#5ca8c8 gui=undercurl
hi DiagnosticUnderlineHint  guisp=#78b0a0 gui=undercurl

" Terminal colors
if has('nvim')
  let g:terminal_color_0  = '#0e1018'
  let g:terminal_color_1  = '#c46c78'
  let g:terminal_color_2  = '#90c8a0'
  let g:terminal_color_3  = '#d4b878'
  let g:terminal_color_4  = '#80c8e0'
  let g:terminal_color_5  = '#b0a0d8'
  let g:terminal_color_6  = '#78b8b0'
  let g:terminal_color_7  = '#c8d0e0'
  let g:terminal_color_8  = '#586478'
  let g:terminal_color_9  = '#d88898'
  let g:terminal_color_10 = '#a8d8b4'
  let g:terminal_color_11 = '#e0c888'
  let g:terminal_color_12 = '#98d8f0'
  let g:terminal_color_13 = '#c4b4e8'
  let g:terminal_color_14 = '#90d0c8'
  let g:terminal_color_15 = '#dce4f0'
endif
