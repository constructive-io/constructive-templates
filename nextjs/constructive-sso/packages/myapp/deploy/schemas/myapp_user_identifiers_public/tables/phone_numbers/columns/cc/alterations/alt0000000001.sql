-- Deploy: schemas/myapp_user_identifiers_public/tables/phone_numbers/columns/cc/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/phone_numbers/table
-- requires: schemas/myapp_user_identifiers_public/tables/phone_numbers/columns/cc/column


ALTER TABLE myapp_user_identifiers_public.phone_numbers 
  ALTER COLUMN cc SET NOT NULL;

