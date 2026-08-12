-- Deploy: schemas/routing_public/tables/domains/columns/hostname/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/domains/columns/hostname/column


COMMENT ON COLUMN routing_public.domains.hostname IS 'Lowercase fully-qualified hostname; wildcards use the *.parent form';