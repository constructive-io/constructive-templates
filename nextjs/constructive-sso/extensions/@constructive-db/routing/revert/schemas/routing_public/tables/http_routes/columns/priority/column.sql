-- Revert: schemas/routing_public/tables/http_routes/columns/priority/column


ALTER TABLE routing_public.http_routes 
  DROP COLUMN priority RESTRICT;