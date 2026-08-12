-- Deploy: schemas/myapp_store_public/views/app_internal_secrets/view
-- made with <3 @ constructive.io

-- requires: schemas/myapp_store_public/schema


CREATE VIEW myapp_store_public.app_internal_secrets WITH ( security_invoker = true ) AS SELECT
  id,
  name,
  realm,
  namespace_id,
  description,
  labels,
  annotations,
  created_at,
  updated_at,
  rotated_at,
  retired_at
FROM myapp_store_private.app_internal_secrets;

