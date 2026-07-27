-- Deploy: schemas/myapp_store_public/views/app_internal_secrets/rules/_insert_rule/rule
-- made with <3 @ constructive.io

-- requires: schemas/myapp_store_public/schema
-- requires: schemas/myapp_store_public/views/app_internal_secrets/view


CREATE RULE _insert_rule AS ON INSERT TO myapp_store_public.app_internal_secrets DO INSTEAD NOTHING;

