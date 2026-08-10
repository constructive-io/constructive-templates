-- Deploy: schemas/myapp_users_public/tables/user_settings_security/indexes/user_settings_security_created_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/myapp_users_public/schema
-- requires: schemas/myapp_users_public/tables/user_settings_security/table
-- requires: schemas/myapp_users_public/tables/user_settings_security/columns/created_at/column


CREATE INDEX user_settings_security_created_at_idx ON myapp_users_public.user_settings_security ( created_at );

