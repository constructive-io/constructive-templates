-- Revert: schemas/myapp_auth_public/procedures/forgot_password/grants/anonymous


REVOKE EXECUTE ON FUNCTION myapp_auth_public.forgot_password FROM anonymous;


