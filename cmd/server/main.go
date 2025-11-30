package main

import (
	"context"
	"log"
	"pulse-watch/internal/api"
	"pulse-watch/internal/config"
	"pulse-watch/internal/repository"

	"github.com/jackc/pgx/v5/pgxpool"
	"go.uber.org/zap"
)

func main() {
	// 1. Load Configuration
	cfg, err := config.LoadConfig(".")
	if err != nil {
		log.Fatalf("cannot load config: %v", err)
	}

	// 2. Initialize Logger (Zap)
	logger, _ := zap.NewProduction()
	defer logger.Sync()
	logger.Info("Starting PulseWatch Server...")

	// 3. Connect to Database
	connPool, err := pgxpool.New(context.Background(), cfg.DBSource)
	if err != nil {
		logger.Fatal("cannot connect to db", zap.Error(err))
	}
	defer connPool.Close()

	// 4. Create Store
	store := repository.New(connPool)

	// 5. Create Server
	server, err := api.NewServer(cfg, store)
	if err != nil {
		logger.Fatal("cannot create server", zap.Error(err))
	}

	// 6. Start Server
	logger.Info("Server listening", zap.String("address", cfg.ServerAddress))
	err = server.Start(cfg.ServerAddress)
	if err != nil {
		logger.Fatal("cannot start server", zap.Error(err))
	}
}

