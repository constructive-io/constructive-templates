-- Revert: schemas/myapp_auth_private/views/user_api_keys/rules/_insert_rule/rule


DROP RULE IF EXISTS _insert_rule ON myapp_auth_private.user_api_keys;


