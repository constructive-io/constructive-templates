-- Deploy: schemas/routing_public/tables/cors_settings/columns/id/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/cors_settings/table


ALTER TABLE routing_public.cors_settings 
  ADD COLUMN id uuid;