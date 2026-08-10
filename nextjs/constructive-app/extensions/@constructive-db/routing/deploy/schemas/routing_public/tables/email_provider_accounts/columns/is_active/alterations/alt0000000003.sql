-- Deploy: schemas/routing_public/tables/email_provider_accounts/columns/is_active/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/email_provider_accounts/columns/is_active/column


COMMENT ON COLUMN routing_public.email_provider_accounts.is_active IS 'Whether identities may send through this account. Disabling one row stops every identity that references it.';