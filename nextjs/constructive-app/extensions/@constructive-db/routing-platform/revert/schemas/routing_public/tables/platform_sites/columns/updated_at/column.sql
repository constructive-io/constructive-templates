-- Revert: schemas/routing_public/tables/platform_sites/columns/updated_at/column


ALTER TABLE routing_public.platform_sites 
  DROP COLUMN updated_at RESTRICT;