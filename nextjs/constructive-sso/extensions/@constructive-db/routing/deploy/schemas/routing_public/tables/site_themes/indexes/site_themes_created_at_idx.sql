-- Deploy: schemas/routing_public/tables/site_themes/indexes/site_themes_created_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_themes/table
-- requires: schemas/routing_public/tables/site_themes/columns/created_at/column


CREATE INDEX site_themes_created_at_idx ON routing_public.site_themes (created_at);