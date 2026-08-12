-- Deploy: schemas/myapp_auth_private/views/user_api_keys/rules/_delete_rule/rule
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/views/user_api_keys/view


CREATE RULE _delete_rule AS ON DELETE TO myapp_auth_private.user_api_keys DO INSTEAD NOTHING;

