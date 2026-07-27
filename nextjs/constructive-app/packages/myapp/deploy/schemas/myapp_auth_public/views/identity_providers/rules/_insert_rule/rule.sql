-- Deploy: schemas/myapp_auth_public/views/identity_providers/rules/_insert_rule/rule
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/views/identity_providers/view


CREATE RULE _insert_rule AS ON INSERT TO myapp_auth_public.identity_providers DO INSTEAD NOTHING;

