-- Revert: schemas/routing_public/tables/managed_domains/columns/database_id/alterations/alt0000000001


ALTER TABLE routing_public.managed_domains 
  ALTER COLUMN database_id DROP NOT NULL;