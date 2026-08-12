-- Deploy: schemas/routing_public/tables/email_identities/columns/transport_mode/alterations/alt0000000004
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/email_identities/table
-- requires: schemas/routing_public/tables/email_identities/columns/transport_mode/column
-- requires: schemas/routing_public/tables/email_identities/columns/provider_account_id/column


ALTER TABLE routing_public.email_identities 
  ADD CONSTRAINT email_identities_transport_mode_provider_account_id_chk 
    CHECK (
    (transport_mode = 'own'
      AND provider_account_id IS NOT NULL)
      OR (transport_mode = 'platform_shared'
      AND provider_account_id IS NULL)
  );