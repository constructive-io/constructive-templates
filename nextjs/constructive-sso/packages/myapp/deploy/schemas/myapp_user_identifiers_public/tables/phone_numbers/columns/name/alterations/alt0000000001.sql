-- Deploy: schemas/myapp_user_identifiers_public/tables/phone_numbers/columns/name/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/phone_numbers/columns/name/column


COMMENT ON COLUMN myapp_user_identifiers_public.phone_numbers.name IS E'Optional user-provided label for this phone number (e.g. "Mobile", "Work").';

