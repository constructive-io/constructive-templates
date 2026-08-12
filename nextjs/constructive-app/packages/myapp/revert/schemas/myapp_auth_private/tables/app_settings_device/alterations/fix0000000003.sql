-- Revert: schemas/myapp_auth_private/tables/app_settings_device/alterations/fix0000000003


DELETE FROM myapp_auth_private.app_settings_device
WHERE
  enable_device_tracking = 'true'::boolean AND enable_trusted_devices = 'false'::boolean AND device_trust_duration = '30 days'::interval AND require_mfa_new_device = 'false'::boolean AND require_device_approval = 'false'::boolean AND max_devices_per_user = 50;


