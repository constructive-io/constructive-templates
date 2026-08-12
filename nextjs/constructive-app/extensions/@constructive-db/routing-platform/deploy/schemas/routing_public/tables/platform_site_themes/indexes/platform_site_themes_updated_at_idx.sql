-- Deploy: schemas/routing_public/tables/platform_site_themes/indexes/platform_site_themes_updated_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_site_themes/table
-- requires: schemas/routing_public/tables/platform_site_themes/columns/updated_at/column


CREATE INDEX platform_site_themes_updated_at_idx ON routing_public.platform_site_themes (updated_at);