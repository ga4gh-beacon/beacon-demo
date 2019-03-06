SERVICE=beacon

.PHONE: all .env build up down ps

build:
	docker build -t elixir/beacon .

.env:
	@echo "COMPOSE_PROJECT_NAME=beacon" > $@
	@echo "COMPOSE_FILE=beacon.yml" >> $@
	@echo "#COMPOSE_IGNORE_ORPHANS=1" >> $@

up:.env
	@docker-compose up -d

down:.env
	@docker-compose down -v

ps:.env
	@docker-compose ps

exec:
	@docker-compose exec $(SERVICE) bash

log:
	@docker-compose logs -f $(SERVICE)

