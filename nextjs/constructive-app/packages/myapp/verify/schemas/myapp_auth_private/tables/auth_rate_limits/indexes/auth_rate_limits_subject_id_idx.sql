-- Verify: schemas/myapp_auth_private/tables/auth_rate_limits/indexes/auth_rate_limits_subject_id_idx


SELECT assert_index('myapp_auth_private.auth_rate_limits_subject_id_idx'::regclass, 'myapp_auth_private.auth_rate_limits'::regclass, false);


