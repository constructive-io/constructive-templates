-- Deploy: schemas/routing_public/tables/managed_domains/grants/authenticated/select/grant
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/managed_domains/table


GRANT SELECT ON routing_public.managed_domains TO authenticated;