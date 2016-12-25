com! UtilsNextFile      call utils#SwitchFile('bn!')
com! UtilsPrevFile      call utils#SwitchFile('bp!')
com! UtilsToggleHeader  call utils#ToggleHeader()
com! UtilsRunPy         call utils#RunPy()
com! UtilsQuitBuffer    call utils#QuitBuffer()
com! UtilsYouDao        call netrw#BrowseX('http://www.youdao.com/w/eng/'.expand('<cword>').'/#keyfrom=dict2.index', netrw#CheckIfRemote())

com! -range UtilsToggleComment call utils#ToggleComment(<line1>, <line2>)

nnoremap <Plug>UtilsSoLine "tyy:execute @t<cr>
nnoremap <Plug>UtilsSoLines "ty:execute @t<cr>

