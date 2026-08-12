-- Revert: schemas/routing_public/tables/platform_email_identities/columns/from_address/alterations/alt0000000003


ALTER TABLE routing_public.platform_email_identities 
  DROP CONSTRAINT platform_email_identities_from_address_chk RESTRICT;