-- Deploy: schemas/myapp_user_identifiers_public/tables/phone_numbers/columns/cc/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/phone_numbers/columns/cc/column


COMMENT ON COLUMN myapp_user_identifiers_public.phone_numbers.cc IS E'Country calling code the number was entered under (e.g. +1, +44). Display only: `number` already carries it, and sign-in matches `number`.';

