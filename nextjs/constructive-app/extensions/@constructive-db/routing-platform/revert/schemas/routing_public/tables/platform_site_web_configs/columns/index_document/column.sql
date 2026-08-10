-- Revert: schemas/routing_public/tables/platform_site_web_configs/columns/index_document/column


ALTER TABLE routing_public.platform_site_web_configs 
  DROP COLUMN index_document RESTRICT;