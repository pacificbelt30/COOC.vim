" coMozi:コメントアウト文字
" coRegMozi:コメントアウト文字正規表現版
" coMoziNE:コメントアウト文字(?)
" extention:対応するファイルの拡張子(そのうちfiletype判定にする)
let g:COList = [
\  {"coMozi":"\\/\\/","coRegMozi":"\\/\\/","coMoziNE":"\/\/","extention":["c","cpp","h","cxx","hpp","java","cs","php","js"],"filetype":["c","cpp","h","cxx","hpp","java","cs","php","javascript"]},
\  {"coMozi":"#","coRegMozi":"#","coMoziNE":"#","extention":["py","rb","sh"],"filetype":["python","ruby","sh"]},
\  {"coMozi":"%","coRegMozi":"%","coMoziNE":"%","extention":["tex","sty","m"],"filetype":["tex"]},
\  {"coMozi":"\"","coRegMozi":"\"","coMoziNE":"\"","extention":["vim"],"filetype":["vim"]}]
function! easyCO#Com(...) range
  "let filenum = line("$") - line(".")
  let num = 0
  "let currentLine = line(".")
  if a:0>0 " 引数ありの場合 (firstline,lastline)
    let first = a:1
    let num = a:2-a:1
  else
    let first = a:firstline
    let num = a:lastline - a:firstline
  endif
  let ex = expand("%:e")
  "exec ":UnCommentOut " . l:num . "<CR>"
  let ex = easyCO#GetComMozi()
  let exr = easyCO#GetRegComMozi()
  if l:exr == ""
    return 0
  endif
  "exec ":" . l:currentLine . ",+" . l:num . "s/^\\zs".l:exr."\\ze.*$/".l:ex
  exec ":" . l:first . ",+" . l:num . "s/^ *\\zs\\(".l:exr."\\|\\)\\ze.*$/".l:ex
  "echo "行".l:first ."から". l:num . "行コメントアウトしました"
endfunction
"コメントアウトアウト？
function! easyCO#Ucom(...) range
  "let filenum = line("$") - line(".")
  let num = 0
  if a:0>0 " 引数ありの場合 (firstline,lastline)
    let first = a:1
    let num = a:2-a:1
  else
    let first = a:firstline
    let num = a:lastline - a:firstline
  endif
  let ex = expand("%:e")
  let exr = easyCO#GetRegComMozi()
  if l:exr == ""
    return 0
  endif
  exec ":" . l:first ",+" . l:num . "s/^ *\\zs".l:exr."\\ze//"
  "echo "行".l:first ."から". l:num . "行コメントを外しました"
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
function! easyCO#SwitchCom() range
  echo a:firstline . ' ' . a:lastline
  if a:lastline - a:firstline <= 0
    if easyCO#IsCommentOut() == 1
      exec ":call easyCO#Ucom(" . a:firstline . "," . a:lastline . ")"
    else
      exec ":call easyCO#Com(" . a:firstline . "," . a:lastline . ")"
    endif
  else
    exec ":call easyCO#Com(" . a:firstline . "," . a:lastline . ")"
  endif
endfunction

" オペレータとしてのコメントアウト
function! easyCO#OPCom(...)
  let first =line("'[")
  let last =line("']")
  exec ":call easyCO#Com(" . l:first . "," . l:last . ")"
endfunction
function! easyCO#OPUCom(...)
  let first =line("'[")
  let last =line("']")
  exec ":call easyCO#UCom(" . l:first . "," . l:last . ")"
endfunction


