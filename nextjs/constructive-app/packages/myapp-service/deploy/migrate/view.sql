-- Deploy: migrate/view
-- made with <3 @ constructive.io

-- requires: migrate/unique_constraint


SET session_replication_role TO replica;
-- using replica in case we are deploying triggers to metaschema_public

-- unaccent, postgis affected and require grants
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public to public;

DO $LQLMIGRATION$
  DECLARE
  BEGIN

    EXECUTE format('GRANT CONNECT ON DATABASE %I TO %I', current_database(), 'app_user');
    EXECUTE format('GRANT CONNECT ON DATABASE %I TO %I', current_database(), 'app_admin');

  END;
$LQLMIGRATION$;

INSERT INTO metaschema_public.view (
  id,
  database_id,
  schema_id,
  name,
  table_id,
  view_type,
  data,
  filter_type,
  filter_data,
  security_invoker,
  security_barrier,
  check_option,
  is_read_only,
  smart_tags,
  category,
  tags
) VALUES
  ('019fbc96-b639-7c4f-8e7c-744b5346ac1e', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-ae06-75fc-96c3-df2484d13ce6', 'user_sessions', '019fbc96-ae3f-7843-8d56-55dc4da7a445', 'ViewFilteredTable', '{"field_names":["id","user_id","auth_method","expires_at","revoked_at","origin","ip","uagent","fingerprint_mode","last_password_verified","last_mfa_verified","last_idp_verified","created_at","updated_at"],"filter_data":{"entity_field":"user_id"},"filter_type":"AuthzDirectOwner","source_table":"sessions","source_schema":"myapp_auth_private","source_table_id":"019fbc96-ae3f-7843-8d56-55dc4da7a445"}', NULL, '{}', true, false, NULL, true, NULL, 'app', '{}'),
  ('019fbc96-b660-7cc4-977a-e31b757ef8b2', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-ae06-75fc-96c3-df2484d13ce6', 'user_api_keys', NULL, 'ViewComposite', '{"query_ast":{"SelectStmt":{"op":"SETOP_NONE","fromClause":[{"JoinExpr":{"larg":{"RangeVar":{"inh":true,"alias":{"Alias":{"aliasname":"sc"}},"relname":"session_credentials","schemaname":"myapp_auth_private","relpersistence":"p"}},"rarg":{"RangeVar":{"inh":true,"alias":{"Alias":{"aliasname":"s"}},"relname":"sessions","schemaname":"myapp_auth_private","relpersistence":"p"}},"quals":{"A_Expr":{"kind":"AEXPR_OP","name":[{"String":{"sval":"="}}],"lexpr":{"ColumnRef":{"fields":[{"String":{"sval":"s"}},{"String":{"sval":"id"}}]}},"rexpr":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"session_id"}}]}}}},"jointype":"JOIN_INNER"}}],"targetList":[{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"id"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"key_id"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"name"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"expires_at"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"revoked_at"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"last_used_at"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"org_id"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"mfa_level"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"access_level"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"created_at"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"updated_at"}}]}}}}],"whereClause":{"BoolExpr":{"args":[{"A_Expr":{"kind":"AEXPR_OP","name":[{"String":{"sval":"="}}],"lexpr":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"kind"}}]}},"rexpr":{"A_Const":{"sval":"api_key"}}}},{"A_Expr":{"kind":"AEXPR_OP","name":[{"String":{"sval":"="}}],"lexpr":{"ColumnRef":{"fields":[{"String":{"sval":"s"}},{"String":{"sval":"user_id"}}]}},"rexpr":{"FuncCall":{"funcname":[{"String":{"sval":"jwt_public"}},{"String":{"sval":"current_user_id"}}]}}}}],"boolop":"AND_EXPR"}}}}}', NULL, '{}', true, false, NULL, true, NULL, 'app', '{}'),
  ('019fbc96-c0ba-7f88-a2dc-e9e346eb1902', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-beef-7f41-8222-679237757808', 'app_internal_secrets', '019fbc96-bf36-74c5-8ebc-0fda254875cd', 'ViewTableProjection', '{"field_names":["id","name","namespace_id","description","labels","annotations","created_at","updated_at","rotated_at","retired_at"],"source_table":"app_internal_secrets","source_schema":"myapp_store_private","source_table_id":"019fbc96-bf36-74c5-8ebc-0fda254875cd"}', NULL, '{}', true, false, NULL, true, NULL, 'app', '{}'),
  ('019fbc96-c862-701b-9ee6-d65f38de3b9a', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-c1c4-7d76-8017-c296fd0375c5', 'user_connected_accounts', '019fbc96-c73d-7bb7-945b-3e60ebd7f19a', 'ViewFilteredTable', '{"field_names":["id","owner_id","service","identifier","details","is_verified","created_at","updated_at"],"filter_data":{"entity_field":"owner_id"},"filter_type":"AuthzDirectOwner","source_table":"connected_accounts","source_schema":"myapp_user_identifiers_private","source_table_id":"019fbc96-c73d-7bb7-945b-3e60ebd7f19a"}', NULL, '{}', true, false, NULL, true, NULL, 'app', '{}'),
  ('019fbc96-cb2f-7488-a3f5-e0f742bd511e', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-c130-7558-9bec-78482a963cfe', 'identity_providers', '019fbc96-c88d-7ba5-bce4-cfcf39ec99a4', 'ViewTableProjection', '{"field_names":["slug","kind","display_name","enabled"],"source_table":"identity_providers","source_schema":"myapp_auth_private","source_table_id":"019fbc96-c88d-7ba5-bce4-cfcf39ec99a4"}', NULL, '{}', true, false, NULL, true, NULL, 'app', '{}'),
  ('019fbc96-ddb8-785f-9297-c8f1a1540c35', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-c130-7558-9bec-78482a963cfe', 'org_api_key_list', NULL, 'ViewComposite', '{"query_ast":{"SelectStmt":{"op":"SETOP_NONE","fromClause":[{"RangeVar":{"inh":true,"alias":{"Alias":{"aliasname":"sc"}},"relname":"session_credentials","schemaname":"myapp_auth_private","relpersistence":"p"}}],"targetList":[{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"id"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"key_id"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"name"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"principal_id"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"org_id"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"expires_at"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"revoked_at"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"last_used_at"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"mfa_level"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"access_level"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"created_at"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"updated_at"}}]}}}}],"whereClause":{"BoolExpr":{"args":[{"A_Expr":{"kind":"AEXPR_OP","name":[{"String":{"sval":"="}}],"lexpr":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"kind"}}]}},"rexpr":{"A_Const":{"sval":"api_key"}}}},{"NullTest":{"arg":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"org_id"}}]}},"nulltesttype":"IS_NOT_NULL"}}],"boolop":"AND_EXPR"}}}}}', NULL, '{}', true, false, NULL, true, NULL, 'app', '{}');


SET session_replication_role TO DEFAULT;


