-- Deploy: schemas/routing_public/tables/hostname_bindings/columns/domain_id/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/hostname_bindings/table


ALTER TABLE routing_public.hostname_bindings 
  ADD COLUMN domain_id uuid;