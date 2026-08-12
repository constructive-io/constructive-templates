-- Deploy: schemas/routing_public/tables/domains/columns/parent_hostname/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/domains/columns/parent_hostname/column


COMMENT ON COLUMN routing_public.domains.parent_hostname IS '@has_guard
Parent hostname a wildcard claim covers (example.com for *.example.com)';