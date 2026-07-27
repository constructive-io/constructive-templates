-- Revert: schemas/myapp_user_identifiers_public/tables/phone_numbers/columns/is_primary/alterations/alt0000000001


ALTER TABLE myapp_user_identifiers_public.phone_numbers 
  ALTER COLUMN is_primary DROP NOT NULL;


