-- Revert: schemas/routing_public/tables/platform_site_modules/columns/updated_at/alterations/alt0000000001


ALTER TABLE routing_public.platform_site_modules 
  ALTER COLUMN updated_at DROP DEFAULT;