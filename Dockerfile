FROM archlinux:latest 

# generic dependencies
RUN pacman -Syu --noconfirm
RUN pacman -S curl git neovim --noconfirm

# js deps required for coc
RUN pacman -S nodejs npm --noconfirm

# python deps 
RUN pacman -S python python-pip --noconfirm 
RUN python -m pip install --user --upgrade pynvim

# go deps
RUN pacman -S go --noconfirm

# C# deps
RUN pacman -S mono mono-msbuild --noconfirm

# install plug.vim 
RUN curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# copy over the config files
COPY nvim/ /nvim-conf/
RUN mkdir -p $HOME/.config/nvim/
RUN cp -r /nvim-conf/* $HOME/.config/nvim/
RUN nvim -c PlugInstall -c qa

# install language server extensions for coc
# better way is to use coc-settings.json file to handle extensions but haven't done this yet
ARG CocExtensions="coc-snippets\
	coc-jedi\
	coc-go\
	coc-sh\
	coc-html coc-htmlhint coc-emmet coc-json coc-prettier\
	coc-css coc-html-css-support"
RUN nvim -c "CocInstall -sync $CocExtensions" -c qa

