FROM ubuntu:22.10

# generic dependencies
RUN apt-get update
RUN apt-get install curl git -y

# install neovim
RUN apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen -y
RUN git clone https://github.com/neovim/neovim.git /tmp/neovim
WORKDIR /tmp/neovim
RUN make CMAKE_BUILD_TYPE=RelWithDebInfo
RUN make install
WORKDIR /

# js deps required for coc
RUN apt-get install nodejs npm -y

# python deps 
RUN apt-get install python3 python3-pip python3.10-venv -y
RUN python3 -m pip install --user --upgrade pynvim

# go deps
RUN apt-get install golang-go -y

# C# deps
RUN apt-get install dirmngr gnupg apt-transport-https ca-certificates software-properties-common -y
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
RUN apt-add-repository 'deb https://download.mono-project.com/repo/ubuntu stable-focal main'
RUN apt install mono-complete -y

# install config and packages
RUN curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# RUN curl -fLo ~/.config/nvim/init.vim --create-dirs \
#     https://raw.githubusercontent.com/vjos/configs/master/nvim/init.vim
COPY nvim/ /nvim-conf/
RUN mkdir -p $HOME/.config/nvim/
RUN cp -r /nvim-conf/* $HOME/.config/nvim/
RUN nvim -c PlugInstall -c qa

# install language server extensions for coc
# better way is to use the json file to handle extensions but haven't done this yet
ARG CocExtensions="coc-snippets\
	coc-jedi\
	coc-go\
	coc-sh\
	coc-html coc-htmlhint coc-emmet coc-json coc-prettier\
	coc-css coc-html-css-support"
RUN nvim -c "CocInstall -sync $CocExtensions" -c qa

