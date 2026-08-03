-- Revert: schemas/myapp_user_identifiers_public/tables/phone_numbers/columns/number/alterations/alt0000000001


ALTER TABLE myapp_user_identifiers_public.phone_numbers 
  ALTER COLUMN number DROP NOT NULL;


