-- Deploy: schemas/routing_public/tables/managed_domains/columns/allow_public_usage/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/managed_domains/columns/allow_public_usage/column


COMMENT ON COLUMN routing_public.managed_domains.allow_public_usage IS 'Whether tenants may claim subdomains under this managed hostname';