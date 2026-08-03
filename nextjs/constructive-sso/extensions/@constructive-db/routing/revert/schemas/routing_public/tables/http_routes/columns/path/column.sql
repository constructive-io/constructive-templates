-- Revert: schemas/routing_public/tables/http_routes/columns/path/column


ALTER TABLE routing_public.http_routes 
  DROP COLUMN path RESTRICT;