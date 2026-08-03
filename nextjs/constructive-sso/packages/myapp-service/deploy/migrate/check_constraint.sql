-- Deploy: migrate/check_constraint
-- made with <3 @ constructive.io

-- requires: migrate/table


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
  ('019fc104-f319-7f86-93db-c74ea60c8dee', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f2f4-73b2-abcd-47aa47fa7997', 'users_username_chk', 'c', '{019fc104-f315-7ce3-9fe4-2862b2c9c1ae}', '{"A_Expr":{"kind":"AEXPR_OP","name":[{"String":{"sval":"<="}}],"lexpr":{"FuncCall":{"args":[{"ColumnRef":{"fields":[{"String":{"sval":"username"}}]}}],"funcname":[{"String":{"sval":"character_length"}}]}},"rexpr":{"A_Const":{"ival":256}}}}', false, false, NULL, 'app', '{}'),
  ('019fc104-f327-7ab8-946f-58898f620154', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f2f4-73b2-abcd-47aa47fa7997', 'users_display_name_chk', 'c', '{019fc104-f324-7b70-acd8-17a87d8086d2}', '{"A_Expr":{"kind":"AEXPR_OP","name":[{"String":{"sval":"<="}}],"lexpr":{"FuncCall":{"args":[{"ColumnRef":{"fields":[{"String":{"sval":"display_name"}}]}}],"funcname":[{"String":{"sval":"character_length"}}]}},"rexpr":{"A_Const":{"ival":256}}}}', false, false, NULL, 'app', '{}'),
  ('019fc104-f450-7f14-846a-be37116e1933', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f42b-7451-ad34-360101e6f0bb', 'app_permissions_bitnum_chk', 'c', '{019fc104-f44e-7273-837b-4fd5835d16bb}', '{"BoolExpr":{"args":[{"A_Expr":{"kind":"AEXPR_OP","name":[{"String":{"sval":">="}}],"lexpr":{"ColumnRef":{"fields":[{"String":{"sval":"bitnum"}}]}},"rexpr":{"A_Const":{"ival":1}}}},{"A_Expr":{"kind":"AEXPR_OP","name":[{"String":{"sval":"<="}}],"lexpr":{"ColumnRef":{"fields":[{"String":{"sval":"bitnum"}}]}},"rexpr":{"A_Const":{"ival":64}}}}],"boolop":"AND_EXPR"}}', false, false, NULL, 'app', '{}');


SET session_replication_role TO DEFAULT;


