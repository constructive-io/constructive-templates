-- Revert: schemas/myapp_auth_public/views/identity_providers/rules/_delete_rule/rule


DROP RULE IF EXISTS _delete_rule ON myapp_auth_public.identity_providers;


