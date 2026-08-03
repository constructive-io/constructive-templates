-- Deploy: schemas/myapp_limits_private/tables/app_limit_warning_state/indexes/app_limit_warning_states_actor_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/myapp_limits_private/schema
-- requires: schemas/myapp_limits_private/tables/app_limit_warning_state/table
-- requires: schemas/myapp_limits_private/tables/app_limit_warning_state/columns/actor_id/column


CREATE INDEX app_limit_warning_states_actor_id_idx ON myapp_limits_private.app_limit_warning_state USING BTREE ( actor_id );

