-- Verify: schemas/myapp_storage_public/tables/app_files/policies/auth_del_own/policy


SELECT verify_policy('auth_del_own', 'myapp_storage_public.app_files');


