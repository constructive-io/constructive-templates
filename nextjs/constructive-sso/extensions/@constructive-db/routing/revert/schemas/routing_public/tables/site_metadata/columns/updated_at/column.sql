-- Revert: schemas/routing_public/tables/site_metadata/columns/updated_at/column


ALTER TABLE routing_public.site_metadata 
  DROP COLUMN updated_at RESTRICT;