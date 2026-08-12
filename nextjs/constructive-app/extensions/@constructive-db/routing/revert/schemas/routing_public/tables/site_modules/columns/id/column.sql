-- Revert: schemas/routing_public/tables/site_modules/columns/id/column


ALTER TABLE routing_public.site_modules 
  DROP COLUMN id RESTRICT;