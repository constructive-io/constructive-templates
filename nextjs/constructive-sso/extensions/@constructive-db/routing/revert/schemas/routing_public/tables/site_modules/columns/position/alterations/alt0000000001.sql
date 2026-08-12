-- Revert: schemas/routing_public/tables/site_modules/columns/position/alterations/alt0000000001


ALTER TABLE routing_public.site_modules 
  ALTER COLUMN "position" DROP NOT NULL;