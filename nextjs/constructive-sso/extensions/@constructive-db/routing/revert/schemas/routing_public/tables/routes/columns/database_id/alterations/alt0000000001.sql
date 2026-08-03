-- Revert: schemas/routing_public/tables/routes/columns/database_id/alterations/alt0000000001


ALTER TABLE routing_public.routes 
  ALTER COLUMN database_id DROP NOT NULL;