-- Deploy: schemas/routing_public/tables/site_modules/indexes/site_modules_created_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_modules/table
-- requires: schemas/routing_public/tables/site_modules/columns/created_at/column


CREATE INDEX site_modules_created_at_idx ON routing_public.site_modules (created_at);