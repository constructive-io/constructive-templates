-- Deploy: schemas/platform_routing_public/tables/platform_routes/columns/method/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/platform_routing_public/schema
-- requires: schemas/platform_routing_public/tables/platform_routes/table
-- requires: schemas/platform_routing_public/tables/platform_routes/columns/method/column


ALTER TABLE platform_routing_public.platform_routes 
  ADD CONSTRAINT platform_routes_method_chk 
    CHECK (
    method IS NULL
      OR method = upper(method)
  );