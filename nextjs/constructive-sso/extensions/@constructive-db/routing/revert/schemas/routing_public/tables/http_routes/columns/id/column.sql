-- Revert: schemas/routing_public/tables/http_routes/columns/id/column


ALTER TABLE routing_public.http_routes 
  DROP COLUMN id RESTRICT;