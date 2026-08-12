-- Verify: schemas/myapp_auth_public/procedures/request_cross_origin_token/procedure


SELECT assert_function('myapp_auth_public.request_cross_origin_token(text, text, origin, boolean)'::regprocedure, 'text'::regtype, false, true, 'VOLATILE');


