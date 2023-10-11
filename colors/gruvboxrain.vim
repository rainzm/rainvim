" -----------------------------------------------------------------------------
" File: gruvbox.vim
" Description: Retro groove color scheme for Vim
" Author: morhetz <morhetz@gmail.com>
" Source: https://github.com/morhetz/gruvbox
" Last Modified: 12 Aug 2017
" -----------------------------------------------------------------------------

" Supporting code -------------------------------------------------------------
" Initialisation: {{{
let g:colors_name='gruvbox'

if !(has('termguicolors') && &termguicolors) && !has('gui_running') && &t_Co != 256
  finish
endif

" }}}
" Global Settings: {{{

let g:gruvbox_italic = 1
if !exists('g:gruvbox_bold')
  let g:gruvbox_bold=1
endif
if !exists('g:gruvbox_italic')
  if has('gui_running') || $TERM_ITALICS == 'true'
    let g:gruvbox_italic=1
  else
    let g:gruvbox_italic=0
  endif
endif
if !exists('g:gruvbox_undercurl')
  let g:gruvbox_undercurl=1
endif
if !exists('g:gruvbox_underline')
  let g:gruvbox_underline=1
endif
if !exists('g:gruvbox_inverse')
  let g:gruvbox_inverse=1
endif

if !exists('g:gruvbox_guisp_fallback') || index(['fg', 'bg'], g:gruvbox_guisp_fallback) == -1
  let g:gruvbox_guisp_fallback='NONE'
endif

if !exists('g:gruvbox_improved_strings')
  let g:gruvbox_improved_strings=0
endif

if !exists('g:gruvbox_improved_warnings')
  let g:gruvbox_improved_warnings=0
endif

if !exists('g:gruvbox_termcolors')
  let g:gruvbox_termcolors=256
endif

if !exists('g:gruvbox_invert_indent_guides')
  let g:gruvbox_invert_indent_guides=0
endif

if exists('g:gruvbox_contrast')
  echo 'g:gruvbox_contrast is deprecated; use g:gruvbox_contrast_light and g:gruvbox_contrast_dark instead'
endif

if !exists('g:gruvbox_contrast_dark')
  let g:gruvbox_contrast_dark='medium'
endif

if !exists('g:gruvbox_contrast_light')
  let g:gruvbox_contrast_light='medium'
endif

let s:is_dark=(&background == 'dark')

" }}}
" Palette: {{{

let palette1 = {
            \ 'bg_dim':           ['#1b1b1b',   '233'],
            \ 'bg0':              ['#282828',   '235'],
            \ 'bg1':              ['#32302f',   '236'],
            \ 'bg2':              ['#32302f',   '236'],
            \ 'bg3':              ['#45403d',   '237'],
            \ 'bg4':              ['#45403d',   '237'],
            \ 'bg5':              ['#5a524c',   '239'],
            \ 'bg_statusline1':   ['#32302f',   '236'],
            \ 'bg_statusline2':   ['#3a3735',   '236'],
            \ 'bg_statusline3':   ['#504945',   '240'],
            \ 'bg_diff_green':    ['#34381b',   '22'],
            \ 'bg_visual_green':  ['#3b4439',   '22'],
            \ 'bg_diff_red':      ['#402120',   '52'],
            \ 'bg_visual_red':    ['#4c3432',   '52'],
            \ 'bg_diff_blue':     ['#0e363e',   '17'],
            \ 'bg_visual_blue':   ['#374141',   '17'],
            \ 'bg_visual_yellow': ['#4f422e',   '94'],
            \ 'bg_current_word':  ['#3c3836',   '237']
            \ }

let palette2 = {
            \ 'fg0':              ['#e2cca9',   '223'],
            \ 'fg1':              ['#e2cca9',   '223'],
            \ 'red':              ['#f2594b',   '167'],
            \ 'orange':           ['#f28534',   '208'],
            \ 'yellow':           ['#e9b143',   '214'],
            \ 'green':            ['#b0b846',   '142'],
            \ 'aqua':             ['#8bba7f',   '108'],
            \ 'blue':             ['#80aa9e',   '109'],
            \ 'purple':           ['#d3869b',   '175'],
            \ 'bg_red':           ['#db4740',   '167'],
            \ 'bg_green':         ['#b0b846',   '142'],
            \ 'bg_yellow':        ['#e9b143',   '214']
            \ }
let palette3 = {
          \ 'grey0':            ['#7c6f64',   '243'],
          \ 'grey1':            ['#928374',   '245'],
          \ 'grey2':            ['#a89984',   '246'],
          \ 'none':             ['NONE',      'NONE']
          \ }
