-- Deploy: schemas/routing_public/tables/hostname_bindings/columns/id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/hostname_bindings/table
-- requires: schemas/routing_public/tables/hostname_bindings/columns/id/column


ALTER TABLE routing_public.hostname_bindings 
  ALTER COLUMN id SET NOT NULL;