FROM alpine:3.16.0

# generic dependencies
RUN apk update && apk add neovim neovim-doc curl git

# js deps required for coc
RUN apk add nodejs npm

# python deps 
RUN apk add python3 py3-pip
RUN python3 -m pip install --user --upgrade pynvim

# C# deps
RUN apk add --no-cache mono --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing && \
    apk add --no-cache --virtual=.build-dependencies ca-certificates && \
    cert-sync /etc/ssl/certs/ca-certificates.crt && \
    apk del .build-dependencies

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
	coc-sh\
	coc-html coc-htmlhint coc-emmet coc-json coc-prettier\
	coc-css coc-html-css-support"
RUN nvim -c "CocInstall -sync $CocExtensions" -c qa

