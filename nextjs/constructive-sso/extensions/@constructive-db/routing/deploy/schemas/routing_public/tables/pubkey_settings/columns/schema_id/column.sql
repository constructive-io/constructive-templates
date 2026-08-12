-- Deploy: schemas/routing_public/tables/pubkey_settings/columns/schema_id/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/pubkey_settings/table


ALTER TABLE routing_public.pubkey_settings 
  ADD COLUMN schema_id uuid;