-- Deploy: schemas/routing_public/tables/platform_email_identities/columns/from_address/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_email_identities/columns/from_address/column


COMMENT ON COLUMN routing_public.platform_email_identities.from_address IS 'Envelope/header From address, lower-case. Must be accepted by the sending account at the provider.';