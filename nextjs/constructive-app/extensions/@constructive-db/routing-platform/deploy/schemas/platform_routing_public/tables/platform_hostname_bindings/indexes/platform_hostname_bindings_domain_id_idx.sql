-- Deploy: schemas/platform_routing_public/tables/platform_hostname_bindings/indexes/platform_hostname_bindings_domain_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/platform_routing_public/schema
-- requires: schemas/platform_routing_public/tables/platform_hostname_bindings/table
-- requires: schemas/platform_routing_public/tables/platform_hostname_bindings/columns/domain_id/column


CREATE INDEX platform_hostname_bindings_domain_id_idx ON platform_routing_public.platform_hostname_bindings (domain_id);