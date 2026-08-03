-- Deploy: schemas/routing_public/tables/routes/columns/path/alterations/alt0000000004
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/routes/table
-- requires: schemas/routing_public/tables/routes/columns/path/column


ALTER TABLE routing_public.routes 
  ADD CONSTRAINT routes_path_chk 
    CHECK (
    "left"(path, 1) = '/'
      AND (path = '/'
      OR "right"(path, 1) <> '/')
  );