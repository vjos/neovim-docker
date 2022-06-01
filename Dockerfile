FROM alpine:3.16.0

RUN apk update && apk add neovim curl git

RUN curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
RUN curl -fLo ~/.config/nvim/init.vim --create-dirs \
    https://raw.githubusercontent.com/vjos/configs/master/nvim/init.vim    

RUN nvim -c PlugInstall -c qa
