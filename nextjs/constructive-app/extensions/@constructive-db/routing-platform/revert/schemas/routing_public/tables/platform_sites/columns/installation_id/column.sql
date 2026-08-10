-- Revert: schemas/routing_public/tables/platform_sites/columns/installation_id/column


ALTER TABLE routing_public.platform_sites 
  DROP COLUMN installation_id RESTRICT;