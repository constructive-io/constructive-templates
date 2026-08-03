-- Deploy: schemas/routing_public/tables/domain_events/grants/authenticated/insert/grant
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/domain_events/table


GRANT INSERT ON routing_public.domain_events TO authenticated;