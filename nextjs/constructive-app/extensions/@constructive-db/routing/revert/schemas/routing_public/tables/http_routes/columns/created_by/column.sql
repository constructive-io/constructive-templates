-- Revert: schemas/routing_public/tables/http_routes/columns/created_by/column


ALTER TABLE routing_public.http_routes 
  DROP COLUMN created_by RESTRICT;