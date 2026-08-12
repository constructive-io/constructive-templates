-- Revert: schemas/routing_public/tables/http_routes/columns/is_active/alterations/alt0000000001


ALTER TABLE routing_public.http_routes 
  ALTER COLUMN is_active DROP NOT NULL;