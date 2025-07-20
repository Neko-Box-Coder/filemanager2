# Filemanager Plugin

> This is a fork from https://codeberg.org/micro-plugins/filemanager2
> and will continue to be maintained as much as possible
> All credits and previous efforts goes to [Nicolai Søborg](https://github.com/NicolaiSoeborg), 
[ryo-inagaki](https://github.com/ryo-inagaki) and [taconi](https://github.com/taconi)

A simple plugin that allows for easy navigation of a file tree.

This plugin contains the same functionality as 
[filemanager](https://github.com/micro-editor/updated-plugins/tree/master/filemanager-plugin), 
but with the commands 'rename', 'touch' and 'mkdir' working in micro v2. 
The adjustment of these commands was done by [Ryo Inagaki](https://github.com/ryo-inagaki/) and 
there is already a [Pull Request](https://github.com/micro-editor/updated-plugins/pull/10) 
however, PR's are not accepted for a while (there is an 
[issue](https://github.com/micro-editor/plugin-channel/issues/74) on this subject). 
This repository was created to make available the commands working, as soon as the pull request 
is accepted, this repository will be archived and deleted after a while.

![Example picture](./assets/example.jpg?raw=true "Example")

If [nerd fonts](https://www.nerdfonts.com) is installed and options `filemanager2.nerdfonts` is `true`

![Example picture icons](./assets/example_icons.png?raw=true "Example")

## Installation

### Settings
Add this repo as a **pluginrepos** option in the **~/.config/micro/settings.json** file 
(it is necessary to restart the micro after this change):
```json
{
  "pluginrepos": [
      "https://raw.githubusercontent.com/Neko-Box-Coder/filemanager2/main/repo.json"
  ]
}
```

### Install

Run in your shell:
```sh
micro -plugin install filemanager2
```
or press `Ctrl-e` in micro and run this (and restart micro afterwards):
```
> plugin install filemanager2
```

## Basics

The top line always has the current directory's path to show you where you are.\
The `..` near the top is used to move back a directory, from your current position.

All directories have a `/` added to the end of it, and are syntax-highlighted as a `special` character.\

If the directory is expanded, there will be a `+` to the left of it. 
If it is collapsed there will be a `-` instead.

**NOTE:** If you change files without using the plugin, it can't know what you did. 
The only fix is to close and open the tree.

### Options

| Option                       | Purpose                                                      | Default |
| :--------------------------- | :----------------------------------------------------------- | :------ |
| `filemanager2.showdotfiles`  | Show dotfiles (hidden if false)                              | `true`  |
| `filemanager2.showignored`   | Show gitignore'd files (hidden if false)                     | `true`  |
| `filemanager2.compressparent`| Collapse the parent dir when left is pressed on a child file | `true`  |
| `filemanager2.foldersfirst`  | Sorts folders above any files                                | `true`  |
| `filemanager2.openonstart`   | Automatically open the file tree when starting Micro         | `false` |
| `filemanager2.nerdfonts`     | Use nerd fonts icons                                         | `false` |
| `filemanager2.showcurrent`   | Show and expand to current file in tree                      | `true`  |
| `filemanager2.relativepath`  | Use relative paths when possible                             | `true`  |
| `filemanager2.newtab`        | Open files in new tabs instead of splits                     | `true`  |
| `filemanager2.treewidth`     | Default tree width percent                                   | `30`    |
| `filemanager2.lengthfactor`  | Multiplier on tree width depending on how long the line is   | `0.3`   |

In addition to this, you can also get the file icon in the status bar by calling `filemanager2.FileIcon`, 
for example

```json
"statusformatl": "$(filemanager2.FileIcon) $(filename)$(modified)",
```


### Commands and Keybindings

The keybindings below are the equivalent to Micro's defaults, and not actually set by the plugin. 
If you've changed any of those keybindings, then that key is used instead.

If you want to 
[keybind](https://github.com/zyedidia/micro/blob/master/runtime/help/keybindings.md#rebinding-keys) 
any of the operations/commands, bind to the labeled API in the table below.

| Command  | Keybinding(s)              | What it does                                                                                | API for `bindings.json`               |
| :------- | :------------------------- | :------------------------------------------------------------------------------------------ | :------------------------------------ |
| `tree`   | -                          | Open/close the tree, or moves to the tree to current tab if opened in different tab         | `filemanager2.toggle_tree`             |
| -        | <kbd>Tab</kbd> & MouseLeft | Open a file, or go into the directory. Goes back a dir if on `..`                           | `filemanager2.try_open_at_cursor`      |
| -        | <kbd>→</kbd>               | Expand directory in tree listing                                                            | `filemanager2.uncompress_at_cursor`    |
| -        | <kbd>←</kbd>               | Collapse directory listing                                                                  | `filemanager2.compress_at_cursor`      |
| -        | <kbd>Shift ⬆</kbd>         | Go to the target's parent directory                                                         | `filemanager2.goto_parent_dir`         |
| -        | <kbd>Alt Shift {</kbd>     | Jump to the previous directory in the view                                                  | `filemanager2.goto_next_dir`           |
| -        | <kbd>Alt Shift }</kbd>     | Jump to the next directory in the view                                                      | `filemanager2.goto_prev_dir`           |
| `rm`     | -                          | Prompt to delete the target file/directory your cursor is on                                | `filemanager2.prompt_delete_at_cursor` |
| `rename` | -                          | Rename the file/directory your cursor is on, using the passed name                          | `filemanager2.rename_at_cursor`        |
| `touch`  | -                          | Make a new file under/into the file/directory your cursor is on, using the passed name      | `filemanager2.new_file`                |
| `mkdir`  | -                          | Make a new directory under/into the file/directory your cursor is on, using the passed name | `filemanager2.new_dir`                 |

#### Notes

- `rename`, `touch`, and `mkdir` require a name to be passed when calling.\
  Example: `rename newnamehere`, `touch filenamehere`, `mkdir dirnamehere`.\
  If the passed name already exists in the current dir, it will cancel instead of overwriting (for safety).

- The <kbd>Ctrl w</kbd> keybinding is to switch which buffer your cursor is on.\
  This isn't specific to the plugin, it's just part of Micro, but many people seem to not know this.
