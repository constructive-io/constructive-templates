-- Deploy: schemas/myapp_auth_private/procedures/sign_up_identity/grants/anonymous
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/procedures/sign_up_identity/procedure


GRANT EXECUTE ON FUNCTION myapp_auth_private.sign_up_identity TO anonymous;

