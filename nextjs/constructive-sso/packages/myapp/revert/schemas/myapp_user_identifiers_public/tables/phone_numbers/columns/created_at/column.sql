-- Revert: schemas/myapp_user_identifiers_public/tables/phone_numbers/columns/created_at/column


ALTER TABLE myapp_user_identifiers_public.phone_numbers 
  DROP COLUMN created_at RESTRICT;


