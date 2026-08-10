-- Deploy: schemas/routing_public/tables/email_site_identities/constraints/email_site_identities_email_identity_id_fkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/email_identities/table
-- requires: schemas/routing_public/tables/email_site_identities/table


ALTER TABLE routing_public.email_site_identities 
  ADD CONSTRAINT email_site_identities_email_identity_id_fkey
    FOREIGN KEY(email_identity_id)
    REFERENCES routing_public.email_identities (id)
    ON DELETE RESTRICT;