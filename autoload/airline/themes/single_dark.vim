scriptencoding utf-8

" This Airline theme is based on dark_minimal.vim from vim-airline-themes.

" Each theme is contained in its own file and declares variables scoped to the
" file.  These variables represent the possible "modes" that airline can
" detect.  The mode is the return value of mode(), which gets converted to a
" readable string.  The following is a list currently supported modes: normal,
" insert, replace, visual, and inactive.
"
" Each mode can also have overrides.  These are small changes to the mode that
" don't require a completely different look.  "modified" and "paste" are two
" such supported overrides.  These are simply suffixed to the major mode,
" separated by an underscore.  For example, "normal_modified" would be normal
" mode where the current buffer is modified.
"
" The theming algorithm is a 2-pass system where the mode will draw over all
" parts of the statusline, and then the override is applied after.  This means
" it is possible to specify a subset of the theme in overrides, as it will
" simply overwrite the previous colors.  If you want simultaneous overrides,
" then they will need to change different parts of the statusline so they do
" not conflict with each other.
"
" First, let's define an empty dictionary and assign it to the "palette"
" variable. The # is a separator that maps with the directory structure. If
" you get this wrong, Vim will complain loudly.
let g:airline#themes#single_dark#palette = {}

" First let's define some arrays. The s: is just a VimL thing for scoping the
" variables to the current script. Without this, these variables would be
" declared globally. Now let's declare some colors for normal mode and add it
" to the dictionary.  The array is in the format:
" [ guifg, guibg, ctermfg, ctermbg, opts ]. See "help attr-list" for valid
" values for the "opt" value.

" Color map palette explanation
" 1 - Outside blocks (mode and the position in the file)
" 2 - Next blocks inside (branch and file format)
" 3 - The middle block (file name)
" [ gui_fg, gui_bg, terminal_fg, terminal_bg, extra (e.g. 'bold') ]

" Normal mode
let s:N1 = [ '#00005f', '#dfff00',  17, 190 ]
let s:N2 = [ '#333333', '#dddddd', 255, 238 ]
let s:N3 = [ '#209020', '#eeeeee',  85, 234 ]
let s:NormalColorMap = airline#themes#generate_color_map(s:N1, s:N2, s:N3)

let g:airline#themes#single_dark#palette.normal = s:NormalColorMap

" Insert mode
let s:I1 = [ '#00005f', '#00dfff',  17,  45 ]
let s:Ip = [ '#00005f', '#d78700',  17, 172 ]
let s:InsertColorMap = airline#themes#generate_color_map(s:I1, s:N2, s:N3)

let g:airline#themes#single_dark#palette.insert = s:InsertColorMap
let g:airline#themes#single_dark#palette.insert_paste = { 'airline_a': s:Ip }

" Replace mode
let s:Ra = [ '#ffffff', '#af0000', 255, 124, '' ]
let s:ReplaceColorMap = airline#themes#generate_color_map(s:I1, s:N2, s:N3)

let g:airline#themes#single_dark#palette.replace = s:ReplaceColorMap
let g:airline#themes#single_dark#palette.replace.airline_a = s:Ra

" Visual mode
let s:V1 = [ '#000000', '#ffaf00', 232, 214 ]
let s:VisualColorMap = airline#themes#generate_color_map(s:V1, s:N2, s:N3)

let g:airline#themes#single_dark#palette.visual = s:VisualColorMap

" Inactive mode
let s:IA1 = [ '#a1a1a1', '#dfdfdf', 239, 234, '' ]
let s:IA2 = [ '#a1a1a1', '#cccccc', 239, 235, '' ]
let s:IA3 = [ '#a1a1a1', '#c0c0c0', 239, 236, '' ]
let s:InactiveColorMap = airline#themes#generate_color_map(s:IA1, s:IA2, s:IA3)

let g:airline#themes#single_dark#palette.inactive = s:InactiveColorMap

" Accents are used to give parts within a section a slightly different look or
" color. Here we are defining a "red" accent, which is used by the 'readonly'
" part by default. Only the foreground colors are specified, so the background
" colors are automatically extracted from the underlying section colors. What
" this means is that regardless of which section the part is defined in, it
" will be red instead of the section's foreground color. You can also have
" multiple parts with accents within a section.
let s:A = [ '#ff0000', '', 160, '' ]
let g:airline#themes#single_dark#palette.accents = { 'red': s:A }

" Here we define the color map for ctrlp.  We check for the g:loaded_ctrlp
" variable so that related functionality is loaded iff the user is using
" ctrlp. Note that this is optional, and if you do not define ctrlp colors
" they will be chosen automatically from the existing palette.
if get(g:, 'loaded_ctrlp', 0)
  let s:P1 = [ '#d7d7ff', '#5f00af', 189,  55, ''     ]
  let s:P2 = [ '#ffffff', '#875fd7', 231,  98, ''     ]
  let s:P3 = [ '#5f00af', '#ffffff',  55, 231, 'bold' ]
  let s:PasteColorMap = airline#extensions#ctrlp#generate_color_map(s:P1, s:P2, s:P3)
  let g:airline#themes#single_dark#palette.ctrlp = s:PasteColorMap
endif
