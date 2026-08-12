-- Revert: schemas/routing_public/tables/platform_apis/columns/created_at/column


ALTER TABLE routing_public.platform_apis 
  DROP COLUMN created_at RESTRICT;