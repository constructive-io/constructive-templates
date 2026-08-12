-- Deploy: schemas/myapp_user_identifiers_public/tables/phone_numbers/columns/number/column
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/phone_numbers/table


ALTER TABLE myapp_user_identifiers_public.phone_numbers 
  ADD COLUMN number text;

