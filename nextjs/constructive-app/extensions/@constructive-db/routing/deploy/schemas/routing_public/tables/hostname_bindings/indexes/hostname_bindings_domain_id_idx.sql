-- Deploy: schemas/routing_public/tables/hostname_bindings/indexes/hostname_bindings_domain_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/hostname_bindings/table
-- requires: schemas/routing_public/tables/hostname_bindings/columns/domain_id/column


CREATE INDEX hostname_bindings_domain_id_idx ON routing_public.hostname_bindings (domain_id);