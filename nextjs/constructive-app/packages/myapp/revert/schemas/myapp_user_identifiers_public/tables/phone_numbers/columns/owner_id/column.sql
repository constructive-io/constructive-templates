-- Revert: schemas/myapp_user_identifiers_public/tables/phone_numbers/columns/owner_id/column


ALTER TABLE myapp_user_identifiers_public.phone_numbers 
  DROP COLUMN owner_id RESTRICT;


