-- Deploy: schemas/routing_public/tables/email_identities/grants/authenticated/delete/grant
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/email_identities/table


GRANT DELETE ON routing_public.email_identities TO authenticated;