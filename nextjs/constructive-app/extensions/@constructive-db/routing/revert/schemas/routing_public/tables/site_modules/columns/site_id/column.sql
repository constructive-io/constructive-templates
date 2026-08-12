-- Revert: schemas/routing_public/tables/site_modules/columns/site_id/column


ALTER TABLE routing_public.site_modules 
  DROP COLUMN site_id RESTRICT;