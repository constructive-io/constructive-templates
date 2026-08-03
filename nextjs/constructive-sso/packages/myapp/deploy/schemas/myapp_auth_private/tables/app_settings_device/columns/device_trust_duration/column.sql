-- Deploy: schemas/myapp_auth_private/tables/app_settings_device/columns/device_trust_duration/column
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/app_settings_device/table


ALTER TABLE myapp_auth_private.app_settings_device 
  ADD COLUMN device_trust_duration interval;

