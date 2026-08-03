-- Deploy: schemas/myapp_user_identifiers_public/tables/phone_numbers/columns/is_verified/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/phone_numbers/columns/is_verified/column


COMMENT ON COLUMN myapp_user_identifiers_public.phone_numbers.is_verified IS 'Whether the phone number has been verified via SMS code';

