-- Revert: schemas/routing_public/tables/http_routes/columns/updated_by/column


ALTER TABLE routing_public.http_routes 
  DROP COLUMN updated_by RESTRICT;