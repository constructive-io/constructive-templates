-- Revert: schemas/routing_public/tables/http_routes/columns/id/alterations/alt0000000001


ALTER TABLE routing_public.http_routes 
  ALTER COLUMN id DROP NOT NULL;