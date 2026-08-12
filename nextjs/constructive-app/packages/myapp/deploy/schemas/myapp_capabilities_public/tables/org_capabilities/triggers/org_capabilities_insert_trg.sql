-- Deploy: schemas/myapp_capabilities_public/tables/org_capabilities/triggers/org_capabilities_insert_trg
-- made with <3 @ constructive.io

-- requires: schemas/myapp_capabilities_public/schema
-- requires: schemas/myapp_capabilities_private/schema
-- requires: schemas/myapp_capabilities_public/tables/org_capabilities/table
-- requires: schemas/myapp_capabilities_private/trigger_fns/org_capabilities_bitnum_tg


CREATE TRIGGER org_capabilities_insert_trg
BEFORE INSERT ON myapp_capabilities_public.org_capabilities
FOR EACH ROW
EXECUTE PROCEDURE myapp_capabilities_private.org_capabilities_bitnum_tg ( );

