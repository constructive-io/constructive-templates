-- Deploy: schemas/routing_public/tables/platform_cors_settings/columns/id/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_cors_settings/table


ALTER TABLE routing_public.platform_cors_settings 
  ADD COLUMN id uuid;