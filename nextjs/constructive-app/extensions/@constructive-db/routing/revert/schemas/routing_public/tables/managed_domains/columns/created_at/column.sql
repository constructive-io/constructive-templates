-- Revert: schemas/routing_public/tables/managed_domains/columns/created_at/column


ALTER TABLE routing_public.managed_domains 
  DROP COLUMN created_at RESTRICT;