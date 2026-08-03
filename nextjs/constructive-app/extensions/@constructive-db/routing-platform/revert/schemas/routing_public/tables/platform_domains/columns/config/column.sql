-- Revert: schemas/routing_public/tables/platform_domains/columns/config/column


ALTER TABLE routing_public.platform_domains 
  DROP COLUMN config RESTRICT;