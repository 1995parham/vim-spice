" In The Name of God
" Vim syntax file
" Language:	Spice circuit simulator input netlist
" Maintainer:	Noam Halevy <Noam.Halevy.motorola.com>
" Maintainer:	Parham Alvani <parham.alvani@gmail.com>
" Last Change:	2014 Dec 08
" 		(Dominique Pelle added @Spell)
"
" This is based on sh.vim by Lennart Schultz
" but greatly simplified

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" spice syntax is case INsensitive
syn case ignore

syn keyword	spiceTodo	contained TODO

syn match spiceComment  "^ \=\*.*$" contains=@Spell
syn match spiceComment  "\$.*$" contains=@Spell

" Numbers, all with engineering suffixes and optional units
"==========================================================
"floating point number, with dot, optional exponent
syn match spiceNumber  "\<[0-9]\+\.[0-9]*\(e[-+]\=[0-9]\+\)\=\(meg\=\|[afpnumkg]\)\="
"floating point number, starting with a dot, optional exponent
syn match spiceNumber  "\.[0-9]\+\(e[-+]\=[0-9]\+\)\=\(meg\=\|[afpnumkg]\)\="
"integer number with optional exponent
syn match spiceNumber  "\<[0-9]\+\(e[-+]\=[0-9]\+\)\=\(meg\=\|[afpnumkg]\)\="

" Elements
" ========
" Resistors
syn match spiceElement "^r\S*"
" Capacitor
syn match spiceElement "^c\S*"
" Inductor
syn match spiceElement "^l\S*"
" Independent voltage source
syn match spiceElement "^v\S*"
" Independent current source
syn match spiceElement "^i\S*"
" Voltage-controlled voltage source
syn match spiceElement "^E\S*"
" Current-controlled voltage source
syn match spiceElement "^H\S*"
" Voltage-controlled current source
syn match spiceElement "^G\S*"
" Current-controlled current source
syn match spiceElement "^F\S*"
" MOSFET
syn match spiceElement "^m\S*"
" BJT
syn match spiceElement "^q\S*"
" Diode
syn match spiceElement "^d\S*"

" Models
" ======
syn keyword spiceModel .model
syn keyword spiceModelType nmos pmos nfet pfet NPN PNP D

syn region  spiceMosfet matchgroup=spiceElement start="^m\S\+" end="nmos\|pmos\|nfet\|pfet" oneline keepend contains=CONTAINED,spiceNode
syn match   spiceNode   /\(.\{-}\zs\S\+\)\{2}/ containedin=spiceMosfet contained


" Analysis
" ========
" AC analysis
syn keyword spiceAnal .ac
" DC analysis
syn keyword spiceAnal .dc
" Transient analysis
syn keyword spiceAnal .tran
" TF analysis
syn keyword spiceAnal .tf
" PZ analysis
syn keyword spiceAnal .pz

" Functions
" =========
" Sinusoidal source
syn keyword spiceFunc sin
" Square wave source
syn keyword spiceFunc pulse
" Piece-wise linear source
syn keyword spiceFunc pwl

" Misc
"=====
syn match   spiceWrapLineOperator       "\\$"
syn match   spiceWrapLineOperator       "^+"

" MOSFET WL
syn match   spiceStatement      "W="
syn match   spiceStatement      "L="

syn match   spiceStatement      "^ \=\.\I\+"

" Matching pairs of parentheses
"==========================================
syn region  spiceParen transparent matchgroup=spiceOperator start="(" end=")" contains=ALLBUT,spiceParenError,spiceNode
syn region  spiceSinglequote matchgroup=spiceOperator start=+'+ end=+'+

" Errors
"=======
syn match spiceParenError ")"

" Syncs
" =====
syn sync minlines=50

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_spice_syntax_inits")
  if version < 508
    let did_spice_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink spiceTodo		Todo
  HiLink spiceWrapLineOperator	spiceOperator
  HiLink spiceSinglequote	spiceExpr
  HiLink spiceExpr		Function
  HiLink spiceParenError	Error
  HiLink spiceStatement		Statement
  HiLink spiceNumber		Number
  HiLink spiceComment		Comment
  HiLink spiceOperator		Operator
  HiLink spiceElement           Define
  HiLink spiceAnal		Keyword		
  HiLink spiceFunc		Function
  HiLink spiceModel		Structure
  HiLink spiceModelType		Type
  HiLink spiceNode		Special

  delcommand HiLink
endif

let b:current_syntax = "spice"

" insert the following to $VIM/syntax/scripts.vim
" to autodetect HSpice netlists and text listing output:
"
" " Spice netlists and text listings
" elseif getline(1) =~ 'spice\>' || getline("$") =~ '^\.end'
"   so <sfile>:p:h/spice.vim

" vim: ts=8
