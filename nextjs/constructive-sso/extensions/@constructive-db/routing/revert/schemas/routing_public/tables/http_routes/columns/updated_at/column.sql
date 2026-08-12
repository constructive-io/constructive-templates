-- Revert: schemas/routing_public/tables/http_routes/columns/updated_at/column


ALTER TABLE routing_public.http_routes 
  DROP COLUMN updated_at RESTRICT;