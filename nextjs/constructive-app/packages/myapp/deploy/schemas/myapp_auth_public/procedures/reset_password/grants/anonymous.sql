-- Deploy: schemas/myapp_auth_public/procedures/reset_password/grants/anonymous
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/procedures/reset_password/procedure


GRANT EXECUTE ON FUNCTION myapp_auth_public.reset_password TO anonymous;

