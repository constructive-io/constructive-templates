-- Revert: schemas/routing_public/tables/platform_apis/columns/updated_at/column


ALTER TABLE routing_public.platform_apis 
  DROP COLUMN updated_at RESTRICT;