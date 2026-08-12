-- Deploy: schemas/routing_public/tables/email_provider_accounts/columns/name/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/email_provider_accounts/columns/name/column


COMMENT ON COLUMN routing_public.email_provider_accounts.name IS 'Operator-facing name for this account (e.g. transactional, marketing)';