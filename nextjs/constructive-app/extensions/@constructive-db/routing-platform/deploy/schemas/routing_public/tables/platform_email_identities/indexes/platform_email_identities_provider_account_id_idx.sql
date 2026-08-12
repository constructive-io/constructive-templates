-- Deploy: schemas/routing_public/tables/platform_email_identities/indexes/platform_email_identities_provider_account_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_email_identities/table
-- requires: schemas/routing_public/tables/platform_email_identities/columns/provider_account_id/column


CREATE INDEX platform_email_identities_provider_account_id_idx ON routing_public.platform_email_identities (provider_account_id);