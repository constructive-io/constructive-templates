-- Deploy: schemas/myapp_auth_private/tables/app_settings_device/alterations/fix0000000003
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/app_settings_device/table


INSERT INTO myapp_auth_private.app_settings_device (
  enable_device_tracking,
  enable_trusted_devices,
  device_trust_duration,
  require_mfa_new_device,
  require_device_approval,
  max_devices_per_user
)
VALUES
  ('true'::boolean, 'false'::boolean, '30 days'::interval, 'false'::boolean, 'false'::boolean, 50);

