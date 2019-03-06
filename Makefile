SERVICE=beacon

.PHONE: all build up down log

build:
	docker build -t elixir/$(SERVICE) .

up:
	docker run -d \
	       --name $(SERVICE) \
	       -e POSTGRES_USER=microaccounts_dev \
	       -e POSTGRES_PASSWORD=r783qjkldDsiu \
	       -e POSTGRES_DB=elixir_beacon_dev \
	       -p "9075:9075" \
	       -p "5432:5432" \
               elixir/$(SERVICE)

down:
	-docker kill $(SERVICE)
	docker rm $(SERVICE)

exec:
	@docker exec -it $(SERVICE) bash

log:
	@docker logs -f $(SERVICE)

