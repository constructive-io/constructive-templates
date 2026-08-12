-- Revert: schemas/routing_public/tables/platform_site_web_configs/columns/id/alterations/alt0000000002


ALTER TABLE routing_public.platform_site_web_configs 
  ALTER COLUMN id DROP DEFAULT;