-- Revert: schemas/routing_public/tables/site_web_configs/columns/site_id/column


ALTER TABLE routing_public.site_web_configs 
  DROP COLUMN site_id RESTRICT;