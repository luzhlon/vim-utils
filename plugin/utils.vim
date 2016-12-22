com! UtilsNextFile      call utils#SwitchFile('bn!')
com! UtilsPrevFile      call utils#SwitchFile('bp!')
com! UtilsToggleHeader  call utils#ToggleHeader()
com! UtilsRunPy         call utils#RunPy()
com! UtilsQuitBuffer    call utils#QuitBuffer(0)
com! UtilsQuitBuffer1   call utils#QuitBuffer(1)
com! UtilsYouDao        call netrw#BrowseX('http://www.youdao.com/w/eng/'.expand('<cword>').'/#keyfrom=dict2.index', netrw#CheckIfRemote())

com! -range UtilsToggleComment call utils#ToggleComment(<line1>, <line2>)
