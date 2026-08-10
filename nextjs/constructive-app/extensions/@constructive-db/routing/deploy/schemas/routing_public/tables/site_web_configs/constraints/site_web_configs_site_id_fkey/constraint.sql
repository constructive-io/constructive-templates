-- Deploy: schemas/routing_public/tables/site_web_configs/constraints/site_web_configs_site_id_fkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/sites/table
-- requires: schemas/routing_public/tables/site_web_configs/table


ALTER TABLE routing_public.site_web_configs 
  ADD CONSTRAINT site_web_configs_site_id_fkey
    FOREIGN KEY(site_id)
    REFERENCES routing_public.sites (id)
    ON DELETE CASCADE;