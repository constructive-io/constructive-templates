-- Revert: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/id/alterations/alt0000000001


ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ALTER COLUMN id DROP NOT NULL;


