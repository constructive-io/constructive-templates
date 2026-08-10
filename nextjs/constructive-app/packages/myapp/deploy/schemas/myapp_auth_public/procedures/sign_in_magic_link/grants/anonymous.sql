-- Deploy: schemas/myapp_auth_public/procedures/sign_in_magic_link/grants/anonymous
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/procedures/sign_in_magic_link/procedure


GRANT EXECUTE ON FUNCTION myapp_auth_public.sign_in_magic_link TO anonymous;

