-- Revert: schemas/routing_public/tables/platform_site_themes/columns/is_active/alterations/alt0000000001


ALTER TABLE routing_public.platform_site_themes 
  ALTER COLUMN is_active DROP NOT NULL;