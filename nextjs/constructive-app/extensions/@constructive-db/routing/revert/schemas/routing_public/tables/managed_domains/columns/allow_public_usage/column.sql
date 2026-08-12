-- Revert: schemas/routing_public/tables/managed_domains/columns/allow_public_usage/column


ALTER TABLE routing_public.managed_domains 
  DROP COLUMN allow_public_usage RESTRICT;