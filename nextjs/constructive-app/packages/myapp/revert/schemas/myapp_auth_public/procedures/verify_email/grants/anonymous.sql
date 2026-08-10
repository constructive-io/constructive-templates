-- Revert: schemas/myapp_auth_public/procedures/verify_email/grants/anonymous


REVOKE EXECUTE ON FUNCTION myapp_auth_public.verify_email FROM anonymous;


