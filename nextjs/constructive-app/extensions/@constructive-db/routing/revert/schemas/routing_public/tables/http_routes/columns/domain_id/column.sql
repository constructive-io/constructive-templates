-- Revert: schemas/routing_public/tables/http_routes/columns/domain_id/column


ALTER TABLE routing_public.http_routes 
  DROP COLUMN domain_id RESTRICT;