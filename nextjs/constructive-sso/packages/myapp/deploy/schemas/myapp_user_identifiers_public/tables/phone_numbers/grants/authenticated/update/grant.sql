-- Deploy: schemas/myapp_user_identifiers_public/tables/phone_numbers/grants/authenticated/update/grant
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/phone_numbers/table


GRANT UPDATE (is_primary, name) ON myapp_user_identifiers_public.phone_numbers TO authenticated;

