-- name: CreateUser :one
INSERT INTO users (
  email,
  hashed_password,
  full_name
) VALUES (
  $1, $2, $3
) RETURNING *;

-- name: GetUserByEmail :one
SELECT * FROM users
WHERE email = $1 LIMIT 1;

-- name: GetUser :one
SELECT * FROM users
WHERE id = $1 LIMIT 1;

-- name: UpdateUser :one
UPDATE users
SET 
  full_name = COALESCE(sqlc.narg(full_name), full_name),
  hashed_password = COALESCE(sqlc.narg(hashed_password), hashed_password),
  updated_at = now()
WHERE id = $1
RETURNING *;

