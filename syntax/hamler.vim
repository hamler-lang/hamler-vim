" syntax highlighting for hamler
"
" Heavily modified version of the hamler syntax
" highlighter to support hamler.
"
" author: raichoo (raichoo@googlemail.com)

if exists("b:current_syntax")
  finish
endif

" Case sensitive
syn case match

" Comments
syn keyword hamlerTodo TODO FIXME contained

" Values
syn match hamlerIdentifier "\<[_a-z]\(\w\|\'\)*\>"
syn match hamlerNumber "0[xX][0-9a-fA-F]\+\|0[oO][0-7]\|[0-9]\+"
syn match hamlerFloat "[0-9]\+\.[0-9]\+\([eE][-+]\=[0-9]\+\)\="
syn keyword hamlerBoolean true false otherwise

" Delimiters
syn match hamlerDelimiter "[,;|.()[\]{}]"

" Types
syn match hamlerType "\%(\<class\s\+\)\@15<!\<\u\w*\>" contained
  \ containedin=hamlerTypeAlias
  \ nextgroup=hamlerType,hamlerTypeVar skipwhite
syn match hamlerTypeVar "\<[_a-z]\(\w\|\'\)*\>" contained
  \ containedin=hamlerData,hamlerNewtype,hamlerTypeAlias,hamlerFunctionDecl
syn region hamlerTypeExport matchgroup=hamlerType start="\<[A-Z]\(\S\&[^,.]\)*\>("rs=e-1 matchgroup=hamlerDelimiter end=")" contained extend
  \ contains=hamlerConstructor,hamlerDelimiter

" Constructors
syn match hamlerConstructor "\%(\<class\s\+\)\@15<!\<\u\w*\>"
syn region hamlerConstructorDecl matchgroup=hamlerConstructor start="\<[A-Z]\w*\>" end="\(|\|$\)"me=e-1,re=e-1 contained
  \ containedin=hamlerData,hamlerNewtype
  \ contains=hamlerType,hamlerTypeVar,hamlerDelimiter,hamlerOperatorType,hamlerOperatorTypeSig,@hamlerComment

