-- Revert: schemas/routing_public/tables/apis/columns/database_id/alterations/alt0000000001


ALTER TABLE routing_public.apis 
  ALTER COLUMN database_id DROP NOT NULL;