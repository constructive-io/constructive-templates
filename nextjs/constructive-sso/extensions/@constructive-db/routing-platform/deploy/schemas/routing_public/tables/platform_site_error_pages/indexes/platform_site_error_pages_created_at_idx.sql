-- Deploy: schemas/routing_public/tables/platform_site_error_pages/indexes/platform_site_error_pages_created_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_site_error_pages/table
-- requires: schemas/routing_public/tables/platform_site_error_pages/columns/created_at/column


CREATE INDEX platform_site_error_pages_created_at_idx ON routing_public.platform_site_error_pages (created_at);