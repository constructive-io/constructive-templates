-- Revert: schemas/routing_public/tables/site_modules/columns/database_id/column


ALTER TABLE routing_public.site_modules 
  DROP COLUMN database_id RESTRICT;