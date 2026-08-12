-- Revert: schemas/routing_public/tables/site_web_configs/columns/index_document/column


ALTER TABLE routing_public.site_web_configs 
  DROP COLUMN index_document RESTRICT;