-- Deploy: schemas/routing_public/tables/email_site_identities/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/email_site_identities/table


COMMENT ON TABLE routing_public.email_site_identities IS 'Binds a site to the identity it sends as. Unique on site_id: one identity per site, but many sites may share an identity.';