-- Deploy: schemas/myapp_user_identifiers_public/tables/phone_numbers/indexes/phone_numbers_owner_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/phone_numbers/table
-- requires: schemas/myapp_user_identifiers_public/tables/phone_numbers/columns/owner_id/column


CREATE INDEX phone_numbers_owner_id_idx ON myapp_user_identifiers_public.phone_numbers USING BTREE ( owner_id );

