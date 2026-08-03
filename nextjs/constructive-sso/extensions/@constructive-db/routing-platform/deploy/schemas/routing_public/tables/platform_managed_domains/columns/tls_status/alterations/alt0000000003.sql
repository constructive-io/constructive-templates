-- Deploy: schemas/routing_public/tables/platform_managed_domains/columns/tls_status/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_managed_domains/columns/tls_status/column


COMMENT ON COLUMN routing_public.platform_managed_domains.tls_status IS 'TLS provisioning state for this managed hostname';