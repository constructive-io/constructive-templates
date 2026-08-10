-- Revert: schemas/routing_public/tables/email_identities/constraints/email_identities_pkey/constraint


ALTER TABLE routing_public.email_identities 
  DROP CONSTRAINT email_identities_pkey RESTRICT;