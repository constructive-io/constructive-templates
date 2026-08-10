-- Deploy: schemas/myapp_auth_public/procedures/sign_in_sms_otp/grants/anonymous
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/procedures/sign_in_sms_otp/procedure


GRANT EXECUTE ON FUNCTION myapp_auth_public.sign_in_sms_otp TO anonymous;

