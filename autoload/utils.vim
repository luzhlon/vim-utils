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
    let nr = bufnr('%')
    exe a:cmd
    while bufnr('%') != nr && &buftype != ''
        exe a:cmd
    endw
endf
" Switch from .h and .cxx files
let s:cxx_ext = ['c', 'cpp', 'cc']
fun! utils#ToggleHeader()
    let fp = expand('%:p')
    let ex = expand('%:p:e')
    let r =  expand('%:p:r')
    if index(s:cxx_ext, ex) < 0
        for e in s:cxx_ext
            let f = r . '.' . e
            if filereadable(f)
                exec 'e! ' . f
                return
            endif
        endfo
        echo 'no cxx file'
    else
        let hf = r . '.' .'h'
        if filereadable(hf)
            exec 'e! ' . hf
            return
        endif
        echo 'no header file'
    endif
endf
let s:comment = {'lua' : '--', 'python' : '#', 'vim' : '"',
            \    'c' : '//', 'cpp' : '//',   'java' : '//', 'javascript' : '//'}
" Toggle comment
fun! utils#ToggleComment(...) range
    if a:0 > 1
        let i = a:1 | let j = a:2
    else
        let i = a:firstline | let j = a:lastline
    endif
try
    while i <= j
        let line = getline(i)
        let comchar = s:comment[&ft]
        if match(line, '^' . comchar) >= 0
            call setline(i, substitute(line, '^'.comchar, '', ''))
        else
            call setline(i, comchar . line)
        endif
        let i += 1
    endw
endtry
endf
" Quit buffer but not with the window close
fun! utils#QuitBuffer(force)
    let curbuf = bufnr('%')
    let force = a:force ? '!' : ''
    exec 'bn'.force
    exec curbuf.'bw'.force
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
        write
        if type(H) == v:t_func
            call H()
        endif
    catch
        return
    endtry
endf
