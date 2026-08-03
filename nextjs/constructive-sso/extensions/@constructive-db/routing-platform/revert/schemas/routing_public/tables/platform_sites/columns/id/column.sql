-- Revert: schemas/routing_public/tables/platform_sites/columns/id/column


ALTER TABLE routing_public.platform_sites 
  DROP COLUMN id RESTRICT;