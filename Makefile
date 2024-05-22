kong-postgres:
	COMPOSE_PROFILES=database KONG_DATABASE=postgres docker-compose up -d

kong-dbless:
	docker-compose up -d

clean:
	docker-compose kill
	docker-compose rm -f

kong-export:
	deck gateway dump -o config/kong.yaml --yes

kong-diff:
	deck gateway diff config/kong.yaml

kong-import:
	deck gateway sync config/kong.yaml