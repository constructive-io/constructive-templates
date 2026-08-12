-- Revert: schemas/routing_public/tables/site_modules/columns/is_enabled/column


ALTER TABLE routing_public.site_modules 
  DROP COLUMN is_enabled RESTRICT;