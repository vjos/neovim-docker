# kill running container
docker-compose down

# handle command line args
while [[ $# -gt 0 ]]; do
	case $1 in
		-n|--no-cache)
			docker-compose build --no-cache
			BUILT=1
			shift
			;;
		-t|--terminal)
			NEWTERM=1
			shift
			;;
		-a|--attach)
			ATTACH=1
			shift
			;;
	esac
done

# rebuild with cache if not built without
if [ -z ${BUILT} ]; then
	docker-compose build
fi

# start the container
docker-compose up --detach

# attach in new terminal window
if [ -v NEWTERM ]; then
	${TERM} -e docker-compose exec neovim /bin/bash &
fi

# attach in current terminal window
if [ -v ATTACH ]; then
	docker-compose exec neovim /bin/bash
fi
