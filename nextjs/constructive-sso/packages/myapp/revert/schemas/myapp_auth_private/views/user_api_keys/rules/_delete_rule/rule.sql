-- Revert: schemas/myapp_auth_private/views/user_api_keys/rules/_delete_rule/rule


DROP RULE IF EXISTS _delete_rule ON myapp_auth_private.user_api_keys;


