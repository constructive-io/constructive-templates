-- Deploy: schemas/myapp_user_identifiers_public/views/user_connected_accounts/rules/_update_rule/rule
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/views/user_connected_accounts/view


CREATE RULE _update_rule AS ON UPDATE TO myapp_user_identifiers_public.user_connected_accounts DO INSTEAD NOTHING;

