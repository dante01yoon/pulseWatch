DB_URL=postgresql://postgres:postgres@localhost:5432/pulsewatch?sslmode=disable

.PHONY: network postgres createdb dropdb migrateup migratedown sqlc test server mock dev-up dev-down frontend init

network:
	docker network create pulse-network || true

postgres:
	docker-compose up -d postgres

redis:
	docker-compose up -d redis

createdb:
	docker exec -it pulse-watch-db createdb --username=postgres --owner=postgres pulsewatch

dropdb:
	docker exec -it pulse-watch-db dropdb --username=postgres pulsewatch

migrateup:
	migrate -path db/migration -database "$(DB_URL)" -verbose up

migratedown:
	migrate -path db/migration -database "$(DB_URL)" -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

server:
	go run cmd/server/main.go

mock:
	mockgen -package mockdb -destination internal/repository/mock/store.go pulse-watch/internal/repository Store

dev-up:
	docker-compose up -d

dev-down:
	docker-compose down

frontend:
	cd frontend && npm run dev

init: dev-up
	sleep 3
	make createdb || true
	make migrateup
