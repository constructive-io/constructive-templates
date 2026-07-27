-- Deploy: schemas/myapp_auth_public/views/identity_providers/view
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema


CREATE VIEW myapp_auth_public.identity_providers WITH ( security_invoker = true ) AS SELECT
  slug,
  kind,
  display_name,
  enabled
FROM myapp_auth_private.identity_providers;

