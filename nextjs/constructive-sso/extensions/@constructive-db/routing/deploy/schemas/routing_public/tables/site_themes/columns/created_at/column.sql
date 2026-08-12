-- Deploy: schemas/routing_public/tables/site_themes/columns/created_at/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_themes/table


ALTER TABLE routing_public.site_themes 
  ADD COLUMN created_at timestamptz;