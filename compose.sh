docker-compose down

if [ -z "$1" ]
then
	docker-compose build
elif [ "$1" = "no-cache" ]
then
	docker-compose build --no-cache
else
	echo "Unknown argument!"
	exit 1
fi

docker-compose up --detach

${TERM} -e docker-compose exec neovim /bin/bash &
