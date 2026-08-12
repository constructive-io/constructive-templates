-- Revert: schemas/routing_public/tables/platform_pages/constraints/platform_pages_site_id_slug_key/constraint


ALTER TABLE routing_public.platform_pages 
  DROP CONSTRAINT platform_pages_site_id_slug_key RESTRICT;