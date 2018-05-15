"===============================
" vimキーマッピング
"===============================

"===============================
" 移動・選択系
"===============================

" 上下移動を表示に合わせる
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up>   gk
vnoremap j gj
vnoremap k gk

" visual modeの移動はshift押しながら
vnoremap <S-Down>  gj
vnoremap <S-Up>    gk
vnoremap <S-Left>  <Left>
vnoremap <S-Right> <Right>

" visual modeを解除して移動
" vnoremap <Up>    <ESC><Up>
" vnoremap <Left>  <ESC><Left>
" vnoremap <Right> <ESC><Right>
" vnoremap <Down>  <ESC><Down>

" スクロール
nnoremap <C-Up>   <C-y>
nnoremap <C-Down> <C-e>

" 全選択
nnoremap <C-a> ggvG$

" 選択しつつビジュアルモードへ

inoremap <S-Up>     <ESC>V<Up>
inoremap <S-Down>   <ESC>V<Down>
inoremap <S-Left>   <ESC>v<Left>
inoremap <S-Right>  <ESC>v<Right>
nnoremap <S-Up>     V<Up>
nnoremap <S-Down>   V<Down>
nnoremap <S-Left>   v<Left>
nnoremap <S-Right>  v<Right>
nnoremap <S-Home>   v<Home>
nnoremap <S-End>    v<End>
nnoremap <S-C-Home> v<C-Home>
nnoremap <S-C-End>  v<C-End>

inoremap <A-Up>     <ESC><C-v><Up>
inoremap <A-Down>   <ESC><C-v><Down>
inoremap <A-Left>   <ESC><C-v><Left>
inoremap <A-Right>  <ESC><C-v><Right>

nnoremap <A-Up>     <C-v><Up>
nnoremap <A-Down>   <C-v><Down>
nnoremap <A-Left>   <C-v><Left>
nnoremap <A-Right>  <C-v><Right>
nnoremap <A-Home>   <C-v><Home>
nnoremap <A-End>    <C-v><End>
nnoremap <A-C-Home> <C-v><C-Home>
nnoremap <A-C-End>  <C-v><C-End>

"===============================
" 編集系
"===============================

" visual mode 中にIとAでまとめて編集
vnoremap <expr> I  <SID>force_blockwise_visual('I')
vnoremap <expr> A  <SID>force_blockwise_visual('A')
function! s:force_blockwise_visual(next_key)
  if mode() ==# 'v'
    return "\<C-v>" . a:next_key
  elseif mode() ==# 'V'
    return "\<C-v>0o$" . a:next_key
  else  " mode() ==# "\<C-v>"
    return a:next_key
  endif
endfunction

" visualモードでの貼り付け
" vnoremap <expr> <C-p>  <SID>myVisualPaste()
" function! s:myVisualPaste()
"   if mode() ==# 'v'
"     return "\<C-v>I\<C-r>+\<Esc>"
"   elseif mode() ==# 'V'
"     return "xI\<CR>\<Up>\<C-r>+\<Esc>"
"   else  " mode() ==# "\<C-v>"
"     return "I\<C-r>+\<Esc>"
"   endif
" endfunction
"

" 選択行を移動(yankを使用)
nnoremap <C-S-Up>   dd<Up>P
nnoremap <C-S-Down> dd<Down>P
vnoremap <C-S-Up>   d<Up>P`[v`]V
vnoremap <C-S-Down> d<Down>P`[v`]V

" フォーマット(ファイルによって挙動を変える)
au FileType python nnoremap <C-l> :Autopep8<CR> 
au FileType markdown nnoremap <C-l> ggvG$:'<,'>Alignta \|<CR> 
au FileType gitcommit nnoremap <C-l> V:s/^#\t//g<CR>:s/ \+/ /g<CR>:noh<CR>

" クリップボードへコピー
nnoremap <C-y>   "+y
vnoremap <C-y>   "+y
" 0 CTRL-]	短縮入力(Abbreviations)を展開
" CTRL-^	lmapを有効化・無効化
" CTRL-_	allowrevinsが設定されている時に言語を切り替えるvnoremap y   "*y
" 1 CTRL-]	短縮入力(Abbreviations)を展開
" CTRL-^	lmapを有効化・無効化
" CTRL-_	allowrevinsが設定されている時に言語を切り替えるvnoremapvnoremap y   "*y
" 2 vnoremapvnoremap y   "*y
" 3 vnoremapvnoremap y   "*y
" 4 vnoremapvnoremap y   "*y

" 貼り付け(yankから)
" nnoremap p   ""p
" nnoremap P   ""P
" vnoremap p   ""p
" vnoremap P   ""P
" 貼り付け(clipboardから)
" nnoremap <C-p>   "+p
nnoremap <C-p>   "+P
" vnoremap <C-p>   "+P
" nnoremap <C-P>   "+P
" vnoremap <C-p>   "+p
" vnoremap <C-P>   "+P
"
" 下へコピー
nnoremap <C-d> VyPgvV
vnoremap <C-d> yPgv
inoremap <C-d> <Esc>VyPgvVa

" タブでインデント変更(shift+tab時はスペースであっても消す)
nnoremap <Tab>   v:s/^/\t/g<CR>:noh<CR>
vnoremap <Tab>   :s/^/\t/g<CR>:noh<CR>gv
nnoremap <S-Tab> v:s/\(^\t\\|^ \{1,4}\)//g<CR>:noh<CR>
vnoremap <S-Tab> :s/\(^\t\\|^ \{1,4}\)//g<CR>:noh<CR>gv
inoremap <S-Tab> <Esc>v:s/\(^\t\\|^ \{1,4}\)//g<CR>:noh<CR>i

" spaceでスペースを挿入
nnoremap <Space> i <ESC><Right>

" Enterで改行
nnoremap <CR> i<CR><Esc>

" Endで改行コードまで選択
nnoremap <End> <End><Right>


"===============================
" 削除
"===============================
" nnoremap d "+d
nnoremap <Bs> X

" 行削除
nnoremap <C-k> dd
inoremap <C-k> <Esc>dd

"===============================
" 特殊コマンド
"===============================

" 保存(terminalによって動いたり動かなかったり)
" nnoremap <C-s> :w<CR>:echo '保存しました☆彡'<CR>
" inoremap <C-s> <Esc>:w<CR>:echo '保存しました☆彡'<CR>


" 置換
nnoremap <C-h> :%s///gc<Left><Left><Left><Left>
vnoremap <C-h> :s///gc<Left><Left><Left><Left>

" ctrl+vでvisual矩形へ
inoremap <C-v> <ESC><Right><C-v>

" jjでesc
inoremap jj <Esc>

" .vimrc再読込
nnoremap <C-@> :source ~/.vimrc<CR>:noh<CR>:echo '.vimrcを読み込みました★'<CR>

" ハイライトを消す
nnoremap <f3> :noh<CR>

" 画面端で折り返すか切り替え
nnoremap <leader>z :set wrap<CR>
nnoremap <leader>x :set nowrap<CR>

" プロジェクトツリー表示(プラグイン)
nnoremap <leader>b :NERDTree<CR>


