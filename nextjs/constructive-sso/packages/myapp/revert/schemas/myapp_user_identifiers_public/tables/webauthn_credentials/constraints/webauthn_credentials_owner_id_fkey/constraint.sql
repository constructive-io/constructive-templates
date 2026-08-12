-- Revert: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/constraints/webauthn_credentials_owner_id_fkey/constraint


ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  DROP CONSTRAINT webauthn_credentials_owner_id_fkey;


