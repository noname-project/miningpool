testnet-deploy:
	ln -s .env.testnet .env
	cp miningcore/minigcore.testnet.config.json \
		miningcore/miningcore.config.json

	docker-machine use testnet-miningpool && \
		docker-compose up --build -d

	rm .env
	rm miningcore/miningcore.config.json

local-testnet-deploy:
	ln -s .env.testnet .env
	cp miningcore/minigcore.local.testnet.config.json \
		miningcore/miningcore.config.json

	docker-compose up --build -d

	rm .env
	rm miningcore/miningcore.config.json

.PHONY: \
	testnet-deploy \
	local-testnet-deploy
