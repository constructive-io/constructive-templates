-- Deploy: schemas/myapp_user_identifiers_public/tables/phone_numbers/columns/created_at/column
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/phone_numbers/table


ALTER TABLE myapp_user_identifiers_public.phone_numbers 
  ADD COLUMN created_at timestamptz;

