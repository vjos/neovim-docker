# Neovim Docker
An attempt to dockerise my Neovim setup, since it hurts to install plugin
dependencies on a host machine. 

## Usage
- Install docker with docker-compose
- Run the compose script to build and start the container: `./compose.sh`
- Attach to the container's shell: `docker-compose exec neovim /bin/sh`
- Note that some coc-extensions, such as coc-jedi (for python), will handle
  language server installation themselves. In these cases, you may have to
  enter some commands when prompted.

## Configuration
- At present, the Dockerfile curls my init.vim file. This can be changed to any
  init.vim. Note that github imposes a 5 minute cache on requesting raw files.
  In future I will change this line and clone my whole .config/nvim directory
  instead, which will be necessary for some lua plugins.
- You can add language servers by installing coc extensions. You can do this at
  build time by adding to the `CocInstall` command in the Dockerfile. See
  [here](https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions#implemented-coc-extensions)
  for a list of implemented coc extensions. 

