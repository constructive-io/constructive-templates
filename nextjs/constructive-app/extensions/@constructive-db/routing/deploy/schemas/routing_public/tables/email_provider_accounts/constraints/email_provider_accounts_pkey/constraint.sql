-- Deploy: schemas/routing_public/tables/email_provider_accounts/constraints/email_provider_accounts_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/email_provider_accounts/table


ALTER TABLE routing_public.email_provider_accounts 
  ADD CONSTRAINT email_provider_accounts_pkey PRIMARY KEY (id);