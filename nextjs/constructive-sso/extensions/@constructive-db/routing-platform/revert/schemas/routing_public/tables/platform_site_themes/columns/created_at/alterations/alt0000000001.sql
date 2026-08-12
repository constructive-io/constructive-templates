-- Revert: schemas/routing_public/tables/platform_site_themes/columns/created_at/alterations/alt0000000001


ALTER TABLE routing_public.platform_site_themes 
  ALTER COLUMN created_at DROP DEFAULT;