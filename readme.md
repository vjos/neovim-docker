# Neovim Docker
An attempt to dockerise my Neovim setup, since it hurts to install plugin
dependencies on a host machine. 

Runs inside an Arch Linux container, which I found to have the most
dependencies in its repositories (compared to Ubuntu and Alpine).

## Usage
- Install docker with docker-compose
- Run the compose script to build and start the container: `./compose.sh`
- Note that some coc-extensions, such as coc-jedi (for python), will handle
  language server installation themselves. In these cases, you may have to
  enter some commands when prompted.

## Configuration
- The nvim folder is copied to ~/.config/nvim in the container. This contains
  all the config files for neovim.
- You can add language servers by installing coc extensions. You can do this at
  build time by adding to the `CocInstall` command in the Dockerfile. See
  [here](https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions#implemented-coc-extensions)
  for a list of implemented coc extensions. 

## Usage
Start neovim with `nvim`. Open files: `nvim file.a file.b ...`.
### Vim
Learn vim controls with vimtutor. Access the nvim version: `nvim -c Tutor`.
You can read more in the user manual: `nvim -c h user-manual`.
### Core Plugins
There are several main plugins I use. These add extra motions and features to
vim:
- [vim-commentary](https://github.com/tpope/vim-commentary#readme) for
  toggleable commenting
- [vim-surround](https://github.com/tpope/vim-surround#readme) adding motions
  for surroundings such as quotes and parentheses
- [auto-pairs](https://github.com/jiangmiao/auto-pairs#readme) to gracefully
  handle matched surroundings
### Completion
Coc is a completion ecosystem. See **Configuration** to add more extensions.
Use <C-n> and <C-p> to navigate completion menus, and <RETURN>/<TAB> to choose
a suggestion or expand a snippet. 
See the Dockerfile for preconfigured extensions.
