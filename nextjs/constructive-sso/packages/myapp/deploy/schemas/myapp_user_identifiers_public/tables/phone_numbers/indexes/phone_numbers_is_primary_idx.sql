-- Deploy: schemas/myapp_user_identifiers_public/tables/phone_numbers/indexes/phone_numbers_is_primary_idx
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/phone_numbers/table
-- requires: schemas/myapp_user_identifiers_public/tables/phone_numbers/columns/owner_id/column
-- requires: schemas/myapp_user_identifiers_public/tables/phone_numbers/columns/is_primary/column


CREATE UNIQUE INDEX phone_numbers_is_primary_idx ON myapp_user_identifiers_public.phone_numbers ( is_primary, owner_id ) WHERE is_primary IS TRUE;

