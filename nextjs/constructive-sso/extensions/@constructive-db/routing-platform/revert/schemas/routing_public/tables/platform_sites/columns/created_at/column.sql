-- Revert: schemas/routing_public/tables/platform_sites/columns/created_at/column


ALTER TABLE routing_public.platform_sites 
  DROP COLUMN created_at RESTRICT;