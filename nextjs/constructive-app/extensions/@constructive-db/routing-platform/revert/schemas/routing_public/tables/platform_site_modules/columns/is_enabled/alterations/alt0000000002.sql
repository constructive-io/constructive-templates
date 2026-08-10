-- Revert: schemas/routing_public/tables/platform_site_modules/columns/is_enabled/alterations/alt0000000002


ALTER TABLE routing_public.platform_site_modules 
  ALTER COLUMN is_enabled DROP DEFAULT;