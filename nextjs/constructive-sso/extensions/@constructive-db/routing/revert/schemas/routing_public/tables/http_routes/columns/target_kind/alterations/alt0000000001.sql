-- Revert: schemas/routing_public/tables/http_routes/columns/target_kind/alterations/alt0000000001


ALTER TABLE routing_public.http_routes 
  ALTER COLUMN target_kind DROP NOT NULL;