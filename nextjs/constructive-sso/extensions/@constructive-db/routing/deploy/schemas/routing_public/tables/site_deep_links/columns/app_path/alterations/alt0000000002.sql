-- Deploy: schemas/routing_public/tables/site_deep_links/columns/app_path/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_deep_links/columns/app_path/column


COMMENT ON COLUMN routing_public.site_deep_links.app_path IS 'In-app route the installed app opens when it intercepts this link';