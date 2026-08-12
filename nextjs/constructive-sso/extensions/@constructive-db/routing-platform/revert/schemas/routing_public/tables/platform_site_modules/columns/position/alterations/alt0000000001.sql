-- Revert: schemas/routing_public/tables/platform_site_modules/columns/position/alterations/alt0000000001


ALTER TABLE routing_public.platform_site_modules 
  ALTER COLUMN "position" DROP NOT NULL;