-- Revert: schemas/routing_public/tables/platform_managed_domains/columns/created_at/column


ALTER TABLE routing_public.platform_managed_domains 
  DROP COLUMN created_at RESTRICT;