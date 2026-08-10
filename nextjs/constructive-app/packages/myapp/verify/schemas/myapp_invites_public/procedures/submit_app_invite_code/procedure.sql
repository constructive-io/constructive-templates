-- Verify: schemas/myapp_invites_public/procedures/submit_app_invite_code/procedure


SELECT assert_function('myapp_invites_public.submit_app_invite_code(text)'::regprocedure, 'boolean'::regtype, false, true, 'VOLATILE');


