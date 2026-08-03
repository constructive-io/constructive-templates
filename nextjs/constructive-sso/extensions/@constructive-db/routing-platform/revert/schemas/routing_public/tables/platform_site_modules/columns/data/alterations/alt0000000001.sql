-- Revert: schemas/routing_public/tables/platform_site_modules/columns/data/alterations/alt0000000001


ALTER TABLE routing_public.platform_site_modules 
  ALTER COLUMN data DROP NOT NULL;