# DragonTap — Infrastructure Docker

## Composition de l'équipe

- Frin Arthur
- Amozigh Jonas

## Stack technique

| Composant  | Technologie           | Service Compose |
|------------|-----------------------|-----------------|
| Base de données | PostgreSQL 16    | `cellar`        |
| Backend    | Java 25 / Spring Boot | `innkeeper`     |
| Frontend   | React / Vite + Nginx  | `board`         |
| Reverse proxy | Nginx stable-alpine | `gatekeeper`  |

## Prérequis

- Docker >= 24
- Docker Compose v2

## Lancer l'application

```bash
# 1. Copier les variables d'environnement
cp cellar/.env.example cellar/.env
# Éditer cellar/.env si nécessaire

# 2. Builder et démarrer tous les services
docker compose up -d --build

# 3. Vérifier que tout est démarré
docker compose ps
```

L'application est accessible sur **http://localhost**.

## Commandes utiles

```bash
# Logs d'un service
docker compose logs -f cellar
docker compose logs -f innkeeper

# Arrêter sans supprimer les volumes
docker compose down

# Arrêter et supprimer les données (reset complet)
docker compose down -v

# Reconstruire un seul service
docker compose build innkeeper
docker compose up -d innkeeper
```

## Architecture réseau

Tous les services sont dans le réseau interne `dragontap-net`.
Seul `gatekeeper` expose le port **80** vers l'hôte.

```
Browser
  │
  ▼ :80
gatekeeper (nginx)
  ├── /       → board:4182
  └── /api/   → innkeeper:4181
                    │
                    ▼
               cellar:5432 (postgres)
```

## Persistance des données

Le volume nommé `pgdata` assure la persistance de PostgreSQL entre les redémarrages.
