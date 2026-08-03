-- Verify: schemas/myapp_storage_public/tables/app_files/policies/auth_del_esc_del/policy


SELECT verify_policy('auth_del_esc_del', 'myapp_storage_public.app_files');


