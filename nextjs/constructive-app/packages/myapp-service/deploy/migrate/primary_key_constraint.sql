-- Deploy: migrate/primary_key_constraint
-- made with <3 @ constructive.io

-- requires: migrate/policy


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

INSERT INTO metaschema_public.primary_key_constraint (
  id,
  database_id,
  table_id,
  name,
  type,
  field_ids,
  without_overlaps,
  is_deferrable,
  initially_deferred,
  smart_tags,
  category,
  tags
) VALUES
  ('019fbc96-854c-7f11-b562-37f3393d0c17', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-8533-7560-9eea-55dbc7f7fcee', 'users_pkey', 'p', '{019fbc96-853f-7cdd-bd7b-0a711b156d2f}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-858f-7988-92f4-1a941ebffffa', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-8583-7576-a215-4812842342ee', 'role_types_pkey', 'p', '{019fbc96-858a-718c-825d-1802d129cfe9}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-85ff-78b9-a9c0-4fedef60f6ac', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-85ec-719f-bba7-dec8314cc52c', 'membership_types_pkey', 'p', '{019fbc96-85f7-7da2-85c3-b81412abd3dc}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-866e-7925-b754-f8f4d31845e5', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-865b-7f26-a4f8-32df18a9e0ae', 'app_permissions_pkey', 'p', '{019fbc96-8665-7eab-88fd-73596e3a7574}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-86be-7a90-9bb0-12bf5c69bb6f', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-86b0-7700-97e1-d05bfdc3b002', 'app_permission_defaults_pkey', 'p', '{019fbc96-86b8-7373-a787-595a85e9adce}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-8717-71ec-8139-ba1c38d43380', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-8702-7a94-9e81-560580adcaeb', 'app_limits_pkey', 'p', '{019fbc96-870d-7cc2-8a51-b0aaf2035dae}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-877c-7e48-b3e5-90bd21c3f701', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-876c-7f34-b3b2-19c7fbae3f4f', 'app_limit_defaults_pkey', 'p', '{019fbc96-8775-7893-9a53-e834b658b57e}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-87bc-7495-a721-6b1f28d8c806', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-87ad-7092-9b9c-f79aae366d47', 'app_limit_credits_pkey', 'p', '{019fbc96-87b5-7283-8340-2913ee08d747}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-8860-72e6-8d7a-37493cb0fd74', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-8810-7f7a-8805-483397318795', 'app_limit_events_pkey', 'p', '{019fbc96-8825-7bc3-a3a5-10962f5132d2,019fbc96-881c-72dd-afc3-b28d58aab999}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-88b3-7493-b7b3-21abc31c5907', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-88a2-7bb3-a792-7deab9133c17', 'app_limit_credit_codes_pkey', 'p', '{019fbc96-88ab-7a57-b6db-a8fda72eb43e}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-88f7-7caf-b11c-c259095a8763', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-88e4-7573-883d-6076b169c481', 'app_limit_credit_code_items_pkey', 'p', '{019fbc96-88ed-7f05-9343-29c98a022803}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-894b-7f27-8a65-d8f3f2d3b23c', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-893b-70db-9825-27d695d8acfe', 'app_limit_credit_redemptions_pkey', 'p', '{019fbc96-8943-7d94-a4fb-ce9072f7f47b}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-8996-7ce5-95dc-3dd50b6ac5f8', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-8985-7211-b337-533f1418ea53', 'app_limit_caps_defaults_pkey', 'p', '{019fbc96-898e-7825-b4bf-f70063b34d06}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-89c9-7fc3-8ba0-d9e30c7ed396', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-89b5-7647-9922-f83e63461d5e', 'app_limit_caps_pkey', 'p', '{019fbc96-89bf-7fad-b2c5-3d7c0c2d989d}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-8a0b-7373-9f31-03ceac6c11ce', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-89f9-77bd-ada7-8458562dae38', 'app_limit_warnings_pkey', 'p', '{019fbc96-8a02-7e97-91d0-7b5bfc3f8360}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-8a47-7ab6-80f3-12d615dc5ccd', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-8a36-72d6-9f45-a72f2e3d7f45', 'app_limit_warning_states_pkey', 'p', '{019fbc96-8a3f-7627-a81a-af9e1ef7ea31}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-8abf-7c01-bc31-d82162f5e0fd', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-8aa7-7512-9409-53c9aa016b84', 'app_memberships_pkey', 'p', '{019fbc96-8ab4-7774-a355-8e3b47952d00}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-8afd-7b36-8fbd-bdf48991e25b', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-8aea-7ad4-a849-ea060bfc84a5', 'app_membership_defaults_pkey', 'p', '{019fbc96-8af4-7f91-855d-360f648d0130}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-8c2e-7441-be5a-7881f7100931', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-8c19-7c0a-9052-1768cd93e552', 'app_admin_grants_pkey', 'p', '{019fbc96-8c25-707b-88ef-9dc03b6ddd70}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-8c8d-7719-97b2-7b0ac32bcd42', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-8c78-70da-8715-a89c618f1459', 'app_owner_grants_pkey', 'p', '{019fbc96-8c83-79e0-bfe6-fd22552096c1}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-8cf8-7889-b2db-df8e474553d3', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-8ce4-71cd-ad47-bef8de02e070', 'app_grants_pkey', 'p', '{019fbc96-8cef-72af-be03-197bc1acf751}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-8d60-7169-a73c-9c57d8ae8c3e', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-8d4b-7d3e-b20b-ecb9ad31487d', 'app_permission_default_permissions_pkey', 'p', '{019fbc96-8d56-78a2-9766-6ea6b2eac385}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-8da3-7261-9100-459b2058c1a6', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-8d8e-751f-a300-15e48f2b766f', 'app_permission_default_grants_pkey', 'p', '{019fbc96-8d99-7104-b486-4a1e5d982ef1}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-8e98-77bc-8b33-485bcbbb7bef', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-8e7e-7b0d-8c4a-b7c306b27a4e', 'app_profiles_pkey', 'p', '{019fbc96-8e8b-7a4e-a992-1068d53549a0}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-8f25-7f47-9712-93786a65c831', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-8f0f-7a36-991e-55003b1a091b', 'app_profile_permissions_pkey', 'p', '{019fbc96-8f1a-7b83-9262-1148afa78495}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-8f86-76cf-816e-b3ee0a7193ba', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-8f6f-7dbc-bda7-38e596c2f2a8', 'app_profile_grants_pkey', 'p', '{019fbc96-8f7a-7fc9-ad33-46eee42630de}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-8ffd-7c39-af7d-6106bb0faaee', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-8fe6-75fe-811a-e81911dcf9c4', 'app_profile_definition_grants_pkey', 'p', '{019fbc96-8ff2-79fe-a51a-c3fcaa05302e}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-90af-7f2d-b075-2243af4dba74', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-9098-7c7b-a3d2-0a6ca2ae13dd', 'app_profile_templates_pkey', 'p', '{019fbc96-90a4-799c-b31d-6dd4961acb61}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-93e3-732d-bde6-c0c1aee29c73', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-93c9-79f2-8dcb-8d72b5725eaa', 'org_permissions_pkey', 'p', '{019fbc96-93d6-76ff-a753-870537f7953e}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-945a-7214-9d21-55010e76d076', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-943e-7ea4-b55b-ac4ad60ff0e9', 'org_permission_defaults_pkey', 'p', '{019fbc96-944b-70f8-b30d-ed1f5ef79398}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-94a8-7910-949d-07badd739636', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-948e-7191-adb1-ab09ac90689e', 'org_limits_pkey', 'p', '{019fbc96-949b-7b0c-9a58-cffb157c9d4d}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-955b-727e-9886-db3bd83d60e1', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-9542-74ef-b1d3-8502bfd69283', 'org_limit_defaults_pkey', 'p', '{019fbc96-954f-7224-8a5d-d042d246f2f3}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-95b8-770a-96b3-b102f75376bb', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-959d-75a6-bdfd-d5a0fe1321f3', 'org_limit_credits_pkey', 'p', '{019fbc96-95aa-7077-ab19-433d63dc981d}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-966d-744c-ae3c-a872a444dc49', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-9653-7e0d-9ee8-3eaed61a69d2', 'org_limit_aggregates_pkey', 'p', '{019fbc96-9660-7de4-96b3-a4bae25ace7a}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-97b7-7dd6-871a-99ffae6ab5d5', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-9731-7e68-81d5-1e8a9e273d88', 'org_limit_events_pkey', 'p', '{019fbc96-9753-7c74-a977-c33258050050,019fbc96-9741-7c08-9d4d-55819fddb0fe}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-9829-7349-844d-605f90c40362', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-980d-74f0-ae5e-9ff54538f26e', 'org_limit_caps_defaults_pkey', 'p', '{019fbc96-981b-767e-94c8-38e15c2fa6d9}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-9872-72de-982b-96623ea22b1b', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-9855-783c-b950-9c834283e3c8', 'org_limit_caps_pkey', 'p', '{019fbc96-9864-71e7-bc5d-d21c89dab538}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-98de-7f1d-be14-c10f2bb59c9d', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-98c4-7744-8d5a-86dd9eb2b9eb', 'org_limit_warnings_pkey', 'p', '{019fbc96-98d1-7074-9c34-4a4c48f97cb2}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-9953-7eac-9070-75438d96bd5e', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-993a-79a3-a5c4-2758293cdd9b', 'org_limit_warning_states_pkey', 'p', '{019fbc96-9947-71a4-90aa-338aed98e07a}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-99d6-71ff-b9b7-4f86e48b1c16', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-99bc-7201-9cda-85df7f4524ad', 'org_memberships_pkey', 'p', '{019fbc96-99c8-7bca-868a-f3bb5962ace2}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-9a2a-7f72-963f-0aadfc54b01b', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-9a0f-7565-9c5b-19990520d73c', 'org_membership_defaults_pkey', 'p', '{019fbc96-9a1c-7ba5-9bcf-9cd346c5863c}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-9b2f-7131-bcce-a468dead318f', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-9b14-7a84-b273-cc96a45854b8', 'org_membership_settings_pkey', 'p', '{019fbc96-9b21-7d05-9dd7-46c002396b8b}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-9d29-7368-a141-d1b75f414f5f', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-9d0c-7703-9e77-3ad4e99213ab', 'org_members_pkey', 'p', '{019fbc96-9d1a-74c7-ae17-ed3bf0b7d5ab}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-9dfe-7731-a766-ad0e1ede587b', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-9de0-7944-9027-6aa06491ef19', 'org_admin_grants_pkey', 'p', '{019fbc96-9def-738c-b22e-768608aa2665}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-9ea4-7b88-a7de-1ac27c746413', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-9e82-73a2-b554-259d21eea97d', 'org_owner_grants_pkey', 'p', '{019fbc96-9e90-7ba4-997f-f2bc83e1e5bb}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-9f56-73f7-934e-0c19aa75b568', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-9f36-7e20-ac14-923b764c3ac4', 'org_member_profiles_pkey', 'p', '{019fbc96-9f46-705a-81aa-f955890c2916}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-a04c-7ad0-be5a-171ca48c80f3', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-a02d-7797-a968-a4f7aef00b4a', 'org_grants_pkey', 'p', '{019fbc96-a03b-7b69-98d5-1479bca92a55}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-a109-7a91-bc59-1f420089ae95', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-a0ea-7e5e-9a0b-1c224ef18e4e', 'org_permission_default_permissions_pkey', 'p', '{019fbc96-a0f9-7867-b652-deb01920a953}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-a19f-7c7c-96ef-e4a9c9f95149', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-a17b-7b9b-94d6-a303d8932007', 'org_permission_default_grants_pkey', 'p', '{019fbc96-a18d-7284-a194-85e3492f543c}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-a2b2-727a-8745-0bd57f779975', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-a293-7833-9a15-03f67f8888d1', 'org_profiles_pkey', 'p', '{019fbc96-a2a2-717a-8ed1-96bcbd87738f}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-a39a-7182-bf61-c4377ea465bb', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-a37a-7979-a78d-aec6597cf407', 'org_profile_permissions_pkey', 'p', '{019fbc96-a389-7496-9839-0e71e11799ba}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-a420-7cb1-bf3e-b58aafdedab7', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-a401-7297-aa81-80e925299b67', 'org_profile_grants_pkey', 'p', '{019fbc96-a410-7e79-97c9-af7e6cd71990}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-a4de-7c32-ad88-77fa45326f85', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-a4bb-72dd-a78e-bc606ec1fa92', 'org_profile_definition_grants_pkey', 'p', '{019fbc96-a4cd-7200-ba41-0bf90d5281c2}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-a5cb-7aec-bab5-6b6ac0b5ce87', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-a5ab-7844-9c3f-26f638f94b2d', 'org_profile_templates_pkey', 'p', '{019fbc96-a5bb-7213-9ffd-f543685edf8e}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-a69e-7223-91fc-33434d3adaa2', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-a679-7751-89c9-def7076eb2dc', 'org_chart_edges_pkey', 'p', '{019fbc96-a689-7f45-b7c2-9e52bf2ffbf1}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-a78f-7dba-8227-b748021efa13', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-a743-768f-b50d-25d599543ea0', 'org_hierarchy_sprts_pkey', 'p', '{019fbc96-a753-7148-a7b4-b239eb0ca4d0,019fbc96-a762-7ca7-af0e-60824e52f9bc,019fbc96-a772-7107-a374-7308513eff77}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-a7cf-718e-9ec9-e3f463f00d8f', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-a7ad-7938-b378-05541b782a3c', 'org_chart_edge_grants_pkey', 'p', '{019fbc96-a7bd-7c8b-818f-151178591772}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-adb8-7ba4-ae98-5c9f2a66eccd', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-ad5b-7116-9f79-d037fdc40cd9', 'user_states_pkey', 'p', '{019fbc96-ad6f-7040-82e0-20b323277308}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-ae67-7cfb-ac2d-aa113535ccce', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-ae3f-7843-8d56-55dc4da7a445', 'sessions_pkey', 'p', '{019fbc96-ae53-757f-a025-00761c2c54f1}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-afa2-7ec7-9808-0832e430bcb8', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-af80-75e3-9b05-4a449fcabc73', 'session_credentials_pkey', 'p', '{019fbc96-af91-73cf-bc34-736290fd8b93}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-b0ed-7541-8eff-12d2d4df8c23', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-b0c6-757d-a948-e13949bc1c55', 'app_settings_auths_pkey', 'p', '{019fbc96-b0da-7af6-9995-0d4d8476cdda}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-b6ac-7cd5-b030-437332b1fc81', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-b686-765d-895b-6bf64df652aa', 'session_secrets_pkey', 'p', '{019fbc96-b699-7563-b0cd-bf135c6c4ca3}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-b787-7e07-8378-454ac901a222', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-b760-738f-a87f-3b906bd93536', 'app_settings_rate_limits_pkey', 'p', '{019fbc96-b773-71bc-a00c-6ed8f51aaacd}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-b91a-758f-b83f-8ec0d7aa0f9a', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-b8f2-702a-b172-48e604ef0185', 'auth_ip_rate_limits_pkey', 'p', '{019fbc96-b904-7813-995d-df80cd7818e9}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-ba07-7d51-8770-33e3c53a5093', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-b9e0-730a-84ef-3247bb074a9a', 'auth_rate_limits_pkey', 'p', '{019fbc96-b9f3-7a69-8f73-d3c7eca1c2a8}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-baeb-74f7-98c9-6232b63cd238', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-bac2-7190-b634-e54079d7304b', 'app_settings_devices_pkey', 'p', '{019fbc96-bad5-7cd6-9235-29c8cd58d9f1}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-bc1d-736a-afe7-83e60b997e59', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-bbf2-7aef-8d13-b34586d8c5f2', 'auth_user_devices_pkey', 'p', '{019fbc96-bc07-7946-915c-013e491068e1}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-be77-77ce-820b-b636c4cc817c', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-bdd9-7379-be88-17a73f1d5320', 'user_secrets_pkey', 'p', '{019fbc96-bdec-7730-88da-2329f1431186}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-c06c-73ae-b303-d3fb6ac8088e', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-bf36-74c5-8ebc-0fda254875cd', 'app_internal_secrets_pkey', 'p', '{019fbc96-bf4e-793d-8cac-24ceac3b5b81}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-c282-7b74-b8d7-e5a2e251a65e', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-c250-7c44-b81a-baa69ea7f678', 'emails_pkey', 'p', '{019fbc96-c268-7ae3-a537-d3cc973a50f6}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-c419-7673-9a35-ece9f9642ad9', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-c3eb-7e52-a614-bb88613a1b4d', 'phone_numbers_pkey', 'p', '{019fbc96-c402-7771-ab8f-5b45654939c9}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-c5a6-75d3-9a9b-2c6e261e0ebb', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-c578-7e37-80c4-3ba5549c2b28', 'webauthn_credentials_pkey', 'p', '{019fbc96-c58f-7234-b9b3-fb007c7cd81a}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-c76b-7656-927b-9ce29917b35d', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-c73d-7bb7-945b-3e60ebd7f19a', 'connected_accounts_pkey', 'p', '{019fbc96-c753-7363-abbc-392bf7d1468a}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-c8c0-7d3e-8799-f86b3260cb4e', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-c88d-7ba5-bce4-cfcf39ec99a4', 'identity_providers_pkey', 'p', '{019fbc96-c8a7-7652-8ab4-1ef464e1ae20}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-cc2c-7e61-a556-c0ddfcd4d68a', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-cbfa-72b5-bec3-82d33e693371', 'app_invites_pkey', 'p', '{019fbc96-cc12-7568-afd2-c2eeabde6ee2}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-ce36-75ec-8248-01c8047f1982', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-ce07-7cb4-8a74-36d41e6de69f', 'app_claimed_invites_pkey', 'p', '{019fbc96-ce1c-7b72-bae3-cdbcdb360636}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-cfaf-70c3-8ec0-8217a0a44efa', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-cf7f-7041-9b02-6402219dc422', 'org_invites_pkey', 'p', '{019fbc96-cf95-7bb0-8d8b-f0407736e219}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-d251-7bc5-91ae-c0c2727a60a5', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-d218-741e-9bc2-e59d1d1a7edd', 'org_claimed_invites_pkey', 'p', '{019fbc96-d236-7f22-a9d7-48271eda5100}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-d58c-75e6-b6e9-79d6c123bffd', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-d430-750d-8b5e-429956001965', 'audit_log_auths_pkey', 'p', '{019fbc96-d528-7c69-ac6f-bac4f9156c2a,019fbc96-d44d-7787-80b9-7dbd07e3f589}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-d984-70ee-8208-5c6de9400cea', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-d949-70f9-ae75-050b81c28f49', 'principals_pkey', 'p', '{019fbc96-d966-7bf3-a621-aee01016f4aa}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-daf3-7529-91cc-ecbcf42a6230', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-dab8-77ea-88cc-6c09b415cd93', 'principal_entities_pkey', 'p', '{019fbc96-dad5-785d-9af2-8d212a4b4777}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-dc33-7d1e-a82d-1c685e58a230', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-dbf8-7743-a147-16f1aad029b3', 'principal_scope_overrides_pkey', 'p', '{019fbc96-dc13-7a0e-9663-8c72c0e39de7}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-dfc8-7048-8ad2-b04a2b973f8a', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-df8c-7b8f-b346-12f61ba2c1ea', 'app_buckets_pkey', 'p', '{019fbc96-dfaa-7941-a081-6ebfb09c4838}', false, false, false, NULL, 'app', '{}'),
  ('019fbc96-e1b3-796b-ad07-66a64b864503', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-e17f-7451-b63a-298e84a64979', 'app_files_pkey', 'p', '{019fbc96-e197-7ca8-befd-0abbe088b468}', false, false, false, NULL, 'app', '{}');


SET session_replication_role TO DEFAULT;


