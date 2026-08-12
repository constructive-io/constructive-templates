-- Deploy: schemas/routing_public/tables/hostname_bindings/columns/updated_at/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/hostname_bindings/table


ALTER TABLE routing_public.hostname_bindings 
  ADD COLUMN updated_at timestamptz;