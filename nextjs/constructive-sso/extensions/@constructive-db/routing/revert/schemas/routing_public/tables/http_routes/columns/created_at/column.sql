-- Revert: schemas/routing_public/tables/http_routes/columns/created_at/column


ALTER TABLE routing_public.http_routes 
  DROP COLUMN created_at RESTRICT;