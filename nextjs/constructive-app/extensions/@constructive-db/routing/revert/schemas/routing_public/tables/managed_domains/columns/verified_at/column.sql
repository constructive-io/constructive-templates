-- Revert: schemas/routing_public/tables/managed_domains/columns/verified_at/column


ALTER TABLE routing_public.managed_domains 
  DROP COLUMN verified_at RESTRICT;