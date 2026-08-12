-- Deploy: schemas/routing_public/tables/email_site_identities/columns/email_identity_id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/email_site_identities/columns/email_identity_id/column


COMMENT ON COLUMN routing_public.email_site_identities.email_identity_id IS 'Identity this site sends as';