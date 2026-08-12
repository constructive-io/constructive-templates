-- Deploy: schemas/myapp_auth_public/procedures/sign_up/grants/anonymous
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/procedures/sign_up/procedure


GRANT EXECUTE ON FUNCTION myapp_auth_public.sign_up TO anonymous;

