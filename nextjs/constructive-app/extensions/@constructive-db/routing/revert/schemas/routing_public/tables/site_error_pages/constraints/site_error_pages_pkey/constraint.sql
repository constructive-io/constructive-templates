-- Revert: schemas/routing_public/tables/site_error_pages/constraints/site_error_pages_pkey/constraint


ALTER TABLE routing_public.site_error_pages 
  DROP CONSTRAINT site_error_pages_pkey RESTRICT;