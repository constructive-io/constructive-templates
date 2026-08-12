-- Revert: schemas/routing_public/tables/platform_site_web_configs/columns/id/alterations/alt0000000001


ALTER TABLE routing_public.platform_site_web_configs 
  ALTER COLUMN id DROP NOT NULL;