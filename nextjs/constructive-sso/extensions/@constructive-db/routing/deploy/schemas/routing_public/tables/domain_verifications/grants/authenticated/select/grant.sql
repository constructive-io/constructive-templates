-- Deploy: schemas/routing_public/tables/domain_verifications/grants/authenticated/select/grant
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/domain_verifications/table


GRANT SELECT ON routing_public.domain_verifications TO authenticated;