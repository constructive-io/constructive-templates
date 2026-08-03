-- Deploy: schemas/myapp_auth_public/views/org_api_key_list/rules/_insert_rule/rule
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/views/org_api_key_list/view


CREATE RULE _insert_rule AS ON INSERT TO myapp_auth_public.org_api_key_list DO INSTEAD NOTHING;

