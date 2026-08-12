-- Revert: schemas/routing_public/tables/site_web_configs/columns/metadata/column


ALTER TABLE routing_public.site_web_configs 
  DROP COLUMN metadata RESTRICT;