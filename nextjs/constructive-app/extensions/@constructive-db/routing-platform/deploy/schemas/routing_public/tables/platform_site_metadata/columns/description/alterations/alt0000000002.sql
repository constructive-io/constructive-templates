-- Deploy: schemas/routing_public/tables/platform_site_metadata/columns/description/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_site_metadata/table
-- requires: schemas/routing_public/tables/platform_site_metadata/columns/description/column


ALTER TABLE routing_public.platform_site_metadata 
  ADD CONSTRAINT platform_site_metadata_description_chk 
    CHECK (character_length(description) <= 120);