-- Revert: schemas/routing_public/tables/site_app_links/columns/sha256_cert_fingerprints/column


ALTER TABLE routing_public.site_app_links 
  DROP COLUMN sha256_cert_fingerprints RESTRICT;