-- Deploy: schemas/myapp_user_identifiers_public/tables/phone_numbers/columns/created_at/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/phone_numbers/table
-- requires: schemas/myapp_user_identifiers_public/tables/phone_numbers/columns/created_at/column


ALTER TABLE myapp_user_identifiers_public.phone_numbers 
  ALTER COLUMN created_at SET DEFAULT now();

