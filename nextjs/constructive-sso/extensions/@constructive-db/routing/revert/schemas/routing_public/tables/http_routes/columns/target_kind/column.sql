-- Revert: schemas/routing_public/tables/http_routes/columns/target_kind/column


ALTER TABLE routing_public.http_routes 
  DROP COLUMN target_kind RESTRICT;