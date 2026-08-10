-- Deploy: schemas/myapp_user_identifiers_public/tables/phone_numbers/constraints/phone_numbers_owner_id_fkey/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/phone_numbers/constraints/phone_numbers_owner_id_fkey/constraint


COMMENT ON CONSTRAINT phone_numbers_owner_id_fkey ON myapp_user_identifiers_public.phone_numbers IS E'@foreignFieldName phoneNumbers';

