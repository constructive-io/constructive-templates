-- Revert: schemas/routing_public/tables/email_site_identities/constraints/email_site_identities_pkey/constraint


ALTER TABLE routing_public.email_site_identities 
  DROP CONSTRAINT email_site_identities_pkey RESTRICT;