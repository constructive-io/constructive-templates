-- Deploy: schemas/myapp_auth_public/procedures/verify_email/grants/anonymous
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/procedures/verify_email/procedure


GRANT EXECUTE ON FUNCTION myapp_auth_public.verify_email TO anonymous;

