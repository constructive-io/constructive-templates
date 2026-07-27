-- Revert: schemas/myapp_user_identifiers_public/tables/phone_numbers/columns/cc/alterations/alt0000000001


ALTER TABLE myapp_user_identifiers_public.phone_numbers 
  ALTER COLUMN cc DROP NOT NULL;


