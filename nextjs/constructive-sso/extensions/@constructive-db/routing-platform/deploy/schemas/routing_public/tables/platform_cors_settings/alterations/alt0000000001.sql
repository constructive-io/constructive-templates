-- Deploy: schemas/routing_public/tables/platform_cors_settings/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_cors_settings/table


ALTER TABLE routing_public.platform_cors_settings 
  DISABLE ROW LEVEL SECURITY;