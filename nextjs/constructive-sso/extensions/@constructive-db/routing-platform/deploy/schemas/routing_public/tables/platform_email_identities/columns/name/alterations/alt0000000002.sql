-- Deploy: schemas/routing_public/tables/platform_email_identities/columns/name/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_email_identities/columns/name/column


COMMENT ON COLUMN routing_public.platform_email_identities.name IS 'Operator-facing name for this identity (e.g. transactional, support)';