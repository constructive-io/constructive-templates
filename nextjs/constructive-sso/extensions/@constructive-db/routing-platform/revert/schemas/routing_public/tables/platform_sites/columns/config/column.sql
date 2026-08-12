-- Revert: schemas/routing_public/tables/platform_sites/columns/config/column


ALTER TABLE routing_public.platform_sites 
  DROP COLUMN config RESTRICT;