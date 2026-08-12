-- Revert: schemas/routing_public/tables/platform_site_app_links/columns/sha256_cert_fingerprints/column


ALTER TABLE routing_public.platform_site_app_links 
  DROP COLUMN sha256_cert_fingerprints RESTRICT;