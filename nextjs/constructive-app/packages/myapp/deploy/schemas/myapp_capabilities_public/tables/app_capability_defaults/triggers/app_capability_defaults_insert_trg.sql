-- Deploy: schemas/myapp_capabilities_public/tables/app_capability_defaults/triggers/app_capability_defaults_insert_trg
-- made with <3 @ constructive.io

-- requires: schemas/myapp_capabilities_public/schema
-- requires: schemas/myapp_capabilities_public/tables/app_capability_defaults/table


CREATE TRIGGER app_capability_defaults_insert_trg
BEFORE INSERT ON myapp_capabilities_public.app_capability_defaults
FOR EACH ROW
EXECUTE PROCEDURE utils.ensure_singleton ( );

