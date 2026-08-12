-- Revert: schemas/myapp_auth_public/procedures/reset_password/grants/anonymous


REVOKE EXECUTE ON FUNCTION myapp_auth_public.reset_password FROM anonymous;


