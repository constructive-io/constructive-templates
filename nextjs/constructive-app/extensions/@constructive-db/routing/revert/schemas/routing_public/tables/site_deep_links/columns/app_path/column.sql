-- Revert: schemas/routing_public/tables/site_deep_links/columns/app_path/column


ALTER TABLE routing_public.site_deep_links 
  DROP COLUMN app_path RESTRICT;