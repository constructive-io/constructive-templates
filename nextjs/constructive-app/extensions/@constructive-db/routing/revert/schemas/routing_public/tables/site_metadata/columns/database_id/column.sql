-- Revert: schemas/routing_public/tables/site_metadata/columns/database_id/column


ALTER TABLE routing_public.site_metadata 
  DROP COLUMN database_id RESTRICT;