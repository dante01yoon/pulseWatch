-- name: CreateOrganization :one
INSERT INTO organizations (
  name,
  slug
) VALUES (
  $1, $2
) RETURNING *;

-- name: GetOrganization :one
SELECT * FROM organizations
WHERE id = $1 LIMIT 1;

-- name: ListOrganizationsByUser :many
SELECT o.* FROM organizations o
JOIN organization_members om ON o.id = om.organization_id
WHERE om.user_id = $1
ORDER BY o.created_at DESC;

-- name: AddUserToOrganization :one
INSERT INTO organization_members (
  organization_id,
  user_id,
  role
) VALUES (
  $1, $2, $3
) RETURNING *;