" setup palette dictionary
let s:gb = {}

" fill it with absolute colors
let s:gb.dark0_hard  = ['#1d2021', 234]     " 29-32-33
let s:gb.dark0       = ['#282828', 235]     " 40-40-40
let s:gb.dark0_soft  = ['#32302f', 236]     " 50-48-47
let s:gb.darkline = ['#665c54', 241]
let s:gb.dark01 = ['#333130', 237]
let s:gb.dark1       = ['#3c3836', 237]     " 60-56-54
let s:gb.dark2       = ['#504945', 239]     " 80-73-69
let s:gb.dark3       = ['#665c54', 241]     " 102-92-84
let s:gb.dark4       = ['#7c6f64', 243]     " 124-111-100
let s:gb.dark4_256   = ['#7c6f64', 243]     " 124-111-100

let s:gb.gray_245    = ['#928374', 245]     " 146-131-116
let s:gb.gray_244    = ['#928374', 244]     " 146-131-116

let s:gb.light0_hard = ['#f9f5d7', 230]     " 249-245-215
let s:gb.light0      = ['#fbf1c7', 229]     " 253-244-193
let s:gb.light0_soft = ['#f2e5bc', 228]     " 242-229-188
let s:gb.light1      = ['#ebdbb2', 223]     " 235-219-178
let s:gb.light2      = ['#d5c4a1', 250]     " 213-196-161
let s:gb.light3      = ['#bdae93', 248]     " 189-174-147
let s:gb.light4      = ['#a89984', 246]     " 168-153-132
let s:gb.light4_256  = ['#a89984', 246]     " 168-153-132

" let s:gb.bright_red     = ['#fb4934', 167]     " 251-73-52
" let s:gb.bright_green   = ['#b8bb26', 142]     " 184-187-38
" let s:gb.bright_yellow  = ['#fabd2f', 214]     " 250-189-47
" let s:gb.bright_blue    = ['#83a598', 109]     " 131-165-152
" let s:gb.bright_purple  = ['#d3869b', 175]     " 211-134-155
" let s:gb.bright_aqua    = ['#8ec07c', 108]     " 142-192-124
" let s:gb.bright_orange  = ['#fe8019', 208]     " 254-128-25

let s:gb.bright_red =              ['#f2594b',   '167']
let s:gb.bright_orange =           ['#f28534',   '208']
" let s:gb.bright_yellow =           ['#e9b143',   '214']
let s:gb.bright_yellow =           ['#e4b048',   '214']
" let s:gb.bright_yellow =           ['#e4ac3e',   '214']
let s:gb.bright_green =            ['#b0b846',   '142']
let s:gb.bright_aqua  =            ['#8bba7f',   '108']
let s:gb.bright_blue   =          ['#81a89b',   '109']
" let s:gb.bright_blue    = ['#83a598', '109']     " 131-165-152
let s:gb.bright_purple =          ['#d3869b',   '175']

let s:gb.neutral_red    = ['#cc241d', 124]     " 204-36-29
let s:gb.neutral_green  = ['#98971a', 106]     " 152-151-26
let s:gb.neutral_yellow = ['#d79921', 172]     " 215-153-33
let s:gb.neutral_blue   = ['#458588', 66]      " 69-133-136
let s:gb.neutral_purple = ['#b16286', 132]     " 177-98-134
let s:gb.neutral_aqua   = ['#689d6a', 72]      " 104-157-106
let s:gb.neutral_orange = ['#d65d0e', 166]     " 214-93-14

let s:gb.faded_red      = ['#9d0006', 88]      " 157-0-6
let s:gb.faded_green    = ['#79740e', 100]     " 121-116-14
let s:gb.faded_yellow   = ['#b57614', 136]     " 181-118-20
let s:gb.faded_blue     = ['#076678', 24]      " 7-102-120
let s:gb.faded_purple   = ['#8f3f71', 96]      " 143-63-113
let s:gb.faded_aqua     = ['#427b58', 66]      " 66-123-88
let s:gb.faded_orange   = ['#af3a03', 130]     " 175-58-3

" }}}
" Setup Emphasis: {{{

let s:bold = 'bold,'
if g:gruvbox_bold == 0
  let s:bold = ''
endif

let s:italic = 'italic,'
if g:gruvbox_italic == 0
  let s:italic = ''
endif

let s:underline = 'underline,'
if g:gruvbox_underline == 0
  let s:underline = ''
endif

let s:undercurl = 'undercurl,'
if g:gruvbox_undercurl == 0
  let s:undercurl = ''
endif

