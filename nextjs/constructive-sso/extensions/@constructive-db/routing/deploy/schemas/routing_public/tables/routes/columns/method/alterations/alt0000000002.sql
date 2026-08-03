-- Deploy: schemas/routing_public/tables/routes/columns/method/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/routes/table
-- requires: schemas/routing_public/tables/routes/columns/method/column


ALTER TABLE routing_public.routes 
  ADD CONSTRAINT routes_method_chk 
    CHECK (
    method IS NULL
      OR method = upper(method)
  );