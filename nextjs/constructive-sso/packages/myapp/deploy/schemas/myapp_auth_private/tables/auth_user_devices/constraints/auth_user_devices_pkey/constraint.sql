-- Deploy: schemas/myapp_auth_private/tables/auth_user_devices/constraints/auth_user_devices_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/auth_user_devices/table


ALTER TABLE myapp_auth_private.auth_user_devices 
  ADD CONSTRAINT auth_user_devices_pkey PRIMARY KEY (id);

