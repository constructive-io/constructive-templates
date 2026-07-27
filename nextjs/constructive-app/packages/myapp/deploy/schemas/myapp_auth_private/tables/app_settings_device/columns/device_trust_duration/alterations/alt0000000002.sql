-- Deploy: schemas/myapp_auth_private/tables/app_settings_device/columns/device_trust_duration/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/app_settings_device/table
-- requires: schemas/myapp_auth_private/tables/app_settings_device/columns/device_trust_duration/column


ALTER TABLE myapp_auth_private.app_settings_device 
  ALTER COLUMN device_trust_duration SET DEFAULT '30 days'::interval;

