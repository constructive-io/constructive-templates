-- Deploy: schemas/myapp_auth_private/views/user_sessions/rules/_insert_rule/rule
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/views/user_sessions/view


CREATE RULE _insert_rule AS ON INSERT TO myapp_auth_private.user_sessions DO INSTEAD NOTHING;

