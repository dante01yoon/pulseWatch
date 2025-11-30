-- name: CreateService :one
INSERT INTO services (
  organization_id,
  name,
  description,
  health_check_url,
  check_interval_seconds,
  timeout_seconds,
  failure_threshold,
  owner_id
) VALUES (
  $1, $2, $3, $4, $5, $6, $7, $8
) RETURNING *;

-- name: GetService :one
SELECT * FROM services
WHERE id = $1 LIMIT 1;

-- name: ListServicesByOrganization :many
SELECT * FROM services
WHERE organization_id = $1
ORDER BY name;

-- name: UpdateService :one
UPDATE services
SET
  name = COALESCE(sqlc.narg(name), name),
  description = COALESCE(sqlc.narg(description), description),
  health_check_url = COALESCE(sqlc.narg(health_check_url), health_check_url),
  check_interval_seconds = COALESCE(sqlc.narg(check_interval_seconds), check_interval_seconds),
  timeout_seconds = COALESCE(sqlc.narg(timeout_seconds), timeout_seconds),
  failure_threshold = COALESCE(sqlc.narg(failure_threshold), failure_threshold),
  owner_id = COALESCE(sqlc.narg(owner_id), owner_id),
  is_paused = COALESCE(sqlc.narg(is_paused), is_paused),
  updated_at = now()
WHERE id = $1
RETURNING *;

-- name: DeleteService :exec
DELETE FROM services
WHERE id = $1;