let s:inverse = 'inverse,'
" let s:inverse = ''
if g:gruvbox_inverse == 0
  let s:inverse = ''
endif

" }}}
" Setup Colors: {{{

let s:vim_bg = ['bg', 'bg']
let s:vim_fg = ['fg', 'fg']
let s:none = ['NONE', 'NONE']

" determine relative colors
if s:is_dark
  let s:bg0  = s:gb.dark0
  if g:gruvbox_contrast_dark == 'soft'
    let s:bg0  = s:gb.dark0_soft
  elseif g:gruvbox_contrast_dark == 'hard'
    let s:bg0  = s:gb.dark0_hard
  endif

  let s:bg1  = s:gb.dark1
  let s:bg2  = s:gb.dark2
  let s:bg3  = s:gb.dark3
  let s:bg4  = s:gb.dark4

  " let s:bg0 =  ['#282828',   '235']
  " let s:bg1 =              ['#32302f',   '236']
  "           let s:bg2 =              ['#32302f',   '236']
  "           let s:bg3 =              ['#45403d',   '237']
  "           let s:bg4 =              ['#45403d',   '237']
  "           let s:bg5 =              ['#5a524c',   '239']
  " let s:bg0 =             ['#1d2021',   '234']
  " let s:bg1  =             ['#282828',   '235']
  " let s:bg2  =             ['#282828',   '235']
  " let s:bg3  =             ['#3c3836',   '237']
  " let s:bg4 =             ['#3c3836',   '237']
  " let s:bg5 =             ['#504945',   '239']

  let s:gray = s:gb.gray_245

  let s:fg0 = s:gb.light0
  let s:fg1 = s:gb.light1
  let s:fg2 = s:gb.light2
  let s:fg3 = s:gb.light3
  let s:fg4 = s:gb.light4

  let s:fg0  =             ['#e2cca9',   '223']
  let s:fg1  =             ['#e2cca9',   '223']
  
  let s:fg4_256 = s:gb.light4_256

  let s:red    = s:gb.bright_red
  let s:green  = s:gb.bright_green
  let s:yellow = s:gb.bright_yellow
  let s:blue   = s:gb.bright_blue
  let s:purple = s:gb.bright_purple
  let s:aqua   = s:gb.bright_aqua
  let s:orange = s:gb.bright_orange
else
  let s:bg0  = s:gb.light0
  if g:gruvbox_contrast_light == 'soft'
    let s:bg0  = s:gb.light0_soft
  elseif g:gruvbox_contrast_light == 'hard'
    let s:bg0  = s:gb.light0_hard
  endif

  let s:bg1  = s:gb.light1
  let s:bg2  = s:gb.light2
  let s:bg3  = s:gb.light3
  let s:bg4  = s:gb.light4

  let s:gray = s:gb.gray_244

  let s:fg0 = s:gb.dark0
  let s:fg1 = s:gb.dark1
  let s:fg2 = s:gb.dark2
  let s:fg3 = s:gb.dark3
  let s:fg4 = s:gb.dark4

  let s:fg4_256 = s:gb.dark4_256

  let s:red    = s:gb.faded_red
  let s:green  = s:gb.faded_green
  let s:yellow = s:gb.faded_yellow
  let s:blue   = s:gb.faded_blue
  let s:purple = s:gb.faded_purple
  let s:aqua   = s:gb.faded_aqua
  let s:orange = s:gb.faded_orange
endif

" reset to 16 colors fallback
if g:gruvbox_termcolors == 16
  let s:bg0[1]    = 0
  let s:fg4[1]    = 7
  let s:gray[1]   = 8
  let s:red[1]    = 9
  let s:green[1]  = 10
  let s:yellow[1] = 11
  let s:blue[1]   = 12
  let s:purple[1] = 13
  let s:aqua[1]   = 14
  let s:fg1[1]    = 15
endif

" save current relative colors back to palette dictionary
let s:gb.bg0 = s:bg0
let s:gb.bg1 = s:bg1
let s:gb.bg2 = s:bg2
let s:gb.bg3 = s:bg3
let s:gb.bg4 = s:bg4

let s:gb.gray = s:gray

let s:gb.fg0 = s:fg0
let s:gb.fg1 = s:fg1
let s:gb.fg2 = s:fg2
let s:gb.fg3 = s:fg3
let s:gb.fg4 = s:fg4

let s:gb.fg4_256 = s:fg4_256

let s:gb.red    = s:red
let s:gb.green  = s:green
let s:gb.yellow = s:yellow
let s:gb.blue   = s:blue
let s:gb.purple = s:purple
let s:gb.aqua   = s:aqua
let s:gb.orange = s:orange

