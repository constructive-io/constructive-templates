-- Revert: schemas/routing_public/tables/http_routes/columns/method/column


ALTER TABLE routing_public.http_routes 
  DROP COLUMN method RESTRICT;