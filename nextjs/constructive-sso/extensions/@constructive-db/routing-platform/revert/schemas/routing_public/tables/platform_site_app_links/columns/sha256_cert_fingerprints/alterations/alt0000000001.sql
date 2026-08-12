-- Revert: schemas/routing_public/tables/platform_site_app_links/columns/sha256_cert_fingerprints/alterations/alt0000000001


ALTER TABLE routing_public.platform_site_app_links 
  ALTER COLUMN sha256_cert_fingerprints DROP NOT NULL;