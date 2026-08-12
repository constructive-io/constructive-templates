-- Verify: schemas/myapp_store_private/procedures/user_state_get/procedure


SELECT assert_function('myapp_store_private.user_state_get(uuid, text, text)'::regprocedure, 'text'::regtype, false, false, 'STABLE');


