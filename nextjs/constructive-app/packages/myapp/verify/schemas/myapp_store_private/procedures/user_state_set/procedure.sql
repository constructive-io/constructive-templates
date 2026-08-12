-- Verify: schemas/myapp_store_private/procedures/user_state_set/procedure


SELECT assert_function('myapp_store_private.user_state_set(uuid, text, anyelement)'::regprocedure, 'void'::regtype, false, false, 'VOLATILE');


