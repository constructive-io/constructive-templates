-- Revert: schemas/routing_public/tables/managed_domains/columns/updated_at/column


ALTER TABLE routing_public.managed_domains 
  DROP COLUMN updated_at RESTRICT;