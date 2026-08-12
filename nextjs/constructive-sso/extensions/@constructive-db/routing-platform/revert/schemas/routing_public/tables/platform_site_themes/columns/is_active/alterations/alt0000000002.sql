-- Revert: schemas/routing_public/tables/platform_site_themes/columns/is_active/alterations/alt0000000002


ALTER TABLE routing_public.platform_site_themes 
  ALTER COLUMN is_active DROP DEFAULT;