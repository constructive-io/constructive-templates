-- Revert: schemas/routing_public/tables/platform_domains/columns/updated_at/column


ALTER TABLE routing_public.platform_domains 
  DROP COLUMN updated_at RESTRICT;