-- Revert: schemas/routing_public/tables/platform_managed_domains/columns/annotations/column


ALTER TABLE routing_public.platform_managed_domains 
  DROP COLUMN annotations RESTRICT;