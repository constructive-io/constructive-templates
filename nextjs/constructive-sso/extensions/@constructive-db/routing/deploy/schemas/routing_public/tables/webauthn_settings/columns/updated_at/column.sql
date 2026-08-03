-- Deploy: schemas/routing_public/tables/webauthn_settings/columns/updated_at/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/webauthn_settings/table


ALTER TABLE routing_public.webauthn_settings 
  ADD COLUMN updated_at timestamptz;