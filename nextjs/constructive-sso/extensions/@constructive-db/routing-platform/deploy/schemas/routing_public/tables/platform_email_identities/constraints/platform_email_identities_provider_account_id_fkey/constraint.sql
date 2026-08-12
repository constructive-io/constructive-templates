-- Deploy: schemas/routing_public/tables/platform_email_identities/constraints/platform_email_identities_provider_account_id_fkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_email_identities/table
-- requires: schemas/routing_public/tables/platform_email_provider_accounts/table


ALTER TABLE routing_public.platform_email_identities 
  ADD CONSTRAINT platform_email_identities_provider_account_id_fkey
    FOREIGN KEY(provider_account_id)
    REFERENCES routing_public.platform_email_provider_accounts (id)
    ON DELETE RESTRICT;