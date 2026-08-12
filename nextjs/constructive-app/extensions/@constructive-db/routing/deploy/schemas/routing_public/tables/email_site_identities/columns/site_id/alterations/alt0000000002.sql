-- Deploy: schemas/routing_public/tables/email_site_identities/columns/site_id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/email_site_identities/columns/site_id/column


COMMENT ON COLUMN routing_public.email_site_identities.site_id IS 'Site whose mail is sent as the bound identity';