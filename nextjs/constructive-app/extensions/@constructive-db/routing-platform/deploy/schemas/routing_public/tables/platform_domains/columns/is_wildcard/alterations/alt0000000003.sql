-- Deploy: schemas/routing_public/tables/platform_domains/columns/is_wildcard/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_domains/columns/is_wildcard/column


COMMENT ON COLUMN routing_public.platform_domains.is_wildcard IS 'Whether this hostname is a *.parent wildcard claim';