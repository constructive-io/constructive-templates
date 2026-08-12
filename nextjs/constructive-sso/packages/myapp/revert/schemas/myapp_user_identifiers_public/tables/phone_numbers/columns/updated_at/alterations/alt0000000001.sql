-- Revert: schemas/myapp_user_identifiers_public/tables/phone_numbers/columns/updated_at/alterations/alt0000000001


ALTER TABLE myapp_user_identifiers_public.phone_numbers 
  ALTER COLUMN updated_at DROP DEFAULT;


