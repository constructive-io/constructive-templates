-- Revert: schemas/routing_public/tables/sites/columns/description/column


ALTER TABLE routing_public.sites 
  DROP COLUMN description RESTRICT;