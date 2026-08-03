-- Deploy: schemas/routing_public/tables/platform_domains/columns/tls_secret_name/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_domains/columns/tls_secret_name/column


COMMENT ON COLUMN routing_public.platform_domains.tls_secret_name IS 'Name of the TLS secret serving this hostname';