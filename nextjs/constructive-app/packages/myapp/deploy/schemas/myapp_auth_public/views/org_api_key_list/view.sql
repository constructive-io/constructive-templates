-- Deploy: schemas/myapp_auth_public/views/org_api_key_list/view
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema


CREATE VIEW myapp_auth_public.org_api_key_list WITH ( security_invoker = true ) AS SELECT
  sc.id,
  sc.key_id,
  sc.name,
  sc.principal_id,
  sc.org_id,
  sc.expires_at,
  sc.revoked_at,
  sc.last_used_at,
  sc.mfa_level,
  sc.access_level,
  sc.created_at,
  sc.updated_at
FROM myapp_auth_private.session_credentials AS sc
WHERE
  sc.kind = 'api_key' AND sc.org_id IS NOT NULL;

