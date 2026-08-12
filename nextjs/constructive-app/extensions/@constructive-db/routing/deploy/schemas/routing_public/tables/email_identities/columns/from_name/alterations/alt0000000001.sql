-- Deploy: schemas/routing_public/tables/email_identities/columns/from_name/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/email_identities/columns/from_name/column


COMMENT ON COLUMN routing_public.email_identities.from_name IS 'Display name shown beside the from address';