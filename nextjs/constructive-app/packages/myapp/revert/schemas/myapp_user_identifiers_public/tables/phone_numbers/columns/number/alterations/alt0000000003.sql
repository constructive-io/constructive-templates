-- Revert: schemas/myapp_user_identifiers_public/tables/phone_numbers/columns/number/alterations/alt0000000003


ALTER TABLE myapp_user_identifiers_public.phone_numbers 
  DROP CONSTRAINT phone_numbers_number_chk;


