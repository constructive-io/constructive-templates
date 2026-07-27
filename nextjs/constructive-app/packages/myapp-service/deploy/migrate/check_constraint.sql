-- Deploy: migrate/check_constraint
-- made with <3 @ constructive.io

-- requires: migrate/site_themes


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

INSERT INTO metaschema_public.check_constraint (
  id,
  database_id,
  table_id,
  name,
  type,
  field_ids,
  expr,
  is_deferrable,
  initially_deferred,
  smart_tags,
  category,
  tags
) VALUES
  ('019fa2a1-5040-71e2-8de5-d9751321eb1b', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5022-77c8-9de2-2ef6079855de', 'users_username_chk', 'c', '{019fa2a1-503c-7fc0-a00a-4eb05fdea62f}', '{"A_Expr":{"kind":"AEXPR_OP","name":[{"String":{"sval":"<="}}],"lexpr":{"FuncCall":{"args":[{"ColumnRef":{"fields":[{"String":{"sval":"username"}}]}}],"funcname":[{"String":{"sval":"character_length"}}]}},"rexpr":{"A_Const":{"ival":256}}}}', false, false, NULL, 'app', '{}'),
  ('019fa2a1-504a-7ccc-9eb6-978c624f6b25', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5022-77c8-9de2-2ef6079855de', 'users_display_name_chk', 'c', '{019fa2a1-5048-7874-b9b6-ecb3b316d78c}', '{"A_Expr":{"kind":"AEXPR_OP","name":[{"String":{"sval":"<="}}],"lexpr":{"FuncCall":{"args":[{"ColumnRef":{"fields":[{"String":{"sval":"display_name"}}]}}],"funcname":[{"String":{"sval":"character_length"}}]}},"rexpr":{"A_Const":{"ival":256}}}}', false, false, NULL, 'app', '{}'),
  ('019fa2a1-5154-7fd3-9bf7-ca8dfe498491', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5131-7642-b999-a3637fd3f1a5', 'app_permissions_bitnum_chk', 'c', '{019fa2a1-5152-7696-944d-043fcc9a22b8}', '{"BoolExpr":{"args":[{"A_Expr":{"kind":"AEXPR_OP","name":[{"String":{"sval":">="}}],"lexpr":{"ColumnRef":{"fields":[{"String":{"sval":"bitnum"}}]}},"rexpr":{"A_Const":{"ival":1}}}},{"A_Expr":{"kind":"AEXPR_OP","name":[{"String":{"sval":"<="}}],"lexpr":{"ColumnRef":{"fields":[{"String":{"sval":"bitnum"}}]}},"rexpr":{"A_Const":{"ival":64}}}}],"boolop":"AND_EXPR"}}', false, false, NULL, 'app', '{}');


SET session_replication_role TO DEFAULT;


