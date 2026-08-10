-- Verify: schemas/myapp_auth_public/procedures/link_identity/procedure


SELECT assert_function('myapp_auth_public.link_identity(text, text, jsonb)'::regprocedure, 'boolean'::regtype, false, true, 'VOLATILE');


