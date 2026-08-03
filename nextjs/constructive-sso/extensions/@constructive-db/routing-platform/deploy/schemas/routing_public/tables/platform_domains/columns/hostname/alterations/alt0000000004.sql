-- Deploy: schemas/routing_public/tables/platform_domains/columns/hostname/alterations/alt0000000004
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_domains/columns/hostname/column


COMMENT ON COLUMN routing_public.platform_domains.hostname IS '@has_guard
Lowercase fully-qualified hostname; wildcards use the *.parent form';