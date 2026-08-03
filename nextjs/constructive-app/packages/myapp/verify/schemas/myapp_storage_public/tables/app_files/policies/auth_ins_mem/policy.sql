-- Verify: schemas/myapp_storage_public/tables/app_files/policies/auth_ins_mem/policy


SELECT verify_policy('auth_ins_mem', 'myapp_storage_public.app_files');


