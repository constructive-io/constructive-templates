-- Revert: schemas/myapp_user_identifiers_public/tables/phone_numbers/columns/number/column


ALTER TABLE myapp_user_identifiers_public.phone_numbers 
  DROP COLUMN number RESTRICT;


