-- Deploy: schemas/routing_public/tables/domain_events/grants/authenticated/select/grant
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/domain_events/table


GRANT SELECT ON routing_public.domain_events TO authenticated;