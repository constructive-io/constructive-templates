-- Revert: schemas/routing_public/tables/site_error_pages/constraints/site_error_pages_site_id_status_code_key/constraint


ALTER TABLE routing_public.site_error_pages 
  DROP CONSTRAINT site_error_pages_site_id_status_code_key RESTRICT;