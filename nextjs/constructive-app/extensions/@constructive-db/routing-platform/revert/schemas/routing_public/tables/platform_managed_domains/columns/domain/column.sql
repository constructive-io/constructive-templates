-- Revert: schemas/routing_public/tables/platform_managed_domains/columns/domain/column


ALTER TABLE routing_public.platform_managed_domains 
  DROP COLUMN domain RESTRICT;