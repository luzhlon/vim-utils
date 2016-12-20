"--------------------------------------------------------------"
"--------------------Some useful functions---------------------"
"-----------------------------------by codesoul----------------"
"--------------------------------------------------------------"
"有更高效的实现方法，有空再写
"getbufinfo(),getbufvar(, '&buftype')
"下一个buffertype为空的buffer
"call utils#SwitchFile('bn!')
"call utils#SwitchFile('bp!')
fun! utils#SwitchFile(cmd)
    let l:nr = bufnr('%')
    exe a:cmd
    while bufnr('%') != l:nr && &buftype != ''
        exe a:cmd
    endw
endf
" Switch from .h and .cxx files
let s:cxx_ext = ['c', 'cpp', 'cc']
fun! utils#ToggleHeader()
    let l:fp = expand('%:p')
    let l:ex = expand('%:p:e')
    let l:r =  expand('%:p:r')
    if index(s:cxx_ext, l:ex) < 0
        for l:e in s:cxx_ext
            let l:f = l:r . '.' . l:e
            if filereadable(l:f)
                execute('e! ' . l:f)
                return
            endif
        endfo
        echo 'no cxx file'
    else
        let l:hf = l:r . '.' .'h'
        if filereadable(l:hf)
            execute('e! ' . l:hf)
            return
        endif
        echo 'no header file'
    endif
endf
let s:comment = {'lua' : '--', 'python' : '#', 'vim' : '"',
            \    'c' : '//', 'cpp' : '//',   'java' : '//', 'javascript' : '//'}
" Toggle comment
fun! utils#ToggleComment() range
    let l:i = a:firstline
try
    while l:i <= a:lastline
        let l:line = getline(l:i)
        let l:comchar = s:comment[&ft]
        if match(l:line, '^' . l:comchar) >= 0
            call setline(l:i, substitute(l:line, '^'.l:comchar, '', ''))
        else
            call setline(l:i, l:comchar . l:line)
        endif
        let l:i += 1
    endw
endtry
endf
" Quit buffer but not with the window close
fun! utils#QuitBuffer(force)
    let l:curbuf = bufnr('%')
    let l:force = a:force ? '!' : ''
    call execute('bn'.l:force)
    call execute(l:curbuf.'bw'.l:force)
endf
"Run python script
fun! utils#RunPy()
    write
    if match(getline(1), '^#.*python3') < 0
        !python %:p
    else
        !python3 %:p
    endif
endf

fun! utils#GetSelection()
    " Why is this not a built-in Vim script function?!
    let [lnum1, col1] = getpos("'<")[1:2]
    let [lnum2, col2] = getpos("'>")[1:2]
    let lines = getline(lnum1, lnum2)
    let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][col1 - 1:]
    return join(lines, "\n")
endf
" Run a script quickly
let s:qr_table = {
            \'lua':{->execute('!lua %:p', '') },
            \'python':{->execute('!python %:p', '')},
            \'vim':{->execute('so %')}
            \ }
fun! utils#QuickRun()
    try
        let H = s:qr_table[&ft]
        call execute('w')
        if type(H) == v:t_func
            call H()
        endif
    catch
        return
    endtry
endf
