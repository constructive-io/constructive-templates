-- Deploy: schemas/routing_public/tables/pubkey_settings/constraints/pubkey_settings_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/pubkey_settings/table


ALTER TABLE routing_public.pubkey_settings 
  ADD CONSTRAINT pubkey_settings_pkey PRIMARY KEY (id);