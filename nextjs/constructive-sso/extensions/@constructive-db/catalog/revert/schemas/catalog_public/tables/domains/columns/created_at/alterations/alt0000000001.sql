-- Revert: schemas/catalog_public/tables/domains/columns/created_at/alterations/alt0000000001


ALTER TABLE catalog_public.domains 
  ALTER COLUMN created_at DROP DEFAULT;