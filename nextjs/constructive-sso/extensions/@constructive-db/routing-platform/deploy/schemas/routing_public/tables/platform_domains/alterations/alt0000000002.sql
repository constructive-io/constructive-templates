-- Deploy: schemas/routing_public/tables/platform_domains/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_domains/table


COMMENT ON TABLE routing_public.platform_domains IS 'Fully-qualified hostnames owned by this scope; each row claims its hostname globally through the catalog';