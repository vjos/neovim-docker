FROM alpine:3.16.0

# generic dependencies
RUN apk update && apk add neovim neovim-doc curl git

# required for coc
RUN apk add nodejs npm

# required for any python completion
RUN apk add python3

# install config and packages
RUN curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
RUN curl -fLo ~/.config/nvim/init.vim --create-dirs \
    https://raw.githubusercontent.com/vjos/configs/master/nvim/init.vim
RUN nvim -c PlugInstall -c qa

# install language server extensions for coc
# better way is to use the json file to handle extensions but haven't done this yet
RUN nvim -c "CocInstall -sync coc-json coc-jedi" -c qa

