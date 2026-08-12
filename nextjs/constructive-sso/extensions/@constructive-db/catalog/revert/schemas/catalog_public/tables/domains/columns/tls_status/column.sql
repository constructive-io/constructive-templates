-- Revert: schemas/catalog_public/tables/domains/columns/tls_status/column


ALTER TABLE catalog_public.domains 
  DROP COLUMN tls_status RESTRICT;