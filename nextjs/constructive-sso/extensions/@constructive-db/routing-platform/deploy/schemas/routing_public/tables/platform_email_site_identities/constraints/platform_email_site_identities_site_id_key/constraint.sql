-- Deploy: schemas/routing_public/tables/platform_email_site_identities/constraints/platform_email_site_identities_site_id_key/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_email_site_identities/table


ALTER TABLE routing_public.platform_email_site_identities 
  ADD CONSTRAINT platform_email_site_identities_site_id_key 
    UNIQUE (site_id);