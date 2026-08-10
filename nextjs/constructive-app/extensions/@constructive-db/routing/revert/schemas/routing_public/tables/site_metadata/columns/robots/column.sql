-- Revert: schemas/routing_public/tables/site_metadata/columns/robots/column


ALTER TABLE routing_public.site_metadata 
  DROP COLUMN robots RESTRICT;