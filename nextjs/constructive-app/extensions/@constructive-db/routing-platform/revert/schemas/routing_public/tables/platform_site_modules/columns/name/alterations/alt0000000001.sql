-- Revert: schemas/routing_public/tables/platform_site_modules/columns/name/alterations/alt0000000001


ALTER TABLE routing_public.platform_site_modules 
  ALTER COLUMN name DROP NOT NULL;