-- Revert: schemas/routing_public/tables/http_routes/columns/path/alterations/alt0000000001


ALTER TABLE routing_public.http_routes 
  ALTER COLUMN path DROP NOT NULL;