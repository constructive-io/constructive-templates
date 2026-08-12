-- Deploy: schemas/myapp_auth_public/views/identity_providers/rules/_update_rule/rule
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/views/identity_providers/view


CREATE RULE _update_rule AS ON UPDATE TO myapp_auth_public.identity_providers DO INSTEAD NOTHING;

