-- Revert: schemas/routing_public/tables/site_metadata/columns/description/column


ALTER TABLE routing_public.site_metadata 
  DROP COLUMN description RESTRICT;