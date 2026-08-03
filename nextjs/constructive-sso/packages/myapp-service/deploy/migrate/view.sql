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
  ('019fc105-043c-703f-97e3-f65e06053632', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fee2-7758-ae40-4fdc60702a9e', 'user_sessions', '019fc104-ff05-737a-9287-9dc91676dc85', 'ViewFilteredTable', '{"field_names":["id","user_id","auth_method","expires_at","revoked_at","origin","ip","uagent","fingerprint_mode","last_password_verified","last_mfa_verified","last_idp_verified","created_at","updated_at"],"filter_data":{"entity_field":"user_id"},"filter_type":"AuthzDirectOwner","source_table":"sessions","source_schema":"myapp_auth_private","source_table_id":"019fc104-ff05-737a-9287-9dc91676dc85"}', NULL, '{}', true, false, NULL, true, NULL, 'app', '{}'),
  ('019fc105-0457-767b-9580-e8e1c84666db', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fee2-7758-ae40-4fdc60702a9e', 'user_api_keys', NULL, 'ViewComposite', '{"query_ast":{"SelectStmt":{"op":"SETOP_NONE","fromClause":[{"JoinExpr":{"larg":{"RangeVar":{"inh":true,"alias":{"Alias":{"aliasname":"sc"}},"relname":"session_credentials","schemaname":"myapp_auth_private","relpersistence":"p"}},"rarg":{"RangeVar":{"inh":true,"alias":{"Alias":{"aliasname":"s"}},"relname":"sessions","schemaname":"myapp_auth_private","relpersistence":"p"}},"quals":{"A_Expr":{"kind":"AEXPR_OP","name":[{"String":{"sval":"="}}],"lexpr":{"ColumnRef":{"fields":[{"String":{"sval":"s"}},{"String":{"sval":"id"}}]}},"rexpr":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"session_id"}}]}}}},"jointype":"JOIN_INNER"}}],"targetList":[{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"id"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"key_id"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"name"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"expires_at"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"revoked_at"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"last_used_at"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"org_id"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"mfa_level"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"access_level"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"created_at"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"updated_at"}}]}}}}],"whereClause":{"BoolExpr":{"args":[{"A_Expr":{"kind":"AEXPR_OP","name":[{"String":{"sval":"="}}],"lexpr":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"kind"}}]}},"rexpr":{"A_Const":{"sval":"api_key"}}}},{"A_Expr":{"kind":"AEXPR_OP","name":[{"String":{"sval":"="}}],"lexpr":{"ColumnRef":{"fields":[{"String":{"sval":"s"}},{"String":{"sval":"user_id"}}]}},"rexpr":{"SubLink":{"subselect":{"SelectStmt":{"op":"SETOP_NONE","targetList":[{"ResTarget":{"val":{"FuncCall":{"funcname":[{"String":{"sval":"jwt_public"}},{"String":{"sval":"current_user_id"}}]}}}}]}},"subLinkType":"EXPR_SUBLINK"}}}}],"boolop":"AND_EXPR"}}}}}', NULL, '{}', true, false, NULL, true, NULL, 'app', '{}'),
  ('019fc105-0bc6-738a-aefc-cde2c076c90b', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0a5d-726d-81e3-16720f03bcfa', 'app_internal_secrets', '019fc105-0a8c-74f6-873c-134a7419f69c', 'ViewTableProjection', '{"field_names":["id","name","namespace_id","description","labels","annotations","created_at","updated_at","rotated_at","retired_at"],"source_table":"app_internal_secrets","source_schema":"myapp_store_private","source_table_id":"019fc105-0a8c-74f6-873c-134a7419f69c"}', NULL, '{}', true, false, NULL, true, NULL, 'app', '{}'),
  ('019fc105-114e-7a87-a64a-c3691f4580d1', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0c8d-72ee-983e-7d7c1610c7f5', 'user_connected_accounts', '019fc105-106d-7a9f-9f9f-9b50b89450ca', 'ViewFilteredTable', '{"field_names":["id","owner_id","service","identifier","details","is_verified","created_at","updated_at"],"filter_data":{"entity_field":"owner_id"},"filter_type":"AuthzDirectOwner","source_table":"connected_accounts","source_schema":"myapp_user_identifiers_private","source_table_id":"019fc105-106d-7a9f-9f9f-9b50b89450ca"}', NULL, '{}', true, false, NULL, true, NULL, 'app', '{}'),
  ('019fc105-135e-7fa7-b267-683833e57104', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0c1b-7bde-9736-c30b1029bcc9', 'identity_providers', '019fc105-1171-72ca-849a-5ad7ac0b2fd3', 'ViewTableProjection', '{"field_names":["slug","kind","display_name","enabled"],"source_table":"identity_providers","source_schema":"myapp_auth_private","source_table_id":"019fc105-1171-72ca-849a-5ad7ac0b2fd3"}', NULL, '{}', true, false, NULL, true, NULL, 'app', '{}');


SET session_replication_role TO DEFAULT;


