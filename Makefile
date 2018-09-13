include .env



deploy:

	# Deploy miningcore config.
	sudo mkdir -p ${HOST_VOLUMES_ROOT}/miningcore
	sudo cp miningcore/config.json ${HOST_VOLUMES_ROOT}/miningcore/

	# Deploy dockers.
	docker-compose up --build -d



miningcore-restart:

	# Restart miningcore to apply config changes.
	# NOT WORKING PROPERLY, bug report required.
	#docker restart miningcore

	# We are killing miningcore because it has
	# graceful shutdown bug: it have to support
	# SIGINT but don't.
	docker kill miningcore
	docker start miningcore
