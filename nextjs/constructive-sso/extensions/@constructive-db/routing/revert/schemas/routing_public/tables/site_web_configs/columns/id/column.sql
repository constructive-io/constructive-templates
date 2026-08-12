-- Revert: schemas/routing_public/tables/site_web_configs/columns/id/column


ALTER TABLE routing_public.site_web_configs 
  DROP COLUMN id RESTRICT;