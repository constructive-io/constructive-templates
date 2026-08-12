-- Deploy: schemas/routing_public/tables/email_provider_accounts/indexes/email_provider_accounts_updated_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/email_provider_accounts/table
-- requires: schemas/routing_public/tables/email_provider_accounts/columns/updated_at/column


CREATE INDEX email_provider_accounts_updated_at_idx ON routing_public.email_provider_accounts (updated_at);