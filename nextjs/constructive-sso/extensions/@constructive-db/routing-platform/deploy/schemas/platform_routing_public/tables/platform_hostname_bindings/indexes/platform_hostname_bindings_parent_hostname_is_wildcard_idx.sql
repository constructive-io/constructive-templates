-- Deploy: schemas/platform_routing_public/tables/platform_hostname_bindings/indexes/platform_hostname_bindings_parent_hostname_is_wildcard_idx
-- made with <3 @ constructive.io

-- requires: schemas/platform_routing_public/schema
-- requires: schemas/platform_routing_public/tables/platform_hostname_bindings/table
-- requires: schemas/platform_routing_public/tables/platform_hostname_bindings/columns/is_wildcard/column
-- requires: schemas/platform_routing_public/tables/platform_hostname_bindings/columns/parent_hostname/column


CREATE INDEX platform_hostname_bindings_parent_hostname_is_wildcard_idx ON platform_routing_public.platform_hostname_bindings (parent_hostname, is_wildcard);