-- Revert: schemas/routing_public/tables/platform_domains/columns/id/column


ALTER TABLE routing_public.platform_domains 
  DROP COLUMN id RESTRICT;