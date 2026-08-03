-- Deploy: schemas/routing_public/tables/rls_settings/columns/database_id/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/rls_settings/table


ALTER TABLE routing_public.rls_settings 
  ADD COLUMN database_id uuid;