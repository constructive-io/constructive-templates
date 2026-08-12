-- Deploy: schemas/routing_public/tables/pubkey_settings/constraints/pubkey_settings_database_id_key/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/pubkey_settings/table


ALTER TABLE routing_public.pubkey_settings 
  ADD CONSTRAINT pubkey_settings_database_id_key 
    UNIQUE (database_id);