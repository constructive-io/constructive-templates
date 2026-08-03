-- Revert: schemas/routing_public/tables/platform_managed_domains/columns/id/column


ALTER TABLE routing_public.platform_managed_domains 
  DROP COLUMN id RESTRICT;