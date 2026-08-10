-- Deploy: schemas/routing_public/tables/email_identities/columns/is_default/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/email_identities/columns/is_default/column


COMMENT ON COLUMN routing_public.email_identities.is_default IS 'The scope default identity, used when no site binding resolves. At most one per scope key.';