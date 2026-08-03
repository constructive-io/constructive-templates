-- Revert: schemas/catalog_public/tables/domains/columns/verification_status/column


ALTER TABLE catalog_public.domains 
  DROP COLUMN verification_status RESTRICT;