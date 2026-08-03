-- Revert: schemas/routing_public/tables/platform_sites/columns/description/column


ALTER TABLE routing_public.platform_sites 
  DROP COLUMN description RESTRICT;