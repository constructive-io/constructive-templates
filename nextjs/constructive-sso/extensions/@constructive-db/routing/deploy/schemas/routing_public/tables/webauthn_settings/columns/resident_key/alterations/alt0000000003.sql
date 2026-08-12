-- Deploy: schemas/routing_public/tables/webauthn_settings/columns/resident_key/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/webauthn_settings/columns/resident_key/column


COMMENT ON COLUMN routing_public.webauthn_settings.resident_key IS 'Resident key requirement (discouraged, preferred, required)';