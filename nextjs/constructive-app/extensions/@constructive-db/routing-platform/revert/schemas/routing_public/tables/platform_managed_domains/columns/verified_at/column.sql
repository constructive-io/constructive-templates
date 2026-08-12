-- Revert: schemas/routing_public/tables/platform_managed_domains/columns/verified_at/column


ALTER TABLE routing_public.platform_managed_domains 
  DROP COLUMN verified_at RESTRICT;