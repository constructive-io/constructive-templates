-- Deploy: schemas/routing_public/tables/email_identities/columns/is_active/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/email_identities/columns/is_active/column


COMMENT ON COLUMN routing_public.email_identities.is_active IS 'Whether this identity may be resolved for a send';