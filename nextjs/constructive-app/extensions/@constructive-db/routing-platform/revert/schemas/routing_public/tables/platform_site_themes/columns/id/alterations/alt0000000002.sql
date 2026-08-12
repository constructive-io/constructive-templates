-- Revert: schemas/routing_public/tables/platform_site_themes/columns/id/alterations/alt0000000002


ALTER TABLE routing_public.platform_site_themes 
  ALTER COLUMN id DROP DEFAULT;