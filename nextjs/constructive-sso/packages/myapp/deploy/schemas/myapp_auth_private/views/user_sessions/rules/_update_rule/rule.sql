-- Deploy: schemas/myapp_auth_private/views/user_sessions/rules/_update_rule/rule
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/views/user_sessions/view


CREATE RULE _update_rule AS ON UPDATE TO myapp_auth_private.user_sessions DO INSTEAD NOTHING;

