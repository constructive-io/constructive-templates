-- Deploy: schemas/routing_public/tables/email_site_identities/grants/authenticated/select/grant
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/email_site_identities/table


GRANT SELECT ON routing_public.email_site_identities TO authenticated;