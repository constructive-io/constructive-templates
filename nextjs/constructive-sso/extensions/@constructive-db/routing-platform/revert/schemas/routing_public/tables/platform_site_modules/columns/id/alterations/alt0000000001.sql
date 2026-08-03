-- Revert: schemas/routing_public/tables/platform_site_modules/columns/id/alterations/alt0000000001


ALTER TABLE routing_public.platform_site_modules 
  ALTER COLUMN id DROP NOT NULL;