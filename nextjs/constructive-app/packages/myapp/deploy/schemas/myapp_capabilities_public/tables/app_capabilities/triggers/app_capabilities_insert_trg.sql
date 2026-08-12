-- Deploy: schemas/myapp_capabilities_public/tables/app_capabilities/triggers/app_capabilities_insert_trg
-- made with <3 @ constructive.io

-- requires: schemas/myapp_capabilities_public/schema
-- requires: schemas/myapp_capabilities_private/schema
-- requires: schemas/myapp_capabilities_public/tables/app_capabilities/table
-- requires: schemas/myapp_capabilities_private/trigger_fns/app_capabilities_bitnum_tg


CREATE TRIGGER app_capabilities_insert_trg
BEFORE INSERT ON myapp_capabilities_public.app_capabilities
FOR EACH ROW
EXECUTE PROCEDURE myapp_capabilities_private.app_capabilities_bitnum_tg ( );

