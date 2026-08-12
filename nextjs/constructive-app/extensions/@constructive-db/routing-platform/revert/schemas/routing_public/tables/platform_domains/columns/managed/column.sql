-- Revert: schemas/routing_public/tables/platform_domains/columns/managed/column


ALTER TABLE routing_public.platform_domains 
  DROP COLUMN managed RESTRICT;