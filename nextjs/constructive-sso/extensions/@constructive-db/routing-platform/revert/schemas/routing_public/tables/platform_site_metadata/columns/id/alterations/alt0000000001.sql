-- Revert: schemas/routing_public/tables/platform_site_metadata/columns/id/alterations/alt0000000001


ALTER TABLE routing_public.platform_site_metadata 
  ALTER COLUMN id DROP NOT NULL;