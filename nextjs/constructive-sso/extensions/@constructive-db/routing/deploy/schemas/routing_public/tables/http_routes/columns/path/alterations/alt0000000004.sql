-- Deploy: schemas/routing_public/tables/http_routes/columns/path/alterations/alt0000000004
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/http_routes/table
-- requires: schemas/routing_public/tables/http_routes/columns/path/column


ALTER TABLE routing_public.http_routes 
  ADD CONSTRAINT http_routes_path_chk 
    CHECK (
    "left"(path, 1) = '/'
      AND (path = '/'
      OR "right"(path, 1) <> '/')
  );