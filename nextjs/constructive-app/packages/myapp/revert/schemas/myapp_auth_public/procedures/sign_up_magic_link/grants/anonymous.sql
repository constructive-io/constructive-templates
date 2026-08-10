-- Revert: schemas/myapp_auth_public/procedures/sign_up_magic_link/grants/anonymous


REVOKE EXECUTE ON FUNCTION myapp_auth_public.sign_up_magic_link FROM anonymous;


