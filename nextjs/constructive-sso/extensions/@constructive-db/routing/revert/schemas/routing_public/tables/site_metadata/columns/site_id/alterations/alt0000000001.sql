-- Revert: schemas/routing_public/tables/site_metadata/columns/site_id/alterations/alt0000000001


ALTER TABLE routing_public.site_metadata 
  ALTER COLUMN site_id DROP NOT NULL;