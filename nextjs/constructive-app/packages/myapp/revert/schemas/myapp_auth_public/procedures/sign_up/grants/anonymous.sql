-- Revert: schemas/myapp_auth_public/procedures/sign_up/grants/anonymous


REVOKE EXECUTE ON FUNCTION myapp_auth_public.sign_up FROM anonymous;


