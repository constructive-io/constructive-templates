-- Deploy: schemas/myapp_user_identifiers_public/tables/phone_numbers/columns/cc/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/phone_numbers/columns/cc/column


COMMENT ON COLUMN myapp_user_identifiers_public.phone_numbers.cc IS E'Country calling code (e.g. +1, +44)';

