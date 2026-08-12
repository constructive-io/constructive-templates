-- Revert: schemas/routing_public/tables/site_web_configs/columns/updated_at/column


ALTER TABLE routing_public.site_web_configs 
  DROP COLUMN updated_at RESTRICT;