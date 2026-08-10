-- Revert: schemas/routing_public/tables/site_app_links/columns/app_identifier/column


ALTER TABLE routing_public.site_app_links 
  DROP COLUMN app_identifier RESTRICT;