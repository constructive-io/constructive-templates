-- Deploy: schemas/routing_public/tables/email_identities/columns/from_address/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/email_identities/table
-- requires: schemas/routing_public/tables/email_identities/columns/from_address/column


ALTER TABLE routing_public.email_identities 
  ADD CONSTRAINT email_identities_from_address_chk 
    CHECK (
    from_address = lower(from_address)
      AND from_address ~* E'^[^@[:space:]]+@[^@[:space:]]+\\.[^@[:space:]]+$'
  );