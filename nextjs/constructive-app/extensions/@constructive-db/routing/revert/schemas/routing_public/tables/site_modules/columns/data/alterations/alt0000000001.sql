-- Revert: schemas/routing_public/tables/site_modules/columns/data/alterations/alt0000000001


ALTER TABLE routing_public.site_modules 
  ALTER COLUMN data DROP NOT NULL;