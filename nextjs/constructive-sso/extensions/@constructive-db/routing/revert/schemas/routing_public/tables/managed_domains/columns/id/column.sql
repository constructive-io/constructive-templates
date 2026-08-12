-- Revert: schemas/routing_public/tables/managed_domains/columns/id/column


ALTER TABLE routing_public.managed_domains 
  DROP COLUMN id RESTRICT;