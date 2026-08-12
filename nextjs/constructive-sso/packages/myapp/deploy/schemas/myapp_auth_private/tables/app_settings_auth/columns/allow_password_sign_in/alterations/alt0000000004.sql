-- Deploy: schemas/myapp_auth_private/tables/app_settings_auth/columns/allow_password_sign_in/alterations/alt0000000004
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/app_settings_auth/columns/allow_password_sign_in/column


COMMENT ON COLUMN myapp_auth_private.app_settings_auth.allow_password_sign_in IS E'@has_guard
Whether email plus password sign-in is allowed';

