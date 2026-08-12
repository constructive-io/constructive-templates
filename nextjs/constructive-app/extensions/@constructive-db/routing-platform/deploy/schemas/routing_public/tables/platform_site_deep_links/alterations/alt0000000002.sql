-- Deploy: schemas/routing_public/tables/platform_site_deep_links/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_site_deep_links/table


COMMENT ON TABLE routing_public.platform_site_deep_links IS 'Named, retargetable deep links owned by a site surface (served at the deep-link path prefix; app interception via site_app_links)';