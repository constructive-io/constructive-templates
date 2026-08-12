-- Deploy: schemas/myapp_user_identifiers_public/tables/phone_numbers/columns/number/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/phone_numbers/table
-- requires: schemas/myapp_user_identifiers_public/tables/phone_numbers/columns/number/column


ALTER TABLE myapp_user_identifiers_public.phone_numbers 
  ADD CONSTRAINT phone_numbers_number_chk 
    CHECK (number ~ '^\+[1-9][0-9]{6,14}$');

