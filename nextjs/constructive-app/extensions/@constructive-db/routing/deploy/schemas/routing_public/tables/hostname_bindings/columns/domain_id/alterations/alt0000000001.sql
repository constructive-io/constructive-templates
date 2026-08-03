-- Deploy: schemas/routing_public/tables/hostname_bindings/columns/domain_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/hostname_bindings/table
-- requires: schemas/routing_public/tables/hostname_bindings/columns/domain_id/column


ALTER TABLE routing_public.hostname_bindings 
  ALTER COLUMN domain_id SET NOT NULL;