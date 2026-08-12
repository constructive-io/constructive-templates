-- Revert: schemas/routing_public/tables/platform_site_metadata/columns/updated_at/alterations/alt0000000001


ALTER TABLE routing_public.platform_site_metadata 
  ALTER COLUMN updated_at DROP DEFAULT;