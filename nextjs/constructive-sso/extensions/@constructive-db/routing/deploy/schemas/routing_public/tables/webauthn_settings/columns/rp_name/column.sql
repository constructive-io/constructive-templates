-- Deploy: schemas/routing_public/tables/webauthn_settings/columns/rp_name/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/webauthn_settings/table


ALTER TABLE routing_public.webauthn_settings 
  ADD COLUMN rp_name text;