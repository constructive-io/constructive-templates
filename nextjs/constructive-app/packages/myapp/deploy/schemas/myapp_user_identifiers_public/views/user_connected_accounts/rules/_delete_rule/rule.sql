-- Deploy: schemas/myapp_user_identifiers_public/views/user_connected_accounts/rules/_delete_rule/rule
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/views/user_connected_accounts/view


CREATE RULE _delete_rule AS ON DELETE TO myapp_user_identifiers_public.user_connected_accounts DO INSTEAD NOTHING;

