-- Revert: schemas/routing_public/tables/site_metadata/columns/store_id/column


ALTER TABLE routing_public.site_metadata 
  DROP COLUMN store_id RESTRICT;