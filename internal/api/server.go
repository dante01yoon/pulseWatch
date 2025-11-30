package api

import (
	"github.com/gin-gonic/gin"
	"pulse-watch/internal/config"
	"pulse-watch/internal/repository"
)

// Server serves HTTP requests for our service.
type Server struct {
	config config.Config
	store  *repository.Queries
	router *gin.Engine
}

// NewServer creates a new HTTP server and set up routing.
func NewServer(config config.Config, store *repository.Queries) (*Server, error) {
	server := &Server{
		config: config,
		store:  store,
	}

	server.setupRouter()
	return server, nil
}

func (server *Server) setupRouter() {
	router := gin.Default()

	router.GET("/health", func(ctx *gin.Context) {
		ctx.JSON(200, gin.H{"status": "ok"})
	})

	server.router = router
}

// Start runs the HTTP server on a specific address.
func (server *Server) Start(address string) error {
	return server.router.Run(address)
}

