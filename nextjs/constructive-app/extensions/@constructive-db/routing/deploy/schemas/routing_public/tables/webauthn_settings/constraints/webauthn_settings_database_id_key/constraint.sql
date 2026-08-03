-- Deploy: schemas/routing_public/tables/webauthn_settings/constraints/webauthn_settings_database_id_key/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/webauthn_settings/table


ALTER TABLE routing_public.webauthn_settings 
  ADD CONSTRAINT webauthn_settings_database_id_key 
    UNIQUE (database_id);