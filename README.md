# vim-utils
Some practical functions script for vim.

// 一些vim常用的功能脚本

__部分功能需要lua支持__

## 安装
- 使用vundle

  在vundle配置中加上`Plugin 'luzhlon/vim-utils'`，保存并重启vim，执行`:PluginInstall`

- 直接安装

  将文件直接解压到vim配置文件的目录里。一般是'~/.vim'

## 函数介绍
- utils#ToggleHeader()

  切换头(.h)文件和C(.c .cpp .cc)文件。

- utils#ToggleComment()

  切换当前行(或选中行)的注释状态，目前支持lua、python、vim、c、c++、java、javascript语言。</br>
  
  此功能__需要vim的lua支持__

- utils#QuitBuffer(force)

  退出当前的buffer(关闭当前打开的文件)但不关闭当前的窗口。force参数为非0时强制退出。

- utils#ToggleRNU()

  切换行号显示的相对行号状态。

- utils#QuickRun()

  快速保存并运行一个脚本文件，暂时支持lua、python脚本。对于vim脚本，将使用so命令加载。

## 键盘映射
例子：

```vim
" 使用F4键快速切换.c和.h文件
nmap <F4> :call utils#ToggleHeader()
" 使用F5键快速运行一个脚本
nmap <F5> :call utils#QuickRun()
```

需要使用哪个函数的功能就使用call命令调用哪个函数。
