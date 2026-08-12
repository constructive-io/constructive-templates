-- Deploy: schemas/myapp_user_identifiers_public/views/user_connected_accounts/view
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema


CREATE VIEW myapp_user_identifiers_public.user_connected_accounts WITH ( security_invoker = true ) AS SELECT
  id,
  owner_id,
  service,
  identifier,
  details,
  is_verified,
  created_at,
  updated_at
FROM myapp_user_identifiers_private.connected_accounts
WHERE
  owner_id = ((SELECT jwt_public.current_principal_id()));

