-- Deploy: schemas/routing_public/tables/platform_email_identities/constraints/platform_email_identities_name_key/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_email_identities/table


ALTER TABLE routing_public.platform_email_identities 
  ADD CONSTRAINT platform_email_identities_name_key 
    UNIQUE (name);