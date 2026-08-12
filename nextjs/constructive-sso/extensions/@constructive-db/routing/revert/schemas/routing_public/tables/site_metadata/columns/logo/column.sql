-- Revert: schemas/routing_public/tables/site_metadata/columns/logo/column


ALTER TABLE routing_public.site_metadata 
  DROP COLUMN logo RESTRICT;