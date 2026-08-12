-- Revert: schemas/routing_public/tables/site_metadata/columns/favicon/column


ALTER TABLE routing_public.site_metadata 
  DROP COLUMN favicon RESTRICT;