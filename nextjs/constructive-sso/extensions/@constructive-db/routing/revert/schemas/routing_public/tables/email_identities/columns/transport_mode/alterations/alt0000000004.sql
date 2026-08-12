-- Revert: schemas/routing_public/tables/email_identities/columns/transport_mode/alterations/alt0000000004


ALTER TABLE routing_public.email_identities 
  DROP CONSTRAINT email_identities_transport_mode_provider_account_id_chk RESTRICT;