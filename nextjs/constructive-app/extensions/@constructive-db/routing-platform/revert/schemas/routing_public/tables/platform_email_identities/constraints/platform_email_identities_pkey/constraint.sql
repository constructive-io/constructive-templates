-- Revert: schemas/routing_public/tables/platform_email_identities/constraints/platform_email_identities_pkey/constraint


ALTER TABLE routing_public.platform_email_identities 
  DROP CONSTRAINT platform_email_identities_pkey RESTRICT;