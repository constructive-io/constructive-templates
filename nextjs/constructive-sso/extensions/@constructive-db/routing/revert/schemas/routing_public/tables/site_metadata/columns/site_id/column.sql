-- Revert: schemas/routing_public/tables/site_metadata/columns/site_id/column


ALTER TABLE routing_public.site_metadata 
  DROP COLUMN site_id RESTRICT;