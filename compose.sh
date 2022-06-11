docker-compose down
docker-compose build --no-cache
docker-compose up --detach

alacritty --command docker-compose exec neovim /bin/sh
