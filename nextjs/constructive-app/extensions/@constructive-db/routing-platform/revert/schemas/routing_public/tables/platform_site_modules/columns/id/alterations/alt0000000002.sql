-- Revert: schemas/routing_public/tables/platform_site_modules/columns/id/alterations/alt0000000002


ALTER TABLE routing_public.platform_site_modules 
  ALTER COLUMN id DROP DEFAULT;