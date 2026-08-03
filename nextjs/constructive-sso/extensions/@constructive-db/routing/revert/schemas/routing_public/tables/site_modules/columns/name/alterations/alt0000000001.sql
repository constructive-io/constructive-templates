-- Revert: schemas/routing_public/tables/site_modules/columns/name/alterations/alt0000000001


ALTER TABLE routing_public.site_modules 
  ALTER COLUMN name DROP NOT NULL;