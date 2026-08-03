-- Deploy: schemas/routing_public/tables/webauthn_settings/columns/resident_key/alterations/alt0000000004
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/webauthn_settings/table
-- requires: schemas/routing_public/tables/webauthn_settings/columns/resident_key/column


ALTER TABLE routing_public.webauthn_settings 
  ADD CONSTRAINT webauthn_settings_resident_key_chk 
    CHECK (resident_key IN ('discouraged', 'preferred', 'required'));