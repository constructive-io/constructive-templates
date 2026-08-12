-- Deploy: schemas/routing_public/tables/domains/columns/is_wildcard/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/domains/columns/is_wildcard/column


COMMENT ON COLUMN routing_public.domains.is_wildcard IS 'Whether this hostname is a *.parent wildcard claim';