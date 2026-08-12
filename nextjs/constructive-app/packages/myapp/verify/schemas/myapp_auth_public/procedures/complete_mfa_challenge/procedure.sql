-- Verify: schemas/myapp_auth_public/procedures/complete_mfa_challenge/procedure


SELECT assert_function('myapp_auth_public.complete_mfa_challenge(uuid, text, text, text, text, boolean, boolean, text, text)'::regprocedure, 'record'::regtype, false, true, 'VOLATILE');


