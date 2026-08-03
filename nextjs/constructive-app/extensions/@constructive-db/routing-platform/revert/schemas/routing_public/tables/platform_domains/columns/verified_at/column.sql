-- Revert: schemas/routing_public/tables/platform_domains/columns/verified_at/column


ALTER TABLE routing_public.platform_domains 
  DROP COLUMN verified_at RESTRICT;