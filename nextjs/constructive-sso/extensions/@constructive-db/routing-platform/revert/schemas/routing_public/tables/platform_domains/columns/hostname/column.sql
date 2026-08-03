-- Revert: schemas/routing_public/tables/platform_domains/columns/hostname/column


ALTER TABLE routing_public.platform_domains 
  DROP COLUMN hostname RESTRICT;