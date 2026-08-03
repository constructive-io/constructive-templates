-- Deploy: schemas/myapp_user_identifiers_public/tables/phone_numbers/columns/is_primary/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/phone_numbers/table
-- requires: schemas/myapp_user_identifiers_public/tables/phone_numbers/columns/is_primary/column


ALTER TABLE myapp_user_identifiers_public.phone_numbers 
  ALTER COLUMN is_primary SET DEFAULT false;

