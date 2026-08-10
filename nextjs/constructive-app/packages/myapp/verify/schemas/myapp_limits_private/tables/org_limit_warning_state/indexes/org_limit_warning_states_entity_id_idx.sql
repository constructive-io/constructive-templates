-- Verify: schemas/myapp_limits_private/tables/org_limit_warning_state/indexes/org_limit_warning_states_entity_id_idx


SELECT assert_index('myapp_limits_private.org_limit_warning_states_entity_id_idx'::regclass, 'myapp_limits_private.org_limit_warning_state'::regclass, false);


