-- Revert: schemas/routing_public/tables/site_modules/columns/position/column


ALTER TABLE routing_public.site_modules 
  DROP COLUMN "position" RESTRICT;