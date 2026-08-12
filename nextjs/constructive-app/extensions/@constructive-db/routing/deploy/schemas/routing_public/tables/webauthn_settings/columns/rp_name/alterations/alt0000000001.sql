-- Deploy: schemas/routing_public/tables/webauthn_settings/columns/rp_name/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/webauthn_settings/table
-- requires: schemas/routing_public/tables/webauthn_settings/columns/rp_name/column


ALTER TABLE routing_public.webauthn_settings 
  ALTER COLUMN rp_name SET NOT NULL;