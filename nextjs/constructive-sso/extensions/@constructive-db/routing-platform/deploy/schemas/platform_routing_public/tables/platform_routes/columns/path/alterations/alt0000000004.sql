-- Deploy: schemas/platform_routing_public/tables/platform_routes/columns/path/alterations/alt0000000004
-- made with <3 @ constructive.io

-- requires: schemas/platform_routing_public/schema
-- requires: schemas/platform_routing_public/tables/platform_routes/table
-- requires: schemas/platform_routing_public/tables/platform_routes/columns/path/column


ALTER TABLE platform_routing_public.platform_routes 
  ADD CONSTRAINT platform_routes_path_chk 
    CHECK (
    "left"(path, 1) = '/'
      AND (path = '/'
      OR "right"(path, 1) <> '/')
  );