-- Deploy: schemas/routing_public/tables/http_routes/columns/method/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/http_routes/table
-- requires: schemas/routing_public/tables/http_routes/columns/method/column


ALTER TABLE routing_public.http_routes 
  ADD CONSTRAINT http_routes_method_chk 
    CHECK (
    method IS NULL
      OR method = upper(method)
  );