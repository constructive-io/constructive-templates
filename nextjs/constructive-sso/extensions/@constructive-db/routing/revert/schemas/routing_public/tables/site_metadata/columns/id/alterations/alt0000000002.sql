-- Revert: schemas/routing_public/tables/site_metadata/columns/id/alterations/alt0000000002


ALTER TABLE routing_public.site_metadata 
  ALTER COLUMN id DROP DEFAULT;