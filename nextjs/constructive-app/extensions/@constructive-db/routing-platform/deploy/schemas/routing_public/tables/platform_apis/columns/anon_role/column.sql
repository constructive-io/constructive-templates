-- Deploy: schemas/routing_public/tables/platform_apis/columns/anon_role/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_apis/table


ALTER TABLE routing_public.platform_apis 
  ADD COLUMN anon_role text;