-- Verify: schemas/myapp_capabilities_public/tables/org_capability_defaults/indexes/org_capability_defaults_entity_id_idx


SELECT assert_index('myapp_capabilities_public.org_capability_defaults_entity_id_idx'::regclass, 'myapp_capabilities_public.org_capability_defaults'::regclass, false);


