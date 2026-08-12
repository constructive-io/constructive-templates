-- Deploy: schemas/routing_public/tables/hostname_bindings/indexes/hostname_bindings_parent_hostname_is_wildcard_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/hostname_bindings/table
-- requires: schemas/routing_public/tables/hostname_bindings/columns/is_wildcard/column
-- requires: schemas/routing_public/tables/hostname_bindings/columns/parent_hostname/column


CREATE INDEX hostname_bindings_parent_hostname_is_wildcard_idx ON routing_public.hostname_bindings (parent_hostname, is_wildcard);