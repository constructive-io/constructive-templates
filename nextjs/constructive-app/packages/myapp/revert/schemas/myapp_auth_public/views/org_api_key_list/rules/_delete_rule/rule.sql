-- Revert: schemas/myapp_auth_public/views/org_api_key_list/rules/_delete_rule/rule


DROP RULE IF EXISTS _delete_rule ON myapp_auth_public.org_api_key_list;


