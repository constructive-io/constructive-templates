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
  ('019fa2a1-6109-767a-8bfc-f1bb29779a76', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5b92-7e43-b110-f1d39bc5ee19', 'user_sessions', '019fa2a1-5bbc-7d2a-a42f-af8235516fb4', 'ViewFilteredTable', '{"field_names":["id","user_id","auth_method","expires_at","revoked_at","origin","ip","uagent","fingerprint_mode","last_password_verified","last_mfa_verified","created_at","updated_at"],"filter_data":{"entity_field":"user_id"},"filter_type":"AuthzDirectOwner","source_table":"sessions","source_schema":"myapp_auth_private","source_table_id":"019fa2a1-5bbc-7d2a-a42f-af8235516fb4"}', NULL, '{}', true, false, NULL, true, NULL, 'app', '{}'),
  ('019fa2a1-6123-71cd-865e-c366636985f4', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5b92-7e43-b110-f1d39bc5ee19', 'user_api_keys', NULL, 'ViewComposite', '{"query_ast":{"SelectStmt":{"op":"SETOP_NONE","fromClause":[{"JoinExpr":{"larg":{"RangeVar":{"inh":true,"alias":{"Alias":{"aliasname":"sc"}},"relname":"session_credentials","schemaname":"myapp_auth_private","relpersistence":"p"}},"rarg":{"RangeVar":{"inh":true,"alias":{"Alias":{"aliasname":"s"}},"relname":"sessions","schemaname":"myapp_auth_private","relpersistence":"p"}},"quals":{"A_Expr":{"kind":"AEXPR_OP","name":[{"String":{"sval":"="}}],"lexpr":{"ColumnRef":{"fields":[{"String":{"sval":"s"}},{"String":{"sval":"id"}}]}},"rexpr":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"session_id"}}]}}}},"jointype":"JOIN_INNER"}}],"targetList":[{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"id"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"key_id"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"name"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"expires_at"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"revoked_at"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"last_used_at"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"org_id"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"mfa_level"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"access_level"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"created_at"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"updated_at"}}]}}}}],"whereClause":{"BoolExpr":{"args":[{"A_Expr":{"kind":"AEXPR_OP","name":[{"String":{"sval":"="}}],"lexpr":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"kind"}}]}},"rexpr":{"A_Const":{"sval":"api_key"}}}},{"A_Expr":{"kind":"AEXPR_OP","name":[{"String":{"sval":"="}}],"lexpr":{"ColumnRef":{"fields":[{"String":{"sval":"s"}},{"String":{"sval":"user_id"}}]}},"rexpr":{"FuncCall":{"funcname":[{"String":{"sval":"jwt_public"}},{"String":{"sval":"current_user_id"}}]}}}}],"boolop":"AND_EXPR"}}}}}', NULL, '{}', true, false, NULL, true, NULL, 'app', '{}'),
  ('019fa2a1-687b-7da2-9fdd-9d73f5d2db1e', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6722-709f-922e-d839fd79c906', 'app_internal_secrets', '019fa2a1-674f-73fa-9633-39edfbd13c6c', 'ViewTableProjection', '{"field_names":["id","name","namespace_id","description","labels","annotations","created_at","updated_at","rotated_at","retired_at"],"source_table":"app_internal_secrets","source_schema":"myapp_store_private","source_table_id":"019fa2a1-674f-73fa-9633-39edfbd13c6c"}', NULL, '{}', true, false, NULL, true, NULL, 'app', '{}'),
  ('019fa2a1-6de2-79f4-af72-b983ba08bf0f', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6946-7910-96e2-15c6e11fd525', 'user_connected_accounts', '019fa2a1-6d06-750a-9c65-845342800227', 'ViewFilteredTable', '{"field_names":["id","owner_id","service","identifier","details","is_verified","created_at","updated_at"],"filter_data":{"entity_field":"owner_id"},"filter_type":"AuthzDirectOwner","source_table":"connected_accounts","source_schema":"myapp_user_identifiers_private","source_table_id":"019fa2a1-6d06-750a-9c65-845342800227"}', NULL, '{}', true, false, NULL, true, NULL, 'app', '{}'),
  ('019fa2a1-6fdb-7e46-84b5-0b300d2c6f6e', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-68d3-7385-938c-1973d9bed8f2', 'identity_providers', '019fa2a1-6e03-77a5-8d95-46056bdd7ccf', 'ViewTableProjection', '{"field_names":["slug","kind","display_name","enabled"],"source_table":"identity_providers","source_schema":"myapp_auth_private","source_table_id":"019fa2a1-6e03-77a5-8d95-46056bdd7ccf"}', NULL, '{}', true, false, NULL, true, NULL, 'app', '{}');


SET session_replication_role TO DEFAULT;


