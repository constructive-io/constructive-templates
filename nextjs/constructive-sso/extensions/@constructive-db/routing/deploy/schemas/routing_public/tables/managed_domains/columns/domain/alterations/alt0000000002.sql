-- Deploy: schemas/routing_public/tables/managed_domains/columns/domain/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/managed_domains/columns/domain/column


COMMENT ON COLUMN routing_public.managed_domains.domain IS 'Lowercase fully-qualified managed hostname; wildcards use the *.parent form';