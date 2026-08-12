-- Deploy: schemas/routing_public/tables/platform_sites/constraints/platform_sites_name_key/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_sites/table


ALTER TABLE routing_public.platform_sites 
  ADD CONSTRAINT platform_sites_name_key 
    UNIQUE (name);