" }}}
" Setup Terminal Colors For Neovim: {{{

if has('nvim')
  let g:terminal_color_0 = s:bg0[0]
  let g:terminal_color_8 = s:gray[0]

  let g:terminal_color_1 = s:gb.neutral_red[0]
  let g:terminal_color_9 = s:red[0]

  let g:terminal_color_2 = s:gb.neutral_green[0]
  let g:terminal_color_10 = s:green[0]

  let g:terminal_color_3 = s:gb.neutral_yellow[0]
  let g:terminal_color_11 = s:yellow[0]

  let g:terminal_color_4 = s:gb.neutral_blue[0]
  let g:terminal_color_12 = s:blue[0]

  let g:terminal_color_5 = s:gb.neutral_purple[0]
  let g:terminal_color_13 = s:purple[0]

  let g:terminal_color_6 = s:gb.neutral_aqua[0]
  let g:terminal_color_14 = s:aqua[0]

  let g:terminal_color_7 = s:fg4[0]
  let g:terminal_color_15 = s:fg1[0]
endif

" }}}
" Overload Setting: {{{

let s:hls_cursor = s:orange
if exists('g:gruvbox_hls_cursor')
  let s:hls_cursor = get(s:gb, g:gruvbox_hls_cursor)
endif

let s:number_column = s:none
if exists('g:gruvbox_number_column')
  let s:number_column = get(s:gb, g:gruvbox_number_column)
endif

let s:sign_column = s:bg1

if exists('g:gitgutter_override_sign_column_highlight') &&
      \ g:gitgutter_override_sign_column_highlight == 1
  let s:sign_column = s:number_column
else
  let g:gitgutter_override_sign_column_highlight = 0

  if exists('g:gruvbox_sign_column')
    let s:sign_column = get(s:gb, g:gruvbox_sign_column)
  endif
endif

let s:color_column = s:bg1
if exists('g:gruvbox_color_column')
  let s:color_column = get(s:gb, g:gruvbox_color_column)
endif

let s:vert_split = s:bg0
if exists('g:gruvbox_vert_split')
  let s:vert_split = get(s:gb, g:gruvbox_vert_split)
endif

let s:invert_signs = ''
if exists('g:gruvbox_invert_signs')
  if g:gruvbox_invert_signs == 1
    let s:invert_signs = s:inverse
  endif
endif

" let s:invert_selection = s:inverse
let s:invert_selection = ''
if exists('g:gruvbox_invert_selection')
  if g:gruvbox_invert_selection == 0
    let s:invert_selection = ''
  endif
endif

let s:invert_tabline = ''
if exists('g:gruvbox_invert_tabline')
  if g:gruvbox_invert_tabline == 1
    let s:invert_tabline = s:inverse
  endif
endif

let g:gruvbox_italicize_comments = 0
let s:italicize_comments = s:italic
if exists('g:gruvbox_italicize_comments')
  if g:gruvbox_italicize_comments == 0
    let s:italicize_comments = ''
  endif
endif

let s:italicize_strings = ''
if exists('g:gruvbox_italicize_strings')
  if g:gruvbox_italicize_strings == 1
    let s:italicize_strings = s:italic
  endif
endif

" }}}
" Highlighting Function: {{{

function! s:HL(group, fg, ...)
  " Arguments: group, guifg, guibg, gui, guisp

  " foreground
  let fg = a:fg

  " background
  if a:0 >= 1
    let bg = a:1
  else
    let bg = s:none
  endif

  " emphasis
  if a:0 >= 2 && strlen(a:2)
    let emstr = a:2
  else
    let emstr = 'NONE,'
  endif

  " special fallback
  if a:0 >= 3
    if g:gruvbox_guisp_fallback != 'NONE'
      let fg = a:3
    endif

    " bg fallback mode should invert higlighting
    if g:gruvbox_guisp_fallback == 'bg'
      let emstr .= 'inverse,'
    endif
  endif

  let histring = [ 'hi', a:group,
        \ 'guifg=' . fg[0], 'ctermfg=' . fg[1],
        \ 'guibg=' . bg[0], 'ctermbg=' . bg[1],
        \ 'gui=' . emstr[:-2], 'cterm=' . emstr[:-2]
        \ ]

  " special
  if a:0 >= 3
    call add(histring, 'guisp=' . a:3[0])
  endif

  execute join(histring, ' ')
endfunction

" }}}
" Gruvbox Hi Groups: {{{

