-- Revert: schemas/routing_public/tables/email_identities/columns/from_address/alterations/alt0000000003


ALTER TABLE routing_public.email_identities 
  DROP CONSTRAINT email_identities_from_address_chk RESTRICT;