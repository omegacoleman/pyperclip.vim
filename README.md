# pyperclip.vim

a simplistic plugin for using clipboard in vim9

providing vim9scrpt wrap up for [pyperclip](https://github.com/asweigart/pyperclip)

## requirements

* vim9script
* vim compiled with python3

## usage

press `<C-x>` in visual mode to cut

press `<C-c>` in visual mode to copy

press `<C-v>` in insert mode to paste

## interface

### public functions

#### `ClipGetText(): string`

returns whatever is in the clipboard

#### `ClipSetText(text: string): void`

sets clipboard data to the given string

#### `ClipCopy(): void`

copies the last-selected text in VISUAL mode

#### `ClipCut(): void`

cuts the last-selected text in VISUAL mode

### disable default keymaps

```vimscript
g:clip_no_maps = "default"
```

## brief

I have decided to switch from neovim back to vim9 a few months ago, one of things I missed the most is that neovim uses external toolsets to handle clipboard (what they call `providers`), so that it's not broken when using wayland.

Though, with that said, some of existing vimscript may have performance issues -- they expect the registers to be fast, but now an external tool is spawned everytime they read or write the register.

This plugin sloves both of the problems : the clipboard now have nothing to do with registers. They're basically a set of apis you use when you explicitly want to access the clipboard, which by default is binded to the hotkeys desktop users most used to -- Ctrl-X, Ctrl-V, and Ctrl-V. The python library pyperclip handles external tools perfectly.

