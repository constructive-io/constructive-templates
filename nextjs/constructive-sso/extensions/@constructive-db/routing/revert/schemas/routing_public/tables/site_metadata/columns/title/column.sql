-- Revert: schemas/routing_public/tables/site_metadata/columns/title/column


ALTER TABLE routing_public.site_metadata 
  DROP COLUMN title RESTRICT;