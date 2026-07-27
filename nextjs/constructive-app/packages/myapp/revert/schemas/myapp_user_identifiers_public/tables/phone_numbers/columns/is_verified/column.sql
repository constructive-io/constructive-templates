-- Revert: schemas/myapp_user_identifiers_public/tables/phone_numbers/columns/is_verified/column


ALTER TABLE myapp_user_identifiers_public.phone_numbers 
  DROP COLUMN is_verified RESTRICT;


