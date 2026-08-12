-- Revert: schemas/routing_public/tables/http_routes/columns/priority/alterations/alt0000000001


ALTER TABLE routing_public.http_routes 
  ALTER COLUMN priority DROP NOT NULL;