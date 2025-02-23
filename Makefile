up: docker-up
down: docker-down
restart: docker-down docker-up

docker-up: memory
	docker-compose up -d

docker-down:
	docker-compose down --remove-orphans

docker-down-clear:
	docker-compose down -v --remove-orphans

docker-pull:
	docker-compose pull

docker-build: memory
	docker-compose up --build -d

assets-install:
	docker-compose run --rm node yarn install
	docker-compose run --rm node npm rebuild node-sass

assets-dev:
	docker-compose run --rm node yarn run dev

assets-watch:
	docker-compose run --rm node yarn run watch

migrations:
	docker-compose run --rm php-cli php artisan migrate

test:
	docker-compose run --rm php-cli php vendor/bin/phpunit

queue:
	docker-compose run --rm php-cli php artisan queue:work

horizon:
	docker-compose run --rm php-cli php artisan horizon

horizon-pause:
	docker-compose run --rm php-cli php artisan horizon:pause

horizon-continue:
	docker-compose run --rm php-cli php artisan horizon:continue

horizon-terminate:
	docker-compose run --rm php-cli php artisan horizon:terminate

memory:
	sudo sysctl -w vm.max_map_count=262144
