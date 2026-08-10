-- Revert: schemas/myapp_auth_public/procedures/sign_in_cross_origin/grants/anonymous


REVOKE EXECUTE ON FUNCTION myapp_auth_public.sign_in_cross_origin FROM anonymous;


