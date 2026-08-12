-- Revert: schemas/routing_public/tables/pages/columns/database_id/alterations/alt0000000001


ALTER TABLE routing_public.pages 
  ALTER COLUMN database_id DROP NOT NULL;