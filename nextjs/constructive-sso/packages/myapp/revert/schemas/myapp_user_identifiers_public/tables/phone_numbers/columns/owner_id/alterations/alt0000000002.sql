-- Revert: schemas/myapp_user_identifiers_public/tables/phone_numbers/columns/owner_id/alterations/alt0000000002


ALTER TABLE myapp_user_identifiers_public.phone_numbers 
  ALTER COLUMN owner_id DROP DEFAULT;


