-- Deploy: schemas/routing_public/tables/email_identities/constraints/email_identities_provider_account_id_fkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/email_identities/table
-- requires: schemas/routing_public/tables/email_provider_accounts/table


ALTER TABLE routing_public.email_identities 
  ADD CONSTRAINT email_identities_provider_account_id_fkey
    FOREIGN KEY(provider_account_id)
    REFERENCES routing_public.email_provider_accounts (id)
    ON DELETE RESTRICT;