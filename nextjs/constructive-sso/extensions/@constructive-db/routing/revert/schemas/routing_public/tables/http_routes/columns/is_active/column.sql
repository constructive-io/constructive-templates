-- Revert: schemas/routing_public/tables/http_routes/columns/is_active/column


ALTER TABLE routing_public.http_routes 
  DROP COLUMN is_active RESTRICT;