-- Deploy: schemas/routing_public/tables/site_modules/columns/updated_at/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_modules/table


ALTER TABLE routing_public.site_modules 
  ADD COLUMN updated_at timestamptz;