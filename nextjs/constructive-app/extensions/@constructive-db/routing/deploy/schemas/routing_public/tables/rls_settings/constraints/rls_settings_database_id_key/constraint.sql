-- Deploy: schemas/routing_public/tables/rls_settings/constraints/rls_settings_database_id_key/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/rls_settings/table


ALTER TABLE routing_public.rls_settings 
  ADD CONSTRAINT rls_settings_database_id_key 
    UNIQUE (database_id);