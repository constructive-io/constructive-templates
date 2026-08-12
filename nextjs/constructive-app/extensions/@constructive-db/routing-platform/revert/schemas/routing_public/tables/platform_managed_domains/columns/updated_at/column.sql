-- Revert: schemas/routing_public/tables/platform_managed_domains/columns/updated_at/column


ALTER TABLE routing_public.platform_managed_domains 
  DROP COLUMN updated_at RESTRICT;