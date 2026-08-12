-- Deploy: schemas/myapp_auth_public/procedures/sign_in/grants/anonymous
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/procedures/sign_in/procedure


GRANT EXECUTE ON FUNCTION myapp_auth_public.sign_in TO anonymous;

