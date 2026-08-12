-- Deploy: schemas/routing_public/tables/site_deep_links/indexes/site_deep_links_updated_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_deep_links/table
-- requires: schemas/routing_public/tables/site_deep_links/columns/updated_at/column


CREATE INDEX site_deep_links_updated_at_idx ON routing_public.site_deep_links (updated_at);