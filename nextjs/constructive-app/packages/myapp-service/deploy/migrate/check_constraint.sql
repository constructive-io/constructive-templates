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
  ('019feb75-78f7-7e27-84a8-b26791a4707f', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-78e2-720e-82dc-c3ed84264ce8', 'users_username_chk', 'c', '{019feb75-78f6-7075-a739-65eaadd1baa3}', '{"A_Expr":{"kind":"AEXPR_OP","name":[{"String":{"sval":"<="}}],"lexpr":{"FuncCall":{"args":[{"ColumnRef":{"fields":[{"String":{"sval":"username"}}]}}],"funcname":[{"String":{"sval":"character_length"}}]}},"rexpr":{"A_Const":{"ival":256}}}}', false, false, NULL, 'app', '{}'),
  ('019feb75-78fe-70d1-b213-d1b95276f084', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-78e2-720e-82dc-c3ed84264ce8', 'users_display_name_chk', 'c', '{019feb75-78fd-722d-83cc-521d78e2c30b}', '{"A_Expr":{"kind":"AEXPR_OP","name":[{"String":{"sval":"<="}}],"lexpr":{"FuncCall":{"args":[{"ColumnRef":{"fields":[{"String":{"sval":"display_name"}}]}}],"funcname":[{"String":{"sval":"character_length"}}]}},"rexpr":{"A_Const":{"ival":256}}}}', false, false, NULL, 'app', '{}'),
  ('019feb75-798c-7dc5-b7d7-729c37e44ea4', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-797b-7fe2-bec7-40f720b33f6b', 'app_capabilities_bitnum_chk', 'c', '{019feb75-798b-7de5-a1d5-684c9bce7b7c}', '{"BoolExpr":{"args":[{"A_Expr":{"kind":"AEXPR_OP","name":[{"String":{"sval":">="}}],"lexpr":{"ColumnRef":{"fields":[{"String":{"sval":"bitnum"}}]}},"rexpr":{"A_Const":{"ival":1}}}},{"A_Expr":{"kind":"AEXPR_OP","name":[{"String":{"sval":"<="}}],"lexpr":{"ColumnRef":{"fields":[{"String":{"sval":"bitnum"}}]}},"rexpr":{"A_Const":{"ival":64}}}}],"boolop":"AND_EXPR"}}', false, false, NULL, 'app', '{}'),
  ('019feb75-7ef0-7139-ac8f-273b77b65201', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7ee2-77cd-aa83-c4d0fcd1a585', 'org_capabilities_bitnum_chk', 'c', '{019feb75-7eef-70d1-a6fa-04f2553d1156}', '{"BoolExpr":{"args":[{"A_Expr":{"kind":"AEXPR_OP","name":[{"String":{"sval":">="}}],"lexpr":{"ColumnRef":{"fields":[{"String":{"sval":"bitnum"}}]}},"rexpr":{"A_Const":{"ival":1}}}},{"A_Expr":{"kind":"AEXPR_OP","name":[{"String":{"sval":"<="}}],"lexpr":{"ColumnRef":{"fields":[{"String":{"sval":"bitnum"}}]}},"rexpr":{"A_Const":{"ival":64}}}}],"boolop":"AND_EXPR"}}', false, false, NULL, 'app', '{}'),
  ('019feb75-846e-7dfc-bc03-819ffb87b6da', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8440-7e28-b081-063629bcb1bb', 'org_chart_edges_child_id_parent_id_chk', 'c', '{019feb75-8457-7a72-a832-9cd78bf7b51b,019feb75-845c-76e2-93cc-dffbfed76fda}', '{"A_Expr":{"kind":"AEXPR_OP","name":[{"String":{"sval":"<>"}}],"lexpr":{"ColumnRef":{"fields":[{"String":{"sval":"child_id"}}]}},"rexpr":{"ColumnRef":{"fields":[{"String":{"sval":"parent_id"}}]}}}}', false, false, NULL, 'app', '{}'),
  ('019feb75-8aa5-7be7-b81c-3efbe61da83f', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8a82-79e3-8a0d-c9114b559299', 'phone_numbers_number_chk', 'c', '{019feb75-8a9a-732f-8851-03233cd3715c}', E'{"A_Expr":{"kind":"AEXPR_OP","name":[{"String":{"sval":"~"}}],"lexpr":{"ColumnRef":{"fields":[{"String":{"sval":"number"}}]}},"rexpr":{"A_Const":{"sval":"^\\\\+[1-9][0-9]{6,14}$"}}}}', false, false, NULL, 'app', '{}'),
  ('019feb75-8c59-7e63-beb5-15ee49cf687f', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8c00-72b9-b512-4719a73b24a5', 'app_invites_channel_email_phone_chk', 'c', '{019feb75-8c10-78aa-b979-fafb72c8cfe1,019feb75-8c16-75ce-bee4-7c7d30cb97af,019feb75-8c1f-72cb-b8c0-3c3ce408fe72}', '{"BoolExpr":{"args":[{"A_Expr":{"kind":"AEXPR_OP","name":[{"String":{"sval":"<>"}}],"lexpr":{"ColumnRef":{"fields":[{"String":{"sval":"channel"}}]}},"rexpr":{"A_Const":{"sval":"sms"}}}},{"NullTest":{"arg":{"ColumnRef":{"fields":[{"String":{"sval":"phone"}}]}},"nulltesttype":"IS_NOT_NULL"}}],"boolop":"OR_EXPR"}}', false, false, NULL, 'app', '{}'),
  ('019feb75-8c80-7eea-a59f-1b6b55b0e20d', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8c5c-78a0-a5bc-ac52a3e98db5', 'app_claimed_invites_sender_id_receiver_id_chk', 'c', '{019feb75-8c6a-73c6-a627-31aacfbe3b23,019feb75-8c6b-7a4b-a8c0-6b07dfa0dc7f}', '{"A_Expr":{"kind":"AEXPR_OP","name":[{"String":{"sval":"<>"}}],"lexpr":{"ColumnRef":{"fields":[{"String":{"sval":"sender_id"}}]}},"rexpr":{"ColumnRef":{"fields":[{"String":{"sval":"receiver_id"}}]}}}}', false, false, NULL, 'app', '{}'),
  ('019feb75-8d24-7c11-b618-504f1dc9e7fe', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8cc1-72cd-aaa8-39befebe8af8', 'org_invites_channel_email_phone_chk', 'c', '{019feb75-8ccd-726e-8ca9-840b0e00dea2,019feb75-8cd2-7eb7-bcc1-486a59d0e5f2,019feb75-8cdb-7fb1-886b-964c00cf3273}', '{"BoolExpr":{"args":[{"A_Expr":{"kind":"AEXPR_OP","name":[{"String":{"sval":"<>"}}],"lexpr":{"ColumnRef":{"fields":[{"String":{"sval":"channel"}}]}},"rexpr":{"A_Const":{"sval":"sms"}}}},{"NullTest":{"arg":{"ColumnRef":{"fields":[{"String":{"sval":"phone"}}]}},"nulltesttype":"IS_NOT_NULL"}}],"boolop":"OR_EXPR"}}', false, false, NULL, 'app', '{}'),
  ('019feb75-8d4b-7206-b1b9-da0b1efcdf71', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8d26-7dd5-8a1e-47949cbdb6a7', 'org_claimed_invites_sender_id_receiver_id_chk', 'c', '{019feb75-8d35-726b-bd94-35c86006f9b9,019feb75-8d36-7850-9dc9-cbb9584a8241}', '{"A_Expr":{"kind":"AEXPR_OP","name":[{"String":{"sval":"<>"}}],"lexpr":{"ColumnRef":{"fields":[{"String":{"sval":"sender_id"}}]}},"rexpr":{"ColumnRef":{"fields":[{"String":{"sval":"receiver_id"}}]}}}}', false, false, NULL, 'app', '{}');


SET session_replication_role TO DEFAULT;


