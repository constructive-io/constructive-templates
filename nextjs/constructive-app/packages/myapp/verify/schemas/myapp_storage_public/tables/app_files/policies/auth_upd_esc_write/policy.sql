-- Verify: schemas/myapp_storage_public/tables/app_files/policies/auth_upd_esc_write/policy


SELECT verify_policy('auth_upd_esc_write', 'myapp_storage_public.app_files');