" memoize common hi groups
call s:HL('GruvboxFg0', s:fg0)
call s:HL('GruvboxFg1', s:fg1)
call s:HL('GruvboxFg2', s:fg2)
call s:HL('GruvboxFg3', s:fg3)
call s:HL('GruvboxFg4', s:fg4)
call s:HL('GruvboxGray', s:gray)
call s:HL('GruvboxBg0', s:bg0)
call s:HL('GruvboxBg1', s:bg1)
call s:HL('GruvboxBg2', s:bg2)
call s:HL('GruvboxBg3', s:bg3)
call s:HL('GruvboxBg4', s:bg4)

call s:HL('GruvboxNone', s:none, s:none, '')
call s:HL('GruvboxRed', s:red)
call s:HL('GruvboxRedBold', s:red, s:none, s:bold)
call s:HL('GruvboxGreen', s:green)
call s:HL('GruvboxGreenBold', s:green, s:none, s:bold)
call s:HL('GruvboxYellow', s:yellow)
call s:HL('GruvboxYellowBold', s:yellow, s:none, s:bold)
call s:HL('GruvboxBlue', s:blue)
call s:HL('GruvboxBlueBold', s:blue, s:none, s:bold)
call s:HL('GruvboxPurple', s:purple)
call s:HL('GruvboxPurpleBold', s:purple, s:none, s:bold)
call s:HL('GruvboxAqua', s:aqua)
call s:HL('GruvboxAquaBold', s:aqua, s:none, s:bold)
call s:HL('GruvboxOrange', s:orange)
call s:HL('GruvboxOrangeBold', s:orange, s:none, s:bold)

call s:HL('GruvboxRedSign', s:red, s:sign_column, s:invert_signs)
call s:HL('GruvboxGreenSign', s:green, s:sign_column, s:invert_signs)
call s:HL('GruvboxYellowSign', s:yellow, s:sign_column, s:invert_signs)
call s:HL('GruvboxBlueSign', s:blue, s:sign_column, s:invert_signs)
call s:HL('GruvboxPurpleSign', s:purple, s:sign_column, s:invert_signs)
call s:HL('GruvboxAquaSign', s:aqua, s:sign_column, s:invert_signs)
call s:HL('GruvboxOrangeSign', s:orange, s:sign_column, s:invert_signs)

" }}}

" Vanilla colorscheme ---------------------------------------------------------
" General UI: {{{

" Normal text
call s:HL('Normal', s:fg1, s:bg0)

" Correct background (see issue #7):
" --- Problem with changing between dark and light on 256 color terminal
" --- https://github.com/morhetz/gruvbox/issues/7
if s:is_dark
  set background=dark
else
  set background=light
endif

if version >= 700
  " Screen line that the cursor is
  call s:HL('CursorLine',  s:none, s:bg1)
  " Screen column that the cursor is
  hi! link CursorColumn CursorLine

  " Tab pages line filler
  call s:HL('TabLineFill', s:bg4, s:bg1, s:invert_tabline)
  " Active tab page label
  call s:HL('TabLineSel', s:green, s:bg1, s:invert_tabline)
  " Not active tab page label
  hi! link TabLine TabLineFill

  " Match paired bracket under the cursor
  call s:HL('MatchParen', s:none, s:bg3, s:bold)
endif

if version >= 703
  " Highlighted screen columns
  call s:HL('ColorColumn',  s:none, s:color_column)

  " Concealed element: \lambda → λ
  call s:HL('Conceal', s:blue, s:none)

  " Line number of CursorLine
  call s:HL('CursorLineNr', s:yellow, s:bg0)
endif

hi! link NonText GruvboxBg2
hi! link SpecialKey GruvboxBg2

call s:HL('Visual',    s:none,  s:bg2, s:invert_selection)
hi! link VisualNOS Visual

call s:HL('Search',    s:yellow, s:bg0, s:inverse)
call s:HL('IncSearch', s:hls_cursor, s:bg0, s:inverse)

call s:HL('Underlined', s:blue, s:none, s:underline)

" original
"call s:HL('StatusLine',   s:bg2, s:fg1, s:inverse)
"call s:HL('StatusLineNC', s:bg1, s:fg4, s:inverse)

call s:HL('StatusLine',   s:gb.darkline, s:fg1, s:inverse)
call s:HL('StatusLineNC', s:gb.darkline, s:fg4, s:inverse)
"call s:HL('StatusLine',   s:bg4, s:yellow, s:inverse)
"call s:HL('StatusLineNC', s:bg3, s:fg3, s:inverse)

" The column separating vertically split windows
"call s:HL('VertSplit', s:bg3, s:vert_split)
call s:HL('VertSplit', s:gb.darkline, s:gb.darkline)

