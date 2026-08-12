-- Revert: schemas/routing_public/tables/site_metadata/columns/created_at/alterations/alt0000000001


ALTER TABLE routing_public.site_metadata 
  ALTER COLUMN created_at DROP DEFAULT;