-- Deploy: schemas/myapp_user_identifiers_public/tables/phone_numbers/grants/authenticated/select/grant
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/phone_numbers/table


GRANT SELECT ON myapp_user_identifiers_public.phone_numbers TO authenticated;

