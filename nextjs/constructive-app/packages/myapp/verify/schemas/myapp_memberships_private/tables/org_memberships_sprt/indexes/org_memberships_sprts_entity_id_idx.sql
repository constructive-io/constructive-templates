-- Verify: schemas/myapp_memberships_private/tables/org_memberships_sprt/indexes/org_memberships_sprts_entity_id_idx


SELECT assert_index('myapp_memberships_private.org_memberships_sprts_entity_id_idx'::regclass, 'myapp_memberships_private.org_memberships_sprt'::regclass, false);


