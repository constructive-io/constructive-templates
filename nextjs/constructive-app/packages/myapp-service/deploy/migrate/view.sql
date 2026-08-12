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
  ('019feb75-87c0-719e-8ed0-edba70fd3ce1', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8695-7e24-8b0b-8db166cbaf4a', 'user_sessions', '019feb75-869f-77e5-b1bd-2954e3f87b89', 'ViewFilteredTable', '{"field_names":["id","user_id","auth_method","expires_at","revoked_at","origin","ip","uagent","fingerprint_mode","last_password_verified","last_mfa_verified","last_idp_verified","created_at","updated_at"],"filter_data":{"entity_field":"user_id"},"filter_type":"AuthzDirectOwner","source_table":"sessions","source_schema":"myapp_auth_private","source_table_id":"019feb75-869f-77e5-b1bd-2954e3f87b89"}', NULL, '{}', true, false, NULL, true, NULL, 'app', '{}'),
  ('019feb75-87cc-7dcd-9a63-a483ec264440', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8695-7e24-8b0b-8db166cbaf4a', 'user_api_keys', NULL, 'ViewComposite', '{"query_ast":{"SelectStmt":{"op":"SETOP_NONE","fromClause":[{"JoinExpr":{"larg":{"RangeVar":{"inh":true,"alias":{"Alias":{"aliasname":"sc"}},"relname":"session_credentials","schemaname":"myapp_auth_private","relpersistence":"p"}},"rarg":{"RangeVar":{"inh":true,"alias":{"Alias":{"aliasname":"s"}},"relname":"sessions","schemaname":"myapp_auth_private","relpersistence":"p"}},"quals":{"A_Expr":{"kind":"AEXPR_OP","name":[{"String":{"sval":"="}}],"lexpr":{"ColumnRef":{"fields":[{"String":{"sval":"s"}},{"String":{"sval":"id"}}]}},"rexpr":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"session_id"}}]}}}},"jointype":"JOIN_INNER"}}],"targetList":[{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"id"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"key_id"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"name"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"expires_at"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"revoked_at"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"last_used_at"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"org_id"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"mfa_level"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"access_level"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"created_at"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"updated_at"}}]}}}}],"whereClause":{"BoolExpr":{"args":[{"A_Expr":{"kind":"AEXPR_OP","name":[{"String":{"sval":"="}}],"lexpr":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"kind"}}]}},"rexpr":{"A_Const":{"sval":"api_key"}}}},{"A_Expr":{"kind":"AEXPR_OP","name":[{"String":{"sval":"="}}],"lexpr":{"ColumnRef":{"fields":[{"String":{"sval":"s"}},{"String":{"sval":"user_id"}}]}},"rexpr":{"SubLink":{"subselect":{"SelectStmt":{"op":"SETOP_NONE","targetList":[{"ResTarget":{"val":{"FuncCall":{"funcname":[{"String":{"sval":"jwt_public"}},{"String":{"sval":"current_user_id"}}]}}}}]}},"subLinkType":"EXPR_SUBLINK"}}}}],"boolop":"AND_EXPR"}}}}}', NULL, '{}', true, false, NULL, true, NULL, 'app', '{}'),
  ('019feb75-89ae-72d5-b03b-8773c41c571f', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-895b-7b97-b98f-01b51196320f', 'app_internal_secrets', '019feb75-8966-7ecd-bc75-e2778b51a789', 'ViewTableProjection', '{"field_names":["id","name","realm","namespace_id","description","labels","annotations","created_at","updated_at","rotated_at","retired_at"],"source_table":"app_internal_secrets","source_schema":"myapp_store_private","source_table_id":"019feb75-8966-7ecd-bc75-e2778b51a789"}', NULL, '{}', true, false, NULL, true, NULL, 'app', '{}'),
  ('019feb75-8b74-7390-b746-225bdae365ce', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8a0e-7a45-8898-85dfd6f8e078', 'user_connected_accounts', '019feb75-8b42-77a4-83be-695a8efb04b9', 'ViewFilteredTable', '{"field_names":["id","owner_id","service","identifier","details","is_verified","created_at","updated_at"],"filter_data":{"entity_field":"owner_id"},"filter_type":"AuthzDirectOwner","source_table":"connected_accounts","source_schema":"myapp_user_identifiers_private","source_table_id":"019feb75-8b42-77a4-83be-695a8efb04b9"}', NULL, '{}', true, false, NULL, true, NULL, 'app', '{}'),
  ('019feb75-8bda-7193-ad61-35648599d0e3', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-89de-7d6c-a0e8-f04fbeb7d8d9', 'identity_providers', '019feb75-8b7e-7a85-9b53-09c3e40fc17e', 'ViewTableProjection', '{"field_names":["slug","kind","display_name","enabled"],"source_table":"identity_providers","source_schema":"myapp_auth_private","source_table_id":"019feb75-8b7e-7a85-9b53-09c3e40fc17e"}', NULL, '{}', true, false, NULL, true, NULL, 'app', '{}'),
  ('019feb75-922c-73db-91d7-934470e13412', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-89de-7d6c-a0e8-f04fbeb7d8d9', 'org_api_key_list', NULL, 'ViewComposite', '{"query_ast":{"SelectStmt":{"op":"SETOP_NONE","fromClause":[{"RangeVar":{"inh":true,"alias":{"Alias":{"aliasname":"sc"}},"relname":"session_credentials","schemaname":"myapp_auth_private","relpersistence":"p"}}],"targetList":[{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"id"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"key_id"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"name"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"principal_id"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"org_id"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"expires_at"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"revoked_at"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"last_used_at"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"mfa_level"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"access_level"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"created_at"}}]}}}},{"ResTarget":{"val":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"updated_at"}}]}}}}],"whereClause":{"BoolExpr":{"args":[{"A_Expr":{"kind":"AEXPR_OP","name":[{"String":{"sval":"="}}],"lexpr":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"kind"}}]}},"rexpr":{"A_Const":{"sval":"api_key"}}}},{"NullTest":{"arg":{"ColumnRef":{"fields":[{"String":{"sval":"sc"}},{"String":{"sval":"org_id"}}]}},"nulltesttype":"IS_NOT_NULL"}}],"boolop":"AND_EXPR"}}}}}', NULL, '{}', true, false, NULL, true, NULL, 'app', '{}');


SET session_replication_role TO DEFAULT;


