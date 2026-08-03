-- Deploy: schemas/routing_public/tables/http_routes/columns/target_kind/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/http_routes/table
-- requires: schemas/routing_public/tables/http_routes/columns/target_kind/column


ALTER TABLE routing_public.http_routes 
  ALTER COLUMN target_kind SET NOT NULL;