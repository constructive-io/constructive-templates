-- Verify: schemas/myapp_memberships_private/tables/app_memberships_sprt/indexes/app_memberships_sprts_actor_id_idx


SELECT assert_index('myapp_memberships_private.app_memberships_sprts_actor_id_idx'::regclass, 'myapp_memberships_private.app_memberships_sprt'::regclass, true);


