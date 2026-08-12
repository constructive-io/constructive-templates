-- Deploy: schemas/routing_public/tables/domains/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/domains/table


COMMENT ON TABLE routing_public.domains IS '@scope database
@scopeKey database_id
@scopeTier database
Fully-qualified hostnames owned by this scope; each row claims its hostname globally through the catalog';