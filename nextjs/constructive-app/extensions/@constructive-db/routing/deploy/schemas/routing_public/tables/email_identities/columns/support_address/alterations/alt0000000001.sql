-- Deploy: schemas/routing_public/tables/email_identities/columns/support_address/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/email_identities/columns/support_address/column


COMMENT ON COLUMN routing_public.email_identities.support_address IS 'Support address rendered in message bodies and footers';