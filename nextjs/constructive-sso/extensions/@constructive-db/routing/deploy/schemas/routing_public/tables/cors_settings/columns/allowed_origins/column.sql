-- Deploy: schemas/routing_public/tables/cors_settings/columns/allowed_origins/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/cors_settings/table


ALTER TABLE routing_public.cors_settings 
  ADD COLUMN allowed_origins text[];