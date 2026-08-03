-- Revert: schemas/routing_public/tables/platform_site_metadata/columns/created_at/alterations/alt0000000001


ALTER TABLE routing_public.platform_site_metadata 
  ALTER COLUMN created_at DROP DEFAULT;