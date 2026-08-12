-- Deploy: schemas/myapp_auth_private/tables/app_settings_device/constraints/app_settings_devices_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/app_settings_device/table


ALTER TABLE myapp_auth_private.app_settings_device 
  ADD CONSTRAINT app_settings_devices_pkey PRIMARY KEY (id);

