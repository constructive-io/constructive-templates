-- Deploy: schemas/routing_public/tables/site_deep_links/columns/web_path/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_deep_links/columns/web_path/column


COMMENT ON COLUMN routing_public.site_deep_links.web_path IS 'Web fallback path on this site (e.g. /pricing) when no app intercepts';