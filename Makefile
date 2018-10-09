testnet-deploy:
	ln -s .env.testnet .env
	docker-machine use testnet-miningpool && \
		docker-compose up --build -d
	rm .env

local-testnet-deploy:
	ln -s .env.testnet .env
	docker-compose up --build -d
	rm .env

.PHONY: \
	testnet-deploy \
	local-testnet-deploy
