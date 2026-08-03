-- Revert: schemas/routing_public/tables/site_metadata/columns/id/column


ALTER TABLE routing_public.site_metadata 
  DROP COLUMN id RESTRICT;