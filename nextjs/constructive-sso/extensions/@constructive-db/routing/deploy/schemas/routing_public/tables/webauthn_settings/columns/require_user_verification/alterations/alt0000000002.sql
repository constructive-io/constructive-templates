-- Deploy: schemas/routing_public/tables/webauthn_settings/columns/require_user_verification/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/webauthn_settings/table
-- requires: schemas/routing_public/tables/webauthn_settings/columns/require_user_verification/column


ALTER TABLE routing_public.webauthn_settings 
  ALTER COLUMN require_user_verification SET DEFAULT false;