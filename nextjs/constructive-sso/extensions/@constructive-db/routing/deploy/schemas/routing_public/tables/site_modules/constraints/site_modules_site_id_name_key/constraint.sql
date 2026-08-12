-- Deploy: schemas/routing_public/tables/site_modules/constraints/site_modules_site_id_name_key/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_modules/table


ALTER TABLE routing_public.site_modules 
  ADD CONSTRAINT site_modules_site_id_name_key 
    UNIQUE (site_id, name);