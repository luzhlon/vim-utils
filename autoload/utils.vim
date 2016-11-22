"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                    Some useful functions
"                                   by codesoul
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua << EOF
vim.echo = function(msg) return vim.command('echo "'..msg..'"') end
vim.line = function(m) return vim.eval('line(\''..m..'\'') end
Comment = {
    lua = '--',
    python = '#',
    vim = '"',
    c = '//',
    cpp = '//',   
    java = '//',
    javascript = '//'
}
EOF
" if exists e in the list
func! s:listExist(list, e)
    for i in a:list
        if i == a:e
            return 1
        endif
    endfor
    return 0
endf
" Switch from .h and .cxx files
let s:cxx_ext = ['c', 'cpp', 'cc']
func! utils#ToggleHeader()
    let l:fp = expand('%:p')
    let l:ex = expand('%:p:e')
    let l:r =  expand('%:p:r')

    if s:listExist(s:cxx_ext, l:ex)
        let l:hf = l:r . '.' .'h'
        if filereadable(l:hf)
            execute('e! ' . l:hf)
            return
        endif
        echo 'no header file'
    else
        for l:e in s:cxx_ext
            let l:f = l:r . '.' . l:e
            if filereadable(l:f)
                execute('e! ' . l:f)
                return
            endif
        endfo
        echo 'no cxx file'
    endif
endf
" Toggle comment
func! utils#ToggleComment() range
lua << EOF
    local b = vim.buffer()           -- current buffer
    local fl = vim.eval('a:firstline')
    local ll = vim.eval('a:lastline')
    for ln = fl, ll do
        local line = b[ln]
        local ft = vim.eval '&ft'
        local comment = Comment[ft]
        if not comment then return end
        local pat = '^%s*'..comment
        if line:find(pat) then
            b[ln] = line:gsub('^(%s*)'..comment, '%1', 1)
        else
            b[ln] = comment..line
        end
    end
EOF
endf
" get the current buffer number
func! s:getcurbuf()
    return winbufnr(winnr())
endf
" Quit buffer but not with the window close
func! utils#QuitBuffer(force)
    let l:curbuf = s:getcurbuf()
    let l:force = a:force ? '!' : ''
    call execute('bn'.l:force)
    call execute(l:curbuf.'bw'.l:force)
endf
" Toggle relative number
func! utils#ToggleRNU()
    if &relativenumber
        set nornu
    else
        set rnu
    endif
endf
" Open a file
func! utils#OpenFile(...)
    if exists('a:1')
        call execute('e! ' . a:1)
    else
        call execute('e! ' . input('Open file: '))
    endif
endf
let s:qr_table = {
            \'lua':{->execute('!lua %:p', '') },
            \'python':{->execute('!python %:p', '')},
            \'vim':{->execute('so %')}
            \ }
" Run a script quickly
func! utils#QuickRun()
    if !exists('s:qr_table[&ft]')
        return
    endif

    let H = s:qr_table[&ft]
    call execute('w')
    if type(H) == v:t_func
        call H()
    endif
endf
