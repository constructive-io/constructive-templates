-- Deploy: schemas/routing_public/tables/platform_site_themes/indexes/platform_site_themes_site_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_site_themes/table
-- requires: schemas/routing_public/tables/platform_site_themes/columns/site_id/column


CREATE INDEX platform_site_themes_site_id_idx ON routing_public.platform_site_themes (site_id);