" Current match in wildmenu completion
call s:HL('WildMenu', s:blue, s:bg2, s:bold)

" Directory names, special names in listing
hi! link Directory GruvboxGreenBold

" Titles for output from :set all, :autocmd, etc.
hi! link Title GruvboxGreenBold

" Error messages on the command line
call s:HL('ErrorMsg',   s:bg0, s:red, s:bold)
" More prompt: -- More --
hi! link MoreMsg GruvboxYellowBold
" Current mode message: -- INSERT --
hi! link ModeMsg GruvboxYellowBold
" 'Press enter' prompt and yes/no questions
hi! link Question GruvboxOrangeBold
" Warning messages
hi! link WarningMsg GruvboxRedBold

" }}}
" Gutter: {{{

" Line number for :number and :# commands
call s:HL('LineNr', s:bg4, s:number_column)

" Column where signs are displayed
" call s:HL('SignColumn', s:none, s:sign_column)
call s:HL('SignColumn', s:none, s:number_column)

" Line used for closed folds
call s:HL('Folded', s:gray, s:bg1, s:italic)
" Column where folds are displayed
call s:HL('FoldColumn', s:gray, s:bg1)

" }}}
" Cursor: {{{

" Character under cursor
call s:HL('Cursor', s:none, s:none, s:inverse)
" Visual mode cursor, selection
hi! link vCursor Cursor
" Input moder cursor
hi! link iCursor Cursor
" Language mapping cursor
hi! link lCursor Cursor

" }}}
" Syntax Highlighting: {{{

if g:gruvbox_improved_strings == 0
  hi! link Special GruvboxOrange
else
  call s:HL('Special', s:orange, s:bg1, s:italicize_strings)
endif

" call s:HL('Comment', s:gray, s:none, s:italicize_comments)
call s:HL('Comment', s:gray, s:none, s:italicize_comments)
call s:HL('Todo', s:vim_fg, s:vim_bg, s:bold . s:italic)
call s:HL('Error', s:red, s:vim_bg, s:bold . s:inverse)

" Generic statement
hi! link Statement GruvboxRed
" if, then, else, endif, swicth, etc.
hi! link Conditional GruvboxRed
" for, do, while, etc.
hi! link Repeat GruvboxRed
" case, default, etc.
hi! link Label GruvboxRed
" try, catch, throw
hi! link Exception GruvboxRed
" sizeof, "+", "*", etc.
" hi! link Operator Normal
hi! link Operator GruvboxAqua
" Any other keyword
hi! link Keyword GruvboxRed

" Variable name
" hi! link Identifier GruvboxBlue
hi! link Identifier GruvboxFg1
" Function name
hi! link Function GruvboxPurple

" hi! link DiagnosticError GruvboxRed
hi! link DiagnosticHint GruvboxGreen
hi! link DiagnosticInfo GruvboxBlue
hi! link DiagnosticWarn GruvboxYellow
hi! link DiagnosticError GruvboxRed

" Generic preprocessor
hi! link PreProc GruvboxAqua
" Preprocessor #include
hi! link Include GruvboxAqua
" Preprocessor #define
hi! link Define GruvboxAqua
" Same as Define
hi! link Macro GruvboxAqua
" Preprocessor #if, #else, #endif, etc.
hi! link PreCondit GruvboxAqua
" Character constant: 'c', '/n'
hi! link Character GruvboxPurple
" String constant: "this is a string"
if g:gruvbox_improved_strings == 0
  call s:HL('String',  s:green, s:none, s:italicize_strings)
else
  call s:HL('String',  s:fg1, s:bg1, s:italicize_strings)
endif
" Boolean constant: TRUE, false
hi! link Boolean GruvboxPurple
" Number constant: 234, 0xff
hi! link Number GruvboxPurple
" Floating point constant: 2.3e10
hi! link Float GruvboxPurple
" Generic type
hi! link Type GruvboxYellow
" static, register, volatile, etc
hi! link StorageClass GruvboxOrange
" struct, union, enum, etc.
hi! link Structure GruvboxAqua

" }}}
" Completion Menu: {{{

if version >= 700
  " Popup menu: normal item
  " call s:HL('Pmenu', s:fg1, s:bg0)
  call s:HL('Pmenu', s:fg1, s:gb.dark01)
  " Popup menu: selected item
  call s:HL('PmenuSel', s:bg2, s:blue, s:bold)
  " Popup menu: scrollbar
  call s:HL('PmenuSbar', s:none, s:bg2)
  " Popup menu: scrollbar thumb
  call s:HL('PmenuThumb', s:none, s:bg4)
