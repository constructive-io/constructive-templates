-- Deploy: schemas/routing_public/tables/platform_site_modules/indexes/platform_site_modules_updated_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_site_modules/table
-- requires: schemas/routing_public/tables/platform_site_modules/columns/updated_at/column


CREATE INDEX platform_site_modules_updated_at_idx ON routing_public.platform_site_modules (updated_at);