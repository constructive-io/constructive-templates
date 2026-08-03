-- Deploy: schemas/routing_public/tables/rls_settings/columns/authenticate_schema_id/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/rls_settings/table


ALTER TABLE routing_public.rls_settings 
  ADD COLUMN authenticate_schema_id uuid;