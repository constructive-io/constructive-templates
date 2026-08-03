-- Deploy: schemas/myapp_auth_public/views/org_api_key_list/rules/_delete_rule/rule
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/views/org_api_key_list/view


CREATE RULE _delete_rule AS ON DELETE TO myapp_auth_public.org_api_key_list DO INSTEAD NOTHING;

