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
  ('019fbc96-8556-7ca0-ac7d-26b492f6544f', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-8533-7560-9eea-55dbc7f7fcee', 'users_username_chk', 'c', '{019fbc96-8552-7c53-8c92-5ad667e6d165}', '{"A_Expr":{"kind":"AEXPR_OP","name":[{"String":{"sval":"<="}}],"lexpr":{"FuncCall":{"args":[{"ColumnRef":{"fields":[{"String":{"sval":"username"}}]}}],"funcname":[{"String":{"sval":"character_length"}}]}},"rexpr":{"A_Const":{"ival":256}}}}', false, false, NULL, 'app', '{}'),
  ('019fbc96-8564-76d6-bbd9-e8cd40e8d4f3', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-8533-7560-9eea-55dbc7f7fcee', 'users_display_name_chk', 'c', '{019fbc96-8561-7835-9a4c-568e906ec2e6}', '{"A_Expr":{"kind":"AEXPR_OP","name":[{"String":{"sval":"<="}}],"lexpr":{"FuncCall":{"args":[{"ColumnRef":{"fields":[{"String":{"sval":"display_name"}}]}}],"funcname":[{"String":{"sval":"character_length"}}]}},"rexpr":{"A_Const":{"ival":256}}}}', false, false, NULL, 'app', '{}'),
  ('019fbc96-8680-729b-9f88-35fd5679a5fb', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-865b-7f26-a4f8-32df18a9e0ae', 'app_permissions_bitnum_chk', 'c', '{019fbc96-867d-7070-9d38-27dda4bbdec8}', '{"BoolExpr":{"args":[{"A_Expr":{"kind":"AEXPR_OP","name":[{"String":{"sval":">="}}],"lexpr":{"ColumnRef":{"fields":[{"String":{"sval":"bitnum"}}]}},"rexpr":{"A_Const":{"ival":1}}}},{"A_Expr":{"kind":"AEXPR_OP","name":[{"String":{"sval":"<="}}],"lexpr":{"ColumnRef":{"fields":[{"String":{"sval":"bitnum"}}]}},"rexpr":{"A_Const":{"ival":64}}}}],"boolop":"AND_EXPR"}}', false, false, NULL, 'app', '{}'),
  ('019fbc96-93fb-7aa3-a507-9a0594a53689', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-93c9-79f2-8dcb-8d72b5725eaa', 'org_permissions_bitnum_chk', 'c', '{019fbc96-93f7-7561-8ea2-a61685c18c0d}', '{"BoolExpr":{"args":[{"A_Expr":{"kind":"AEXPR_OP","name":[{"String":{"sval":">="}}],"lexpr":{"ColumnRef":{"fields":[{"String":{"sval":"bitnum"}}]}},"rexpr":{"A_Const":{"ival":1}}}},{"A_Expr":{"kind":"AEXPR_OP","name":[{"String":{"sval":"<="}}],"lexpr":{"ColumnRef":{"fields":[{"String":{"sval":"bitnum"}}]}},"rexpr":{"A_Const":{"ival":64}}}}],"boolop":"AND_EXPR"}}', false, false, NULL, 'app', '{}'),
  ('019fbc96-a73c-7050-aa17-dd36e15e80da', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-a679-7751-89c9-def7076eb2dc', 'org_chart_edges_child_id_parent_id_chk', 'c', '{019fbc96-a6df-7bea-8786-790764ec62d2,019fbc96-a6f6-7ef2-bcd8-4536a73cc649}', '{"A_Expr":{"kind":"AEXPR_OP","name":[{"String":{"sval":"<>"}}],"lexpr":{"ColumnRef":{"fields":[{"String":{"sval":"child_id"}}]}},"rexpr":{"ColumnRef":{"fields":[{"String":{"sval":"parent_id"}}]}}}}', false, false, NULL, 'app', '{}'),
  ('019fbc96-cdfd-7440-aba2-93c76143c595', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-cbfa-72b5-bec3-82d33e693371', 'app_invites_channel_email_phone_chk', 'c', '{019fbc96-cc37-7cbd-a6b0-6c091efd67b4,019fbc96-cc58-78bc-a672-7794e8640aff,019fbc96-cc6f-73fc-a580-4eb59548d2a1}', '{"BoolExpr":{"args":[{"A_Expr":{"kind":"AEXPR_OP","name":[{"String":{"sval":"<>"}}],"lexpr":{"ColumnRef":{"fields":[{"String":{"sval":"channel"}}]}},"rexpr":{"A_Const":{"sval":"sms"}}}},{"NullTest":{"arg":{"ColumnRef":{"fields":[{"String":{"sval":"phone"}}]}},"nulltesttype":"IS_NOT_NULL"}}],"boolop":"OR_EXPR"}}', false, false, NULL, 'app', '{}'),
  ('019fbc96-cec6-7fb3-9370-5b106c216a31', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-ce07-7cb4-8a74-36d41e6de69f', 'app_claimed_invites_sender_id_receiver_id_chk', 'c', '{019fbc96-ce55-7221-a370-6ef4a5b06101,019fbc96-ce65-7314-9b59-e2b7a99ec557}', '{"A_Expr":{"kind":"AEXPR_OP","name":[{"String":{"sval":"<>"}}],"lexpr":{"ColumnRef":{"fields":[{"String":{"sval":"sender_id"}}]}},"rexpr":{"ColumnRef":{"fields":[{"String":{"sval":"receiver_id"}}]}}}}', false, false, NULL, 'app', '{}'),
  ('019fbc96-d20e-7796-922f-308fa6c29c63', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-cf7f-7041-9b02-6402219dc422', 'org_invites_channel_email_phone_chk', 'c', '{019fbc96-cfb9-7b3a-8974-de8e7549d6bd,019fbc96-cfe0-75c4-ab10-7d422f22a07e,019fbc96-cff9-75d4-bc5a-37aa75e521ab}', '{"BoolExpr":{"args":[{"A_Expr":{"kind":"AEXPR_OP","name":[{"String":{"sval":"<>"}}],"lexpr":{"ColumnRef":{"fields":[{"String":{"sval":"channel"}}]}},"rexpr":{"A_Const":{"sval":"sms"}}}},{"NullTest":{"arg":{"ColumnRef":{"fields":[{"String":{"sval":"phone"}}]}},"nulltesttype":"IS_NOT_NULL"}}],"boolop":"OR_EXPR"}}', false, false, NULL, 'app', '{}'),
  ('019fbc96-d2e5-77a2-9367-4ca2d6af4525', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-d218-741e-9bc2-e59d1d1a7edd', 'org_claimed_invites_sender_id_receiver_id_chk', 'c', '{019fbc96-d26f-7697-a170-1be9075d0d79,019fbc96-d27f-74ed-934a-146feb0eea92}', '{"A_Expr":{"kind":"AEXPR_OP","name":[{"String":{"sval":"<>"}}],"lexpr":{"ColumnRef":{"fields":[{"String":{"sval":"sender_id"}}]}},"rexpr":{"ColumnRef":{"fields":[{"String":{"sval":"receiver_id"}}]}}}}', false, false, NULL, 'app', '{}');


SET session_replication_role TO DEFAULT;


