-- Revert: schemas/routing_public/tables/http_routes/columns/updated_at/alterations/alt0000000001


ALTER TABLE routing_public.http_routes 
  ALTER COLUMN updated_at DROP DEFAULT;