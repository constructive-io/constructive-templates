-- Deploy: schemas/myapp_user_identifiers_public/tables/phone_numbers/columns/number/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/phone_numbers/columns/number/column


COMMENT ON COLUMN myapp_user_identifiers_public.phone_numbers.number IS 'The phone number without country code';

