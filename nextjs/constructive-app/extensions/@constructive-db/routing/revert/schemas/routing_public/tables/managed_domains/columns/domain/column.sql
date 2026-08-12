-- Revert: schemas/routing_public/tables/managed_domains/columns/domain/column


ALTER TABLE routing_public.managed_domains 
  DROP COLUMN domain RESTRICT;