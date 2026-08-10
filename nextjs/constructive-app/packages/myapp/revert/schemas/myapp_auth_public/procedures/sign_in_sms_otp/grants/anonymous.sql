-- Revert: schemas/myapp_auth_public/procedures/sign_in_sms_otp/grants/anonymous


REVOKE EXECUTE ON FUNCTION myapp_auth_public.sign_in_sms_otp FROM anonymous;


