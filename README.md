# easyCO.vim
easy comment out plugin for vim
# instlation
If you are using vim-plug:
```vim
Plug "pacificbelt30/easyCO.vim"
```

you are using something else, I don't know.

# requirement
You will need to install [context_filetype](https://github.com/Shougo/context_filetype.vim) to determine the filetype.
If you are using vim-plug:
```vim
Plug "Shougo/context_filetype"
```

# DEMO
![DEMO](https://user-images.githubusercontent.com/57101176/140297543-422968eb-92bf-4df3-a454-bdaa6241692c.gif)

# Copyright
see ./LICENSE
```txt
Guard object of logger for debugging.
Copyright (c) 2020 pacificbelt30 
```

# Usage
The basic usage is to type `<Space>f` on the line you want to comment out or uncomment.
| Command        | Description |
| ---            | ---         |
| `:CommentOut`   | Comments out the specified line.  The key mapping is assigned nothing. |
| `:UnCommentOut` | UnComments out the specified line.  The key mapping is assigned to `<Space>F`. |
| `:SCO`          | Uncomment the specified line if it is commented out, or comment it out if it is not.  If a visual mode or number is specified, the range will be commented out.  The key mapping is assigned to `<Space>f`. |

## use in Operrator 
The operator can also be used to perform comment out.
The default value is assigned to `<Space><Space>f`, so after entering it, you can specify a range of text objects, such as `i{`, to comment out the text within that range.
If you want to uncomment the text, use `<Space><Space>F`.
