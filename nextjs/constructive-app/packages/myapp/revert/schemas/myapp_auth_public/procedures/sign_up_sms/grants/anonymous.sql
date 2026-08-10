-- Revert: schemas/myapp_auth_public/procedures/sign_up_sms/grants/anonymous


REVOKE EXECUTE ON FUNCTION myapp_auth_public.sign_up_sms FROM anonymous;


