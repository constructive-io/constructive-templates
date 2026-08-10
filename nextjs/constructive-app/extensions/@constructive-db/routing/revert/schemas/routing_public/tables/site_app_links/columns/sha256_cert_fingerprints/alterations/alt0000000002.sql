-- Revert: schemas/routing_public/tables/site_app_links/columns/sha256_cert_fingerprints/alterations/alt0000000002


ALTER TABLE routing_public.site_app_links 
  ALTER COLUMN sha256_cert_fingerprints DROP DEFAULT;