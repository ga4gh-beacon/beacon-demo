SERVICE=beacon

.PHONE: all .env build up down ps

build:
	docker build -t elixir/beacon .

up:
	docker run -d \
	       --name $(SERVICE) \
	       -e POSTGRES_USER=microaccounts_dev \
	       -e POSTGRES_PASSWORD=r783qjkldDsiu \
	       -e POSTGRES_DB=elixir_beacon_dev \
	       -p "9075:9075" \
	       -p "5432:5432" \
               elixir/beacon

down:
	-docker kill $(SERVICE)
	docker rm $(SERVICE)
	docker volume prune

exec:
	@docker exec -it $(SERVICE) bash

log:
	@docker logs -f $(SERVICE)

