-- Verify: schemas/myapp_auth_public/procedures/generate_backup_codes/procedure


SELECT assert_function('myapp_auth_public.generate_backup_codes()'::regprocedure, 'text'::regtype, false, true, 'VOLATILE');


