-- Deploy: schemas/routing_public/tables/site_error_pages/indexes/site_error_pages_created_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_error_pages/table
-- requires: schemas/routing_public/tables/site_error_pages/columns/created_at/column


CREATE INDEX site_error_pages_created_at_idx ON routing_public.site_error_pages (created_at);