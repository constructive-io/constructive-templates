-- Deploy: schemas/myapp_auth_public/procedures/forgot_password/grants/anonymous
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/procedures/forgot_password/procedure


GRANT EXECUTE ON FUNCTION myapp_auth_public.forgot_password TO anonymous;

