-- Revert: schemas/routing_public/tables/managed_domains/columns/database_id/column


ALTER TABLE routing_public.managed_domains 
  DROP COLUMN database_id RESTRICT;