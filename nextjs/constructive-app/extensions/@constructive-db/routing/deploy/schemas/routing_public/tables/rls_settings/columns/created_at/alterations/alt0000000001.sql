-- Deploy: schemas/routing_public/tables/rls_settings/columns/created_at/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/rls_settings/table
-- requires: schemas/routing_public/tables/rls_settings/columns/created_at/column


ALTER TABLE routing_public.rls_settings 
  ALTER COLUMN created_at SET DEFAULT now();