" Functions
syn match hamlerFunction "\%(\<instance\s\+\|\<class\s\+\)\@18<!\<[_a-z]\(\w\|\'\)*\>" contained
" syn match hamlerFunction "\<[_a-z]\(\w\|\'\)*\>" contained
syn match hamlerFunction "(\%(\<class\s\+\)\@18<!\(\W\&[^(),\"]\)\+)" contained extend
syn match hamlerBacktick "`[_A-Za-z][A-Za-z0-9_\.]*`"

" Classes
syn region hamlerClassDecl start="^\%(\s*\)class\>"ms=e-5 end="\<where\>\|$"
  \ contains=hamlerClass,hamlerClassName,hamlerOperatorType,hamlerOperator,hamlerType,hamlerWhere
  \ nextgroup=hamlerClass
  \ skipnl
syn match hamlerClass "\<class\>" containedin=hamlerClassDecl contained
  \ nextgroup=hamlerClassName
  \ skipnl
syn match hamlerClassName "\<[A-Z]\w*\>" containedin=hamlerClassDecl contained

" Modules
syn match hamlerModuleName "\(\u\w\*\.\?\)*" contained excludenl
syn match hamlerModuleKeyword "\<module\>"
syn match hamlerModule "^module\>\s\+\<\(\w\+\.\?\)*\>"
  \ contains=hamlerModuleKeyword,hamlerModuleName
  \ nextgroup=hamlerModuleParams
  \ skipwhite
  \ skipnl
  \ skipempty
syn region hamlerModuleParams start="(" skip="([^)]\{-})" end=")" fold contained keepend
  \ contains=hamlerClassDecl,hamlerClass,hamlerClassName,hamlerDelimiter,hamlerType,hamlerTypeExport,hamlerStructure,hamlerModuleKeyword,@hamlerComment
  \ nextgroup=hamlerImportParams skipwhite

" Imports
syn match hamlerImportKeyword "\<\(foreign\|import\|qualified\)\>"
syn match hamlerImport "\<import\>\s\+\(qualified\s\+\)\?\<\(\w\+\.\?\)*"
  \ contains=hamlerImportKeyword,hamlerModuleName
  \ nextgroup=hamlerImportParams,hamlerImportAs,hamlerImportHiding
  \ skipwhite
syn region hamlerImportParams
  \ start="("
  \ skip="([^)]\{-})"
  \ end=")"
  \ contained
  \ contains=hamlerClass,hamlerClass,hamlerStructure,hamlerType,hamlerIdentifier
  \ nextgroup=hamlerImportAs
  \ skipwhite
syn keyword hamlerAsKeyword as contained
syn match hamlerImportAs "\<as\>\_s\+\u\w*"
  \ contains=hamlerAsKeyword,hamlerModuleName
  \ nextgroup=hamlerModuleName
syn keyword hamlerHidingKeyword hiding contained
syn match hamlerImportHiding "hiding"
  \ contained
  \ contains=hamlerHidingKeyword
  \ nextgroup=hamlerImportParams
  \ skipwhite

" Function declarations
syn region hamlerFunctionDecl
  \ excludenl start="^\z(\s*\)\(\(foreign\s\+import\)\_s\+\)\?[_a-z]\(\w\|\'\)*\_s\{-}\(::\|∷\)"
  \ end="^\z1\=\S"me=s-1,re=s-1 keepend
  \ contains=hamlerFunctionDeclStart,hamlerForall,hamlerOperatorType,hamlerOperatorTypeSig,hamlerType,hamlerTypeVar,hamlerDelimiter,@hamlerComment
syn region hamlerFunctionDecl
  \ excludenl start="^\z(\s*\)where\z(\s\+\)[_a-z]\(\w\|\'\)*\_s\{-}\(::\|∷\)"
  \ end="^\(\z1\s\{5}\z2\)\=\S"me=s-1,re=s-1 keepend
  \ contains=hamlerFunctionDeclStart,hamlerForall,hamlerOperatorType,hamlerOperatorTypeSig,hamlerType,hamlerTypeVar,hamlerDelimiter,@hamlerComment
syn region hamlerFunctionDecl
  \ excludenl start="^\z(\s*\)let\z(\s\+\)[_a-z]\(\w\|\'\)*\_s\{-}\(::\|∷\)"
  \ end="^\(\z1\s\{3}\z2\)\=\S"me=s-1,re=s-1 keepend
  \ contains=hamlerFunctionDeclStart,hamlerForall,hamlerOperatorType,hamlerOperatorTypeSig,hamlerType,hamlerTypeVar,hamlerDelimiter,@hamlerComment
syn match hamlerFunctionDeclStart "^\s*\(\(foreign\s\+import\|let\|where\)\_s\+\)\?\([_a-z]\(\w\|\'\)*\)\_s\{-}\(::\|∷\)" contained
  \ contains=hamlerImportKeyword,hamlerWhere,hamlerLet,hamlerFunction,hamlerOperatorType
syn keyword hamlerForall forall
syn match hamlerForall "∀"

" Keywords
syn keyword hamlerConditional if then else
syn keyword hamlerStatement do case of in
syn keyword hamlerLet let
syn keyword hamlerWhere where
syn match hamlerStructure "\<\(data\|newtype\|type\|kind\)\>"
  \ nextgroup=hamlerType skipwhite
syn keyword hamlerStructure derive
syn keyword hamlerStructure instance
  \ nextgroup=hamlerFunction skipwhite

" Infix
syn match hamlerInfixKeyword "\<\(infix\|infixl\|infixr\)\>"
syn match hamlerInfix "^\(infix\|infixl\|infixr\)\>\s\+\([0-9]\+\)\s\+\(type\s\+\)\?\(\S\+\)\s\+as\>"
  \ contains=hamlerInfixKeyword,hamlerNumber,hamlerAsKeyword,hamlerConstructor,hamlerStructure,hamlerFunction,hamlerBlockComment
  \ nextgroup=hamlerFunction,hamlerOperator,@hamlerComment

" Operators
syn keyword hamlerOperator and or not bor bxor bsl bsr band bnot
syn match hamlerOperator "\([-!#$%&\*\+/<=>\?@\\^|~:]\|\<_\>\)"
syn match hamlerOperatorType "\%(\<instance\>.*\)\@40<!\(::\|∷\)"
  \ nextgroup=hamlerForall,hamlerType skipwhite skipnl skipempty
syn match hamlerOperatorFunction "\(->\|<-\|[\\→←]\)"
syn match hamlerOperatorTypeSig "\(->\|<-\|=>\|<=\|::\|[∷∀→←⇒⇐]\)" contained
  \ nextgroup=hamlerType skipwhite skipnl skipempty

" Type definitions
syn region hamlerData start="^data\s\+\([A-Z]\w*\)" end="^\S"me=s-1,re=s-1 transparent
syn match hamlerDataStart "^data\s\+\([A-Z]\w*\)" contained
  \ containedin=hamlerData
  \ contains=hamlerStructure,hamlerType,hamlerTypeVar
syn match hamlerForeignData "\<foreign\s\+import\s\+data\>"
  \ contains=hamlerImportKeyword,hamlerStructure
  \ nextgroup=hamlerType skipwhite

syn region hamlerNewtype start="^newtype\s\+\([A-Z]\w*\)" end="^\S"me=s-1,re=s-1 transparent
syn match hamlerNewtypeStart "^newtype\s\+\([A-Z]\w*\)" contained
  \ containedin=hamlerNewtype
  \ contains=hamlerStructure,hamlerType,hamlerTypeVar

syn region hamlerTypeAlias start="^type\s\+\([A-Z]\w*\)" end="^\S"me=s-1,re=s-1 transparent
syn match hamlerTypeAliasStart "^type\s\+\([A-Z]\w*\)" contained
  \ containedin=hamlerTypeAlias
  \ contains=hamlerStructure,hamlerType,hamlerTypeVar

" Atoms
syn match hamlerAtom ":[a-z][0-9a-zA-Z_]\+"
syn match hamlerQuotedAtomModifier "\\\%(\o\{1,3}\|x\x\x\|x{\x\+}\|\^.\|.\)" contained
syn region hamlerQuotedAtom start=/:"/ end=/"/ contains=hamlerQuotedAtomModifier

" Binaries
syn match hamlerBinary '\%(\/\%(\s\|\n\|%.*\n\)*\)\@<=\%(Integer\|Float\|Binary\|Bytes\|Bitstring\|Bits\|Binary\|Utf8\|Utf16\|Utf32\|Signed\|Unsigned\|Big\|Little\|Native\|Unit\)\%(\%(\s\|\n\|%.*\n\)*-\%(\s\|\n\|%.*\n\)*\%(Integer\|Float\|Binary\|Bytes\|Bitstring\|Bits\|Binary\|Utf8\|Utf16\|Utf32\|Signed\|Unsigned\|Big\|Little\|Native\|Unit\)\)*' contains=@hamlerComment

" Maps
syn match hamlerMap '#'

" Strings
syn match hamlerChar "'[^'\\]'\|'\\.'\|'\\u[0-9a-fA-F]\{4}'"
syn region hamlerString start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=@Spell
syn region hamlerMultilineString start=+"""+ end=+"""+ fold contains=@Spell

" Comments
syn match hamlerLineComment "---*\([^-!#$%&\*\+./<=>\?@\\^|~].*\)\?$" contains=@Spell
syn region hamlerBlockComment start="{-" end="-}" fold
  \ contains=hamlerBlockComment,@Spell
syn cluster hamlerComment contains=hamlerLineComment,hamlerBlockComment,@Spell

syn sync minlines=50

" highlight links
highlight def link hamlerModule Include
highlight def link hamlerImport Include
highlight def link hamlerModuleKeyword hamlerKeyword
highlight def link hamlerImportAs Include
highlight def link hamlerModuleName Include
highlight def link hamlerModuleParams hamlerDelimiter
highlight def link hamlerImportKeyword hamlerKeyword
highlight def link hamlerAsKeyword hamlerKeyword
highlight def link hamlerHidingKeyword hamlerKeyword

highlight def link hamlerConditional Conditional
highlight def link hamlerWhere hamlerKeyword
highlight def link hamlerInfixKeyword hamlerKeyword

highlight def link hamlerBoolean Boolean
highlight def link hamlerNumber Number
highlight def link hamlerFloat Float

highlight def link hamlerDelimiter Delimiter

highlight def link hamlerOperatorTypeSig hamlerOperatorType
highlight def link hamlerOperatorFunction hamlerOperatorType
highlight def link hamlerOperatorType hamlerOperator

highlight def link hamlerConstructorDecl hamlerConstructor
highlight def link hamlerConstructor hamlerFunction

highlight def link hamlerTypeVar Identifier
highlight def link hamlerForall hamlerStatement

highlight def link hamlerAtom String
highlight def link hamlerQuotedAtom String
highlight def link hamlerBinary Type
highlight def link hamlerMap Structure
highlight def link hamlerChar String
highlight def link hamlerBacktick hamlerOperator
highlight def link hamlerString String
highlight def link hamlerMultilineString String

highlight def link hamlerLineComment hamlerComment
highlight def link hamlerBlockComment hamlerComment

" hamler general highlights
highlight def link hamlerClass hamlerKeyword
highlight def link hamlerClassName Type
highlight def link hamlerStructure hamlerKeyword
highlight def link hamlerKeyword Keyword
highlight def link hamlerStatement Statement
highlight def link hamlerLet Statement
highlight def link hamlerOperator Operator
highlight def link hamlerFunction Function
highlight def link hamlerType Type
highlight def link hamlerComment Comment

let b:current_syntax = "hamler"
