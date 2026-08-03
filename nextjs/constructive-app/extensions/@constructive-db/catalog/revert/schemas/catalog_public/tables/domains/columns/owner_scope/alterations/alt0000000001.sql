-- Revert: schemas/catalog_public/tables/domains/columns/owner_scope/alterations/alt0000000001


ALTER TABLE catalog_public.domains 
  ALTER COLUMN owner_scope DROP NOT NULL;