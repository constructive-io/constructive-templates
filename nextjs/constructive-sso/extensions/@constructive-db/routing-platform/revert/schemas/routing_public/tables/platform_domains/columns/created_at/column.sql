-- Revert: schemas/routing_public/tables/platform_domains/columns/created_at/column


ALTER TABLE routing_public.platform_domains 
  DROP COLUMN created_at RESTRICT;