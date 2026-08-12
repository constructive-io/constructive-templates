-- Revert: schemas/catalog_public/tables/domains/columns/tls_secret_name/column


ALTER TABLE catalog_public.domains 
  DROP COLUMN tls_secret_name RESTRICT;