endif

" }}}
" Diffs: {{{

call s:HL('DiffDelete', s:red, s:bg0, s:inverse)
call s:HL('DiffAdd',    s:green, s:bg0, s:inverse)
"call s:HL('DiffChange', s:bg0, s:blue)
"call s:HL('DiffText',   s:bg0, s:yellow)

" Alternative setting
call s:HL('DiffChange', s:aqua, s:bg0, s:inverse)
call s:HL('DiffText',   s:yellow, s:bg0, s:inverse)

" }}}
" Spelling: {{{

if has("spell")
  " Not capitalised word, or compile warnings
  if g:gruvbox_improved_warnings == 0
    call s:HL('SpellCap',   s:none, s:none, s:undercurl, s:red)
  else
    call s:HL('SpellCap',   s:green, s:none, s:bold . s:italic)
  endif
  " Not recognized word
  call s:HL('SpellBad',   s:none, s:none, s:undercurl, s:blue)
  " Wrong spelling for selected region
  call s:HL('SpellLocal', s:none, s:none, s:undercurl, s:aqua)
  " Rare word
  call s:HL('SpellRare',  s:none, s:none, s:undercurl, s:purple)
endif

" }}}
" Float Window: {{{
hi! link FloatBorder Normal
hi! link NormalFloat Normal
" }}}

" Plugin specific -------------------------------------------------------------
" nvim-treesitter/nvim-treesitter {{{
call s:HL('TSStrong', s:none, s:none, s:bold)
call s:HL('TSEmphasis', s:none, s:none, s:italic)
call s:HL('TSUnderline', s:none, s:none, s:underline)
call s:HL('TSNote', s:bg0, s:green, s:bold)
call s:HL('TSWarning', s:bg0, s:yellow, s:bold)
call s:HL('TSDanger', s:bg0, s:red, s:bold)

highlight! link @annotation GruvboxPurple
highlight! link @attribute GruvboxPurple
highlight! link @boolean GruvboxPurple
highlight! link @character GruvboxAqua
highlight! link @character.special SpecialChar
highlight! link @comment Comment
highlight! link @conceal Conceal
highlight! link @conditional GruvboxRed
highlight! link @constant GruvboxFg1
highlight! link @constant.builtin GruvboxPurple
highlight! link @constant.macro GruvboxPurple
highlight! link @constructor GruvboxBlue
highlight! link @debug Debug
highlight! link @text.environment Macro
highlight! link @text.environment.name Type
highlight! link @define Define
" highlight! link @error Error
highlight! link @exception GruvboxRed
highlight! link @field GruvboxFg1
highlight! link @float GruvboxPurple
highlight! link @function Function
highlight! link @function.builtin Function
highlight! link @function.call GruvboxBlue
highlight! link @function.macro Function
highlight! link @include GruvboxRed
highlight! link @keyword GruvboxRed
highlight! link @keyword.function GruvboxRed
highlight! link @keyword.operator GruvboxOrange
highlight! link @keyword.return GruvboxRed
highlight! link @label GruvboxOrange
highlight! link @text.literal String
highlight! link @math GruvboxBlue
highlight! link @method GruvboxPurple
highlight! link @method.call GruvboxBlue
highlight! link @namespace GruvboxFg1
highlight! link @none GruvboxFg1
highlight! link @number GruvboxPurple
highlight! link @operator GruvboxAqua
highlight! link @parameter GruvboxFg1
highlight! link @parameter.reference GruvboxFg1
highlight! link @preproc PreProc
highlight! link @property GruvboxFg1
highlight! link @punctuation.bracket GruvboxFg1
highlight! link @punctuation.delimiter GruvboxAqua
highlight! link @punctuation.special GruvboxBlue
highlight! link @repeat GruvboxRed
highlight! link @storageclass GruvboxOrange
highlight! link @storageclass.lifetime GruvboxOrange
highlight! link @strike GruvboxFg1
highlight! link @string GruvboxGreen
highlight! link @string.escape GruvboxOrange
highlight! link @string.regex GruvboxOrange
highlight! link @string.special SpecialChar
highlight! link @symbol GruvboxFg1
highlight! link @tag GruvboxOrange
highlight! link @tag.attribute GruvboxGreen
highlight! link @tag.delimiter GruvboxGreen
highlight! link @text GruvboxGreen
highlight! link @text.reference GruvboxAqua
highlight! link @text.danger TSDanger
highlight! link @text.diff.add diffAdded
highlight! link @text.diff.delete diffRemoved
highlight! link @text.emphasis TSEmphasis
highlight! link @text.math GruvboxBlue
highlight! link @text.note TSNote
highlight! link @text.strike GruvboxFg1
highlight! link @text.strong TSStrong
highlight! link @text.title Title
highlight! link @text.todo Todo
highlight! link @text.underline TSUnderline
highlight! link @text.warning TSWarning
highlight! link @text.uri GruvboxBlue
highlight! link @uri GruvboxPurple
highlight! link @todo Todo
highlight! link @type GruvboxFg1
highlight! link @type.builtin GruvboxYellow
highlight! link @type.definition GruvboxPurple
highlight! link @type.qualifier GruvboxOrange
" highlight! link @variable GruvboxFg1
highlight! link @variable.builtin GruvboxPurple

