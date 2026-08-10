-- Deploy: schemas/myapp_user_identifiers_public/tables/phone_numbers/columns/number/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/phone_numbers/columns/number/column


COMMENT ON COLUMN myapp_user_identifiers_public.phone_numbers.number IS E'The full number in E.164 form, country calling code included (e.g. +15551234567). This is the value SMS sign-in and MFA match, so it is unique across the table and constrained to that shape.';

