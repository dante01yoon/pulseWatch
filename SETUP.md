# Development Setup

## Environment Variables

Create a `.env` file in the root directory with the following content:

```env
# Database
DB_DRIVER=postgres
DB_SOURCE=postgresql://postgres:postgres@localhost:5432/pulsewatch?sslmode=disable
DB_USER=postgres
DB_PASSWORD=postgres
DB_NAME=pulsewatch
DB_PORT=5432

# Redis
REDIS_ADDR=localhost:6379
REDIS_PASSWORD=
REDIS_DB=0
REDIS_PORT=6379

# Server
SERVER_ADDRESS=0.0.0.0:8080
GIN_MODE=debug

# Worker
WORKER_INTERVAL=10s
```

## Docker Environment

Start the database and redis containers:

```bash
make dev-up
```

## Database Migration

1. Install `migrate` tool (if not installed).
2. Run migrations:

```bash
make migrateup
```

## Code Generation (sqlc)

To generate Go code from SQL queries:

```bash
make sqlc
```

## Running the Server

To run with live reload (requires `air`):

```bash
air
```

Or standard Go run:

```bash
make server
```