" }}}
" LSP: {{{
hi! link LspSignatureActiveParameter GruvboxYellow
" hi! link @lsp.type.struct GruvboxFg1
" }}}
" Indent Guides: {{{

if !exists('g:indent_guides_auto_colors')
  let g:indent_guides_auto_colors = 0
endif

if g:indent_guides_auto_colors == 0
  if g:gruvbox_invert_indent_guides == 0
    call s:HL('IndentGuidesOdd', s:vim_bg, s:bg2)
    call s:HL('IndentGuidesEven', s:vim_bg, s:bg1)
  else
    call s:HL('IndentGuidesOdd', s:vim_bg, s:bg2, s:inverse)
    call s:HL('IndentGuidesEven', s:vim_bg, s:bg3, s:inverse)
  endif
endif

" }}}
" IndentLine: {{{

if !exists('g:indentLine_color_term')
  let g:indentLine_color_term = s:bg2[1]
endif
if !exists('g:indentLine_color_gui')
  let g:indentLine_color_gui = s:bg2[0]
endif

" }}}
" GitCommit: "{{{

hi! link gitcommitSelectedFile GruvboxGreen
hi! link gitcommitDiscardedFile GruvboxRed

" }}}
" Vim Multiple Cursors: {{{

call s:HL('multiple_cursors_cursor', s:none, s:none, s:inverse)
call s:HL('multiple_cursors_visual', s:none, s:bg2)

" }}}
" nvim-dap: {{{
hi! link DapBreakpoint GruvboxRed
hi! link DapStopped GruvboxGreen
" }}}
" NVIMTree: {{{
hi! link NvimTreeFolderName GruvboxAqua
hi! link NvimTreeOpenedFolderName GruvboxAqua
hi! link NvimTreeEmptyFolderName GruvboxAqua
hi! link NvimTreeFolderIcon GruvboxGreen
call s:HL('NvimTreeWindowPicker',   s:gb.darkline, s:gb.bright_blue, 'inverse,bold,')
" }}}
" Leap: {{{
call s:HL('LeapLabelPrimary', s:bg0, s:gb.bright_aqua)
" hi! link LeapLabelSecondary GruvboxBlue
" }}}
" Gitsigns: {{{
hi! link GitSignsAdd GruvboxAqua
hi! link GitSignsChange GruvboxGreen
hi! link GitSignsDelete GruvboxRed
" }}}
" Noice: {{{
hi! link NoiceCmdlinePopupBorder FloatBorder
hi! link NoicePopupmenu GruvboxFg1
" }}}
" Neorg: {{{
call s:HL('TSStrike', s:none, s:none, 'strikethrough,')
" hi! link @neorg.definitions.content GruvboxNone
hi! link @neorg.markup.strikethrough TSStrike
" hi! link @neorg.headings.3.title GruvboxYellow
" }}}
" flash.nvim {{{
call s:HL('FlashLabel', s:bg0, s:gb.bright_aqua)
call s:HL('FlashCurrent', s:bg0, s:gb.bright_aqua)
" }}}


" Filetype specific -----------------------------------------------------------
" Diff: {{{

hi! link diffAdded GruvboxGreen
hi! link diffRemoved GruvboxRed
hi! link diffChanged GruvboxAqua

hi! link diffFile GruvboxOrange
hi! link diffNewFile GruvboxYellow

hi! link diffLine GruvboxBlue

" }}}
" Go: {{{
hi! link @label.go GruvboxFg1
" }}}


" Functions -------------------------------------------------------------------
" Search Highlighting Cursor {{{

function! GruvboxHlsShowCursor()
  call s:HL('Cursor', s:bg0, s:hls_cursor)
endfunction

function! GruvboxHlsHideCursor()
  call s:HL('Cursor', s:none, s:none, s:inverse)
endfunction

" }}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker:
