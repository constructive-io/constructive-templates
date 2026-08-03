-- Deploy: schemas/routing_public/tables/api_settings/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/api_settings/table


ALTER TABLE routing_public.api_settings 
  DISABLE ROW LEVEL SECURITY;