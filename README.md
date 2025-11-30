# PulseWatch

PulseWatch is a mini SRE platform designed to check the availability of multiple services periodically, detect outages, and manage incidents through their lifecycle (Creation -> Response -> Retrospective).

## 🚀 Features

- **Organization & Service Management**: Manage multiple services under an organization.
- **Health Check Engine**: Automated HTTP health checks with customizable intervals and timeouts.
- **Incident Management**: Automated incident creation on failure, with lifecycle tracking.
- **Notifications**: Alerts via Email or Webhook (Slack).
- **Dashboard**: Real-time view of service health and incident timelines.

## 🛠 Tech Stack

- **Backend**: Go (Gin), PostgreSQL, Redis, sqlc
- **Frontend**: Next.js (App Router), TypeScript, Tailwind CSS, TanStack Query
- **Infrastructure**: Docker Compose

## 🏃 Getting Started

### Prerequisites
- Go 1.21+
- Docker & Docker Compose
- Node.js 18+ (for Frontend)

### Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/pulse-watch.git
   cd pulse-watch
   ```

2. **Environment Setup**
   Follow the instructions in [SETUP.md](SETUP.md) to configure your environment variables.

3. **Run Backend (Dev)**
   ```bash
   make dev-up    # Start DB & Redis
   make migrateup # Apply DB migrations
   make server    # Start API server
   # or `air` for live reload
   ```

4. **Run Frontend (Dev)**
   *(Coming Soon)*

## 📖 Documentation

We follow a **Memory Bank** approach for documentation. Please check the `.memory/` directory for detailed project information:

- **[Project Progress](.memory/project_progress.md)**: Current status and roadmap.
- **[Architecture](.memory/architecture.md)**: System design and component interaction.
- **[Tech Plan](.memory/tech_plan.md)**: Technical implementation details.
- **[PRD](.memory/prd.md)**: Product Requirements Document.

## 🤝 Contributing

Please refer to `.cursorrules/go-backend.mdc` for coding standards and conventions before contributing.
