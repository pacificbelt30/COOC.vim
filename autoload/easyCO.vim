function! easyCO#Com(...)
  let filenum = line("$") - line(".")
  let num = 0
  let currentLine = line(".")
  if a:0 >0
    let num = a:1-1
    let filenum -= (a:1-1)
  endif
  let ex = expand("%:e")
  if filenum <= 0
    let num = line("$") - line(".")
  endif
  "exec ":UnCommentOut " . l:num . "<CR>"
  let ex = easyCO#GetComMozi()
  let exr = easyCO#GetRegComMozi()
  if l:ex == ""
    return 0
  endif
  let jf = a:firstline - a:lastline
"  exec ":" . l:currentLine . ",+" . l:num . "s/^\\zs".l:exr."\\ze.*$/".l:ex
  exec ":" . a:firstline . ",+" . l:jf . "s/^ *\\zs".l:exr."\\ze.*$/".l:ex
endfunction
"コメントアウトアウト？
function! easyCO#Ucom(...)
  let filenum = line("$") - line(".")
  let num = 0
  if a:0>0
    let num = a:1-1
    let filenum -= (a:1-1)
  endif
  let ex = expand("%:e")
  if filenum <= 0
    let num = line("$") - line(".")
  endif
  let exr = easyCO#GetRegComMozi()
  if l:exr == ""
    return 0
  endif
  exec ":,+" . l:num . "s/^ *\\zs".l:exr."\\ze//"
endfunction
"引数の文字列はダブルクォーテーションマークをつけないといけない
"各拡張子に対応するコメントアウト文字を取得する
function! easyCO#GetComMozi()
  let ex = expand("%:e")
  if l:ex == "c" || l:ex == "h" || l:ex == "cpp" || l:ex == "cxx" || l:ex == "hpp" || l:ex == "java" || l:ex == "cs" || l:ex == "php" || l:ex == "js"
    return "\\/\\/"
  elseif l:ex == "tex" || l:ex == "sty" || l:ex == "m"
    return "%"
  elseif l:ex == "py" || l:ex == "rb" || l:ex == "sh"
    return "#"
  elseif l:ex == "vim"
    return "\""
  else
    return ""
  endif
endfunction
function! easyCO#GetComMoziNE()
  let ex = expand("%:e")
  if l:ex == "c" || l:ex == "h" || l:ex == "cpp" || l:ex == "cxx" || l:ex == "hpp" || l:ex == "java" || l:ex == "cs" || l:ex == "php" || l:ex == "js"
    return "\/\/"
  elseif l:ex == "tex" || l:ex == "sty" || l:ex == "m"
    return "%"
  elseif l:ex == "py" || l:ex == "rb" || l:ex == "sh"
    return "#"
  elseif l:ex == "vim"
    return "\""
  else
    return ""
  endif
endfunction
"各拡張子に対応するコメントアウト文字を正規表現で取得する
function! easyCO#GetRegComMozi()
  let ex = expand("%:e")
  if l:ex == "c" || l:ex == "h" || l:ex == "cpp" || l:ex == "cxx" || l:ex == "hpp" || l:ex == "java" || l:ex == "cs" || l:ex == "php" || l:ex == "js"
    return "\\/*"
  elseif l:ex == "tex" || l:ex == "sty" || l:ex == "m"
    return "%*"
  elseif l:ex == "py" || l:ex == "rb" || l:ex == "sh"
    return "#*"
  elseif l:ex == "vim"
    return "\"*"
  else
    return ""
  endif
endfunction
"すでにコメントアウトされている行か確認
"コメントアウトされている場合は1(true)"
function! easyCO#IsCommentOut()
  let co = 1
  let ge = 0
  while 1
    if getline(".")[l:ge] != " "
      break
    endif
    let l:ge = l:ge + 1
  endwhile
  for n in range(strlen(easyCO#GetComMoziNE()))
    let tmp = l:ge + n 
    if getline(".")[l:tmp] != easyCO#GetComMoziNE()[n]
      let l:co = 0
      break
    endif
  endfor
  return l:co
endfunction
"コメントアウト実行"
function! easyCO#SwitchCom()
  if a:lastline - a:firstline <=0
    if easyCO#IsCommentOut() == 1
      exec ":call easyCO#Ucom()"
    else
      exec ":call easyCO#Com()"
    endif
  else
    exec "call easyCO#Com()"
  endif
endfunction
