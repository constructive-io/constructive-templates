-- Deploy: schemas/routing_public/tables/sites/columns/installation_member_slug/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/sites/table


ALTER TABLE routing_public.sites 
  ADD COLUMN installation_member_slug text;