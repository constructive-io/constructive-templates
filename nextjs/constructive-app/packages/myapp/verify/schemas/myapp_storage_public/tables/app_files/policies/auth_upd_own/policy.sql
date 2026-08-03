-- Verify: schemas/myapp_storage_public/tables/app_files/policies/auth_upd_own/policy


SELECT verify_policy('auth_upd_own', 'myapp_storage_public.app_files');


