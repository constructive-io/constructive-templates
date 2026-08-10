-- Deploy: schemas/routing_public/tables/platform_site_app_links/columns/sha256_cert_fingerprints/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_site_app_links/table


ALTER TABLE routing_public.platform_site_app_links 
  ADD COLUMN sha256_cert_fingerprints text[];