-- Deploy: schemas/routing_public/tables/platform_domains/columns/parent_hostname/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_domains/columns/parent_hostname/column


COMMENT ON COLUMN routing_public.platform_domains.parent_hostname IS 'Parent hostname a wildcard claim covers (example.com for *.example.com)';