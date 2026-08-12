-- Deploy: schemas/routing_public/tables/platform_cors_settings/columns/allowed_origins/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_cors_settings/table
-- requires: schemas/routing_public/tables/platform_cors_settings/columns/allowed_origins/column


ALTER TABLE routing_public.platform_cors_settings 
  ALTER COLUMN allowed_origins SET NOT NULL;