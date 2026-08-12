-- Deploy: schemas/routing_public/tables/platform_apis/columns/role_name/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_apis/table


ALTER TABLE routing_public.platform_apis 
  ADD COLUMN role_name text;