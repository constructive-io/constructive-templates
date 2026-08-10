-- Verify: schemas/myapp_store_private/procedures/user_state_del/procedure/alterations/alt0000000001


SELECT assert_function('myapp_store_private.user_state_del(uuid, text[])'::regprocedure, 'void'::regtype, false, false, 'VOLATILE');


