" coMozi:コメントアウト文字
" coRegMozi:コメントアウト文字正規表現版
" coMoziNE:コメントアウト文字(?)
" extention:対応するファイルの拡張子(そのうちfiletype判定にする)
let g:COList = [
\  {"coMozi":"\\/\\/","coRegMozi":"\\/\\/","coMoziNE":"\/\/","extention":["c","cpp","h","cxx","hpp","java","cs","php","js"],"filetype":["c","cpp","h","cxx","hpp","java","cs","php","javascript"]},
\  {"coMozi":"#","coRegMozi":"#","coMoziNE":"#","extention":["py","rb","sh"],"filetype":["python","ruby","sh"]},
\  {"coMozi":"%","coRegMozi":"%","coMoziNE":"%","extention":["tex","sty","m"],"filetype":["tex"]},
\  {"coMozi":"\"","coRegMozi":"\"","coMoziNE":"\"","extention":["vim"],"filetype":["vim"]}]
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
  "exec ":" . l:currentLine . ",+" . l:num . "s/^\\zs".l:exr."\\ze.*$/".l:ex
  exec ":" . a:firstline . ",+" . l:jf . "s/^ *\\zs\\(".l:exr."\\|\\)\\ze.*$/".l:ex
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
  let currentFileType = g:context_filetype#get_filetype()
  "let currentFileType = &filetype
  for i  in range(len(g:COList))
    for j in g:COList[i]["filetype"]
      if j == l:currentFileType
        return g:COList[i]["coMozi"]
      endif
    endfor
  endfor
  "let ex = expand("%:e")
  "for i  in range(len(g:COList))
    "for j in g:COList[i]["extention"]
      "if j == l:ex
        "return g:COList[i]["coMozi"]
      "endif
    "endfor
  "endfor
  return ""
endfunction
function! easyCO#GetComMoziNE()
  let currentFileType = g:context_filetype#get_filetype()
  "let currentFileType = &filetype
  for i  in range(len(g:COList))
    for j in g:COList[i]["filetype"]
      if j == l:currentFileType
        return g:COList[i]["coMoziNE"]
      endif
    endfor
  endfor
  "let ex = expand("%:e")
  "for i  in range(len(g:COList))
    "for j in g:COList[i]["extention"]
      "if j == l:ex
        "return g:COList[i]["coMoziNE"]
      "endif
    "endfor
  "endfor
  return ""
endfunction
"各拡張子に対応するコメントアウト文字を正規表現で取得する
function! easyCO#GetRegComMozi()
  let currentFileType = g:context_filetype#get_filetype()
  "let currentFileType = &filetype
  for i  in range(len(g:COList))
    for j in g:COList[i]["filetype"]
      if j == l:currentFileType
        return g:COList[i]["coRegMozi"]
      endif
    endfor
  endfor
  "let ex = expand("%:e")
  "for i  in range(len(g:COList))
    "for j in g:COList[i]["extention"]
      "if j == l:ex
        "return g:COList[i]["coRegMozi"]
      "endif
    "endfor
  "endfor
  return ""
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
    exec ":call easyCO#Com()"
  endif
endfunction
