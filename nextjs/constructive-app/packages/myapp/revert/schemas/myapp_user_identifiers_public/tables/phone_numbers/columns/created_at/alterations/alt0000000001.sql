-- Revert: schemas/myapp_user_identifiers_public/tables/phone_numbers/columns/created_at/alterations/alt0000000001


ALTER TABLE myapp_user_identifiers_public.phone_numbers 
  ALTER COLUMN created_at DROP DEFAULT;


