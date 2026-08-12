-- Deploy: schemas/routing_public/tables/platform_apis/columns/created_at/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_apis/table


ALTER TABLE routing_public.platform_apis 
  ADD COLUMN created_at timestamptz;