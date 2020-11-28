"vimのノーマルモードを利用して，vscodeのCtrl+/のようなコメントアウトしたかった
"使い方
"<Space>f ：現在の行をコメントアウト or 現在の行をコメントアウトアウト
"<Space>c ：現在の行をコメントアウト
"n<Space>c：現在の行からn行分をコメントアウト
"<Space>C ：現在の行のコメントアウトを解除
"n<Space>C：現在の行からn行分のコメントアウトを解除
"GetComMozi関数とGetRegComMozi関数とGetComMoziNE関数に拡張子と対応するコメントアウト文字を設定することでコメントアウトキーバインドを利用できる
"GetRegComMozi関数に設定する文字は正規表現により入力する
"GetComMoziNE関数に設定する文字はGetComMozi関数のエスケープ文字を抜いたやつを入力する
"コメントアウト関数
"二重読み込み回避
if exists('g:loaded_coocvim')
  finish
endif
let g:loaded_coocvim = 1
"コメントアウトコマンドを定義
command! -nargs=? CommentOut call cooc#Com(<f-args>)
"Space+cでコメントアウト
"nnoremap <Space>f :CommentOut<CR>
"n<Spacs>cでn行分コメントアウト
"for n in range(1,300)
"  exec "nnoremap " . n . "<Space>f :CommentOut " . n ."<CR>"
"endfor
"コメントアウトアウトコマンドを定義
"n<Space>Cでn行分コメントアウトアウト
command! -range -nargs=0 UnCommentOut <line1>,<line2> call cooc#Ucom()
"Space+Cでコメントアウトアウト
nnoremap <Space>F :UnCommentOut<CR>
vnoremap <Space>F :UnCommentOut<CR>
"rangeの使い方がわかってない(range回繰り返してるだけ？)"
command! -range -nargs=0 SCO <line1>,<line2>call cooc#SwitchCom()
nnoremap <Space>f :SCO<CR>
vnoremap <Space>f :SCO<CR>
