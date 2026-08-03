-- Revert: schemas/routing_public/tables/site_metadata/columns/created_at/column


ALTER TABLE routing_public.site_metadata 
  DROP COLUMN created_at RESTRICT;