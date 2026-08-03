-- Revert: schemas/routing_public/tables/http_routes/columns/target_id/alterations/alt0000000001


ALTER TABLE routing_public.http_routes 
  ALTER COLUMN target_id DROP NOT NULL;