-- Revert: schemas/routing_public/tables/site_modules/columns/updated_at/column


ALTER TABLE routing_public.site_modules 
  DROP COLUMN updated_at RESTRICT;