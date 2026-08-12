-- Revert: schemas/routing_public/tables/site_web_configs/columns/created_at/column


ALTER TABLE routing_public.site_web_configs 
  DROP COLUMN created_at RESTRICT;