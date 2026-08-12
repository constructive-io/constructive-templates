-- Deploy: schemas/routing_public/tables/platform_email_provider_accounts/constraints/platform_email_provider_accounts_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_email_provider_accounts/table


ALTER TABLE routing_public.platform_email_provider_accounts 
  ADD CONSTRAINT platform_email_provider_accounts_pkey PRIMARY KEY (id);