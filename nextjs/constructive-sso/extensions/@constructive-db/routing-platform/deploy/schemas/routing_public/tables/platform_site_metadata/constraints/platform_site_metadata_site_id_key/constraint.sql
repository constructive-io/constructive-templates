-- Deploy: schemas/routing_public/tables/platform_site_metadata/constraints/platform_site_metadata_site_id_key/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_site_metadata/table


ALTER TABLE routing_public.platform_site_metadata 
  ADD CONSTRAINT platform_site_metadata_site_id_key 
    UNIQUE (site_id);