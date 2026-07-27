-- Deploy: schemas/myapp_user_identifiers_public/views/user_connected_accounts/grants/authenticated/SELECT/grant
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/views/user_connected_accounts/view


GRANT SELECT ON myapp_user_identifiers_public.user_connected_accounts TO authenticated;

