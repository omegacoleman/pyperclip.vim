vim9script

var plugin_root_dir = fnamemodify(resolve(expand('<sfile>:p')), ':h')

py3 << EOF
import sys
from os.path import normpath, join
import vim
plugin_root_dir = vim.eval('plugin_root_dir')
python_root_dir = normpath(join(plugin_root_dir, '..', 'python', 'pyperclip', 'src'))
sys.path.insert(0, python_root_dir)

from pyperclip import copy, paste
EOF

def g:ClipGetText(): string
    return py3eval('paste()')
enddef

var py_tmp: string
def g:ClipSetText(text: string): void
    py_tmp = text
    py3eval('copy(vim.eval("py_tmp"))')
enddef

def g:ClipCut(): void
    var oldreg: string = getreg('"')
    norm gv""d
    g:ClipSetText(getreg('"'))
    setreg('"', oldreg)
enddef

def g:ClipCopy(): void
    var oldreg: string = getreg('"')
    norm gv""y
    g:ClipSetText(getreg('"'))
    setreg('"', oldreg)
enddef

if !exists("g:clip_no_maps")
    g:clip_no_maps = 0
endif

if g:clip_no_maps == 0
	vnoremap <C-x> :<C-u>call ClipCut()<cr>
	vnoremap <C-c> :<C-u>call ClipCopy()<cr>
	inoremap <C-v> <C-r>=ClipGetText()<cr>
endif

