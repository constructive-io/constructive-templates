-- Revert: schemas/routing_public/tables/platform_domains/columns/parent_hostname/column


ALTER TABLE routing_public.platform_domains 
  DROP COLUMN parent_hostname RESTRICT;