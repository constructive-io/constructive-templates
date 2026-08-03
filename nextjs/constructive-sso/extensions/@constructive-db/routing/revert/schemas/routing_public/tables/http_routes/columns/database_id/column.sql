-- Revert: schemas/routing_public/tables/http_routes/columns/database_id/column


ALTER TABLE routing_public.http_routes 
  DROP COLUMN database_id RESTRICT;