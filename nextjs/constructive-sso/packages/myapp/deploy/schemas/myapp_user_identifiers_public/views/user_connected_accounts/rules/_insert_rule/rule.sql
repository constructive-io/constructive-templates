-- Deploy: schemas/myapp_user_identifiers_public/views/user_connected_accounts/rules/_insert_rule/rule
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/views/user_connected_accounts/view


CREATE RULE _insert_rule AS ON INSERT TO myapp_user_identifiers_public.user_connected_accounts DO INSTEAD NOTHING;

