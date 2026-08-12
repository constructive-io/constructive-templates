-- Verify: schemas/myapp_capabilities_public/tables/org_capabilities/triggers/org_capabilities_insert_trg


SELECT assert_trigger('myapp_capabilities_public.org_capabilities'::regclass, 'org_capabilities_insert_trg', 'myapp_capabilities_private.org_capabilities_bitnum_tg'::regproc, 7);


