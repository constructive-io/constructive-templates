-- Revert: schemas/routing_public/tables/domains/columns/database_id/alterations/alt0000000001


ALTER TABLE routing_public.domains 
  ALTER COLUMN database_id DROP NOT NULL;