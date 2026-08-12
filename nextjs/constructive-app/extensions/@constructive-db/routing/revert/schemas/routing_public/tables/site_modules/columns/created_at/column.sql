-- Revert: schemas/routing_public/tables/site_modules/columns/created_at/column


ALTER TABLE routing_public.site_modules 
  DROP COLUMN created_at RESTRICT;