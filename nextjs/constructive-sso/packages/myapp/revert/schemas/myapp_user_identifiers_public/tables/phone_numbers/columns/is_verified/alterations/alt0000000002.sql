-- Revert: schemas/myapp_user_identifiers_public/tables/phone_numbers/columns/is_verified/alterations/alt0000000002


ALTER TABLE myapp_user_identifiers_public.phone_numbers 
  ALTER COLUMN is_verified DROP DEFAULT;


