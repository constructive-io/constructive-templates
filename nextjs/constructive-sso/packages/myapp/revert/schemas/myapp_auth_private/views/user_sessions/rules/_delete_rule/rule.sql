-- Revert: schemas/myapp_auth_private/views/user_sessions/rules/_delete_rule/rule


DROP RULE IF EXISTS _delete_rule ON myapp_auth_private.user_sessions;


