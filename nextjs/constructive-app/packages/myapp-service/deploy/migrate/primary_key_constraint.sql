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
  ('019feb75-78f2-7370-b40b-2e7cd569c2ba', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-78e2-720e-82dc-c3ed84264ce8', 'users_pkey', 'p', '{019feb75-78eb-74ba-9b7c-93e06b7350b1}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-7916-7c70-8612-288ba420148e', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7911-7db8-a88d-ce102149bb22', 'role_types_pkey', 'p', '{019feb75-7915-7567-a2b6-6a77d86ee90d}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-794a-7abf-9167-b13472f8bb32', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7940-7758-b3b9-f53e917bff10', 'membership_types_pkey', 'p', '{019feb75-7947-7616-bebc-263572814839}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-7985-7b73-9206-52cdeaa3b304', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-797b-7fe2-bec7-40f720b33f6b', 'app_capabilities_pkey', 'p', '{019feb75-7981-7b6c-9c13-f41b5137d1de}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-79ac-7bf5-aba1-dbc81751adde', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-79a7-7220-a4a5-518075c2fa2c', 'app_capability_defaults_pkey', 'p', '{019feb75-79aa-7e8e-b504-b24e73b3bd95}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-79d3-7603-aee0-1122db5fd711', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-79c8-7b1d-97d4-30cd885258c7', 'app_limits_pkey', 'p', '{019feb75-79cf-766f-a171-8617cdb9da01}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-79f4-73ec-9d4d-961f3af6287c', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-79ee-72c1-a134-d898911d2b82', 'app_limit_defaults_pkey', 'p', '{019feb75-79f2-7163-8c64-7592ac9cba10}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-7a25-757e-bce3-51e243d4b2ad', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7a1f-70ad-af15-440dd2401c7e', 'app_limit_credits_pkey', 'p', '{019feb75-7a23-7060-b640-7b3803fe986b}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-7a6e-71aa-bab1-95631aedeeea', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7a56-789b-b3c7-a2b7134c8406', 'app_limit_events_pkey', 'p', '{019feb75-7a60-7c24-ace5-e232d1139d1e,019feb75-7a5e-7329-847a-91eb835f966b}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-7aab-73e6-ac67-3d21bbfeca0b', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7aa4-7b5b-aacc-2517f0ff61eb', 'app_limit_credit_codes_pkey', 'p', '{019feb75-7aa9-709f-9d2b-4bab721c3c51}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-7ac0-7c52-92ea-aef12ae93541', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7aba-7a92-9d13-8877944a965f', 'app_limit_credit_code_items_pkey', 'p', '{019feb75-7abe-7afa-9ac3-3a609edb8054}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-7ade-7247-aec2-ce38bb745459', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7ad8-7045-8b15-a07b2abdb858', 'app_limit_credit_redemptions_pkey', 'p', '{019feb75-7adc-7068-aa28-69cebb5d8138}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-7aff-7486-a999-50c24002904f', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7af8-783b-b7e9-73b66653c4a4', 'app_limit_caps_defaults_pkey', 'p', '{019feb75-7afc-7fa0-933b-02908010395d}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-7b0f-70fe-bd34-3a6d512369d6', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7b08-7ddd-a465-1505c8a5e604', 'app_limit_caps_pkey', 'p', '{019feb75-7b0c-7e70-a1ca-f7d2c0c6b812}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-7b2c-79c1-aa5a-7068833adde0', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7b26-7496-8f57-9d3af1da9a94', 'app_limit_warnings_pkey', 'p', '{019feb75-7b2a-7815-8f4a-55154e402790}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-7b40-7197-980b-17957f1ff3e9', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7b39-7dcd-a575-3a0ef02c3a5b', 'app_limit_warning_states_pkey', 'p', '{019feb75-7b3d-7fe3-b107-540daf4c093b}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-7b78-7a43-981d-2ceb6b45bb2b', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7b6d-72f4-9506-d4f1cf2023b7', 'app_memberships_pkey', 'p', '{019feb75-7b74-78be-a0b4-43682d1fed54}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-7b92-7cd5-8ff3-925eae6397a3', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7b8c-7674-8aa6-9f3e7822b6d2', 'app_membership_defaults_pkey', 'p', '{019feb75-7b90-7ae4-a327-ee89c403ede1}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-7bf7-7395-bb3b-85ed5f50332a', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7bf0-7c61-a442-b33dfe0ad7f1', 'app_admin_grants_pkey', 'p', '{019feb75-7bf5-71e9-81ec-618a4666593f}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-7c14-7961-8034-2bc679baa718', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7c0e-748e-9569-e50965f21a18', 'app_owner_grants_pkey', 'p', '{019feb75-7c12-776e-ab77-d1f7fd40906e}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-7c31-79ee-b015-f64dff0c5f87', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7c2b-7756-979f-e00c324dac19', 'app_grants_pkey', 'p', '{019feb75-7c2f-77d7-a8cf-5e1916d7fb4b}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-7c50-741b-ab71-e1d82c294c0f', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7c4a-7e32-9627-f808c8005aec', 'app_capability_default_capabilities_pkey', 'p', '{019feb75-7c4e-7216-9457-1b5b43e848d0}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-7c64-7665-b424-0e0dbbda04e1', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7c5d-7c2e-ac56-9641ad127fd0', 'app_capability_default_grants_pkey', 'p', '{019feb75-7c62-7391-a7eb-e748d80ea962}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-7cc8-730f-9187-85469e0f6903', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7cbc-7f64-80c7-6d62d91becf3', 'app_profiles_pkey', 'p', '{019feb75-7cc4-7035-a462-edf8c9eedbe9}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-7cf0-7d36-95c1-3e50b9c8ca92', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7cea-7eb1-916e-f55daf9eb5a8', 'app_profile_capabilities_pkey', 'p', '{019feb75-7cee-79e0-957d-da1569ed64d9}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-7d0c-7e6e-a22e-3d496ea68769', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7d06-7774-b81f-cba5ab585933', 'app_profile_grants_pkey', 'p', '{019feb75-7d0a-7bf9-805e-625471bd4b68}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-7d31-76ea-9b9f-72bea01089e9', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7d2a-7ec3-b6b1-f48a662aae14', 'app_profile_definition_grants_pkey', 'p', '{019feb75-7d2f-746d-95f2-260f909142ac}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-7d59-7108-9ae5-7783d6613fc1', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7d53-712f-8ea5-88ad311bf62b', 'app_membership_profiles_pkey', 'p', '{019feb75-7d56-7fc4-beae-fa0f61f7c7a3}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-7da6-7352-a330-8de4b5e2fe85', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7d9f-7c4a-8d87-de64c404c98f', 'app_profile_templates_pkey', 'p', '{019feb75-7da3-7fb9-8c1c-e135fe0f0b9c}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-7ee8-776c-a958-bbf7c5e87395', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7ee2-77cd-aa83-c4d0fcd1a585', 'org_capabilities_pkey', 'p', '{019feb75-7ee6-72ed-b591-c18a1299e59e}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-7f0d-73d6-b98d-74807b3ccb70', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7f06-74af-8081-279dccbef6aa', 'org_capability_defaults_pkey', 'p', '{019feb75-7f0a-7e9c-b6c8-8c1985e60760}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-7f21-7ebd-be9e-3e7f3368b16c', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7f1b-74ca-9a57-a7a77a490ba9', 'org_limits_pkey', 'p', '{019feb75-7f1f-7b55-83fb-60360b55f121}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-7f49-750c-ad46-4fd4e5f28026', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7f42-7e7f-adeb-651d0ecc673c', 'org_limit_defaults_pkey', 'p', '{019feb75-7f47-720f-b6b2-d06dbd6bd3ab}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-7f77-7fb7-ace4-219edbdb704b', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7f70-7a9a-b1b8-af5eaf063cc7', 'org_limit_credits_pkey', 'p', '{019feb75-7f75-7938-91d9-1390fea0b6e2}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-7fb9-7a2b-9822-f2e56830521f', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7fb2-7e3f-accd-1083624b72d7', 'org_limit_aggregates_pkey', 'p', '{019feb75-7fb7-7516-9450-bdaf01c16567}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-802b-72ee-be6a-2886f8ffab80', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-800e-723c-9bc5-bd7ad5ccacf4', 'org_limit_events_pkey', 'p', '{019feb75-801a-74b4-a1e6-806827b59d42,019feb75-8016-7ac4-8daa-5f715136ba6a}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-8070-71d2-9628-03a84b1e3f2b', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8069-7350-adb8-7640b3b672a2', 'org_limit_caps_defaults_pkey', 'p', '{019feb75-806d-7a1a-ac8c-4583fc98434f}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-8081-7305-b444-65b4106ee161', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-807a-7c6b-acaa-eba03b0252bd', 'org_limit_caps_pkey', 'p', '{019feb75-807e-7e1d-a746-a0ae4dec7fb4}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-80aa-72a5-a494-108d6aa8cfe9', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-80a3-7086-aac3-48a15ab63067', 'org_limit_warnings_pkey', 'p', '{019feb75-80a7-7b52-b2dd-ab59b2e943b2}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-80c4-7259-a812-647efe8d4a81', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-80bd-7a38-8322-a23264db0479', 'org_limit_warning_states_pkey', 'p', '{019feb75-80c1-7d65-9ca7-9d92a0ce9f33}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-80f2-75d1-bd6c-42ba9b358648', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-80eb-77cb-b434-9214851f2d3f', 'org_memberships_pkey', 'p', '{019feb75-80ef-7ecd-ba88-a066558e705e}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-810b-74e4-a8ac-809f22e1dd41', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8104-74c1-9285-19272f3f36c9', 'org_membership_defaults_pkey', 'p', '{019feb75-8108-7be6-9fb8-c4e247268ef1}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-8148-709b-b6f2-1ec705bfee68', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8141-7843-8e56-03ed77e58e70', 'org_membership_settings_pkey', 'p', '{019feb75-8145-7b6b-8b9c-dd652e1e277e}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-81a7-7b7c-b83a-2f59ca10c6fb', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-81a1-73c4-921f-2f503423abb6', 'org_members_pkey', 'p', '{019feb75-81a5-7677-9ddc-c356fee8e6a3}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-81f1-720f-8f5e-992cdf5a41f1', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-81ea-722f-92a4-ae498d5ca9f1', 'org_admin_grants_pkey', 'p', '{019feb75-81ee-7ac2-85df-81481990849f}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-8216-7b36-b065-f2002467d63b', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8210-74c4-a398-da72dd99aad2', 'org_owner_grants_pkey', 'p', '{019feb75-8214-75dc-8e97-1cb28abe5353}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-823d-7011-900c-5c75c29c34ad', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8236-75fb-9dc6-db689017ed5d', 'org_member_profiles_pkey', 'p', '{019feb75-823a-7b26-a73d-bb29dde3ab5d}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-827f-719e-ad81-c9344bd14770', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8278-7bcd-98f0-8fbbd5ad1f2d', 'org_grants_pkey', 'p', '{019feb75-827c-7d31-b4d0-2d5f6ce752af}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-82a8-73c9-a24b-8f8b92cd0cd1', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-82a2-791d-93ce-2b9a34a3b7d6', 'org_capability_default_capabilities_pkey', 'p', '{019feb75-82a5-7efb-9891-16493bc167dd}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-82c5-7bf2-a00f-baad75a3dcb3', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-82be-79b8-8469-ac0eb8e697a7', 'org_capability_default_grants_pkey', 'p', '{019feb75-82c3-734f-ac27-288da2aadea6}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-8323-7c68-bec4-e0267ecd4f15', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-831c-7cc1-b679-81c2a7b7fb3e', 'org_profiles_pkey', 'p', '{019feb75-8321-72fd-9233-711d223183b2}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-8354-7086-88bd-79dafbb42428', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-834e-7791-852a-6787b1c99790', 'org_profile_capabilities_pkey', 'p', '{019feb75-8351-7c13-b155-ec8a3abe07ba}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-8372-72a3-8d32-14e9247ea973', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-836b-76bc-ab70-3f1198fcc4de', 'org_profile_grants_pkey', 'p', '{019feb75-836f-7d95-b667-722978574428}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-839f-7beb-937a-abc851012432', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8398-75f1-8bf9-a5b1d207d637', 'org_profile_definition_grants_pkey', 'p', '{019feb75-839d-7367-8fb2-ef42cde3d908}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-83ca-7f7c-ae70-d6a1a9080ef7', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-83c4-7884-89b2-49df42951434', 'org_membership_profiles_pkey', 'p', '{019feb75-83c8-7ab1-9ed9-1725d5fe4290}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-8413-79af-956b-ea23328bfaaf', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-840b-7395-9b85-b717d612a64d', 'org_profile_templates_pkey', 'p', '{019feb75-8410-7dc6-ab00-4b922a19774a}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-8448-7072-8ab0-85141f39f1d2', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8440-7e28-b081-063629bcb1bb', 'org_chart_edges_pkey', 'p', '{019feb75-8445-779e-8eaa-717427b2996e}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-847c-7a34-9a9e-c62acf294682', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8470-79ea-8c87-7a37d614490b', 'org_hierarchy_sprts_pkey', 'p', '{019feb75-8474-7f9f-90c5-7500d0b608a8,019feb75-8476-7f65-9c3d-db77232b58a4,019feb75-8478-7eb3-a810-0e8e04d3e08b}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-8490-723f-8ff8-0cf6eb5e81eb', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8488-7feb-8444-2e121d3adf86', 'org_chart_edge_grants_pkey', 'p', '{019feb75-848d-7762-ba1c-a8c71627de4a}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-8676-7234-ace2-e3a2f895ee5b', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8662-7462-bd4b-d8dee032dcdd', 'user_states_pkey', 'p', '{019feb75-8669-7eed-89e2-68fbbbcf99e6}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-86ac-7673-b666-dc5d0ef5adbb', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-869f-77e5-b1bd-2954e3f87b89', 'sessions_pkey', 'p', '{019feb75-86a7-759c-af9a-7fef7489b4dd}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-86e4-7a60-939f-bde414fbd913', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-86dd-7d4b-9a7a-f22c7ff73486', 'session_credentials_pkey', 'p', '{019feb75-86e2-7295-b5a9-c0dd863b46a3}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-871c-783d-a471-13caa7d93eff', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8713-7ceb-a1b7-6f4fffe21b51', 'app_settings_auths_pkey', 'p', '{019feb75-871a-7327-8d70-681826ed075e}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-87de-7188-a114-506a90b65d9a', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-87d7-70dd-9516-54c0ecf94600', 'session_secrets_pkey', 'p', '{019feb75-87db-7ab9-9fbe-f701595bdd81}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-8814-7e49-93b7-9f62e4a03cf3', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-880d-7cf9-99a9-511154d59d7f', 'app_settings_rate_limits_pkey', 'p', '{019feb75-8812-750b-b501-eb4f0c1a1861}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-884d-7718-9ed8-ca77d9cb67e7', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8846-7b3d-84c7-196f76f0ae39', 'auth_ip_rate_limits_pkey', 'p', '{019feb75-884b-712a-8ba0-de816f358f47}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-8873-72ac-b607-265682f3f66d', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-886c-70f1-ac1c-d171bba694aa', 'auth_rate_limits_pkey', 'p', '{019feb75-8870-79b9-93f2-1012ae450470}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-889c-78af-a48e-5a04cb16c935', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8895-7d60-91c8-d183e531853c', 'app_settings_devices_pkey', 'p', '{019feb75-8899-7cd7-a3c1-2ac3b19b1ace}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-88d2-73f8-ae9a-8101ccb67396', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-88c9-752b-8ef8-9966727a744c', 'auth_user_devices_pkey', 'p', '{019feb75-88ce-7672-9f2d-770e007db547}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-8933-73c3-8740-77d996e9419d', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-891b-7bcd-9ed3-1fc29a40c6cd', 'user_secrets_pkey', 'p', '{019feb75-8920-72c2-bd63-c483ef549f38}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-8994-726e-88e8-d08373fbcba2', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8966-7ecd-bc75-e2778b51a789', 'app_internal_secrets_pkey', 'p', '{019feb75-896f-705e-a3ad-df8968c56d9a}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-8a2f-798a-aea3-46c0338b589b', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8a23-70f0-bc0a-c082a8c80fda', 'emails_pkey', 'p', '{019feb75-8a2b-701f-8abf-8df841225181}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-8a89-7e05-a1d1-fbb8f42d415e', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8a82-79e3-8a0d-c9114b559299', 'phone_numbers_pkey', 'p', '{019feb75-8a87-7438-a782-db057e13b6b9}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-8ada-75ee-b7ca-db7f220022a8', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8ad3-74a3-a82a-14d661c634a7', 'webauthn_credentials_pkey', 'p', '{019feb75-8ad7-7ddb-82e7-5d8ec7cd86f3}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-8b19-7fcb-b5d8-aa5d6e287fb0', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8b13-7cf2-936a-d96be009a625', 'user_settings_securities_pkey', 'p', '{019feb75-8b17-773d-bbeb-6992eb4b5fa1}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-8b49-79e8-9a42-4910b0b4b162', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8b42-77a4-83be-695a8efb04b9', 'connected_accounts_pkey', 'p', '{019feb75-8b47-70eb-b5a1-25c6ec940e79}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-8b86-7b76-8a31-cdcfc26df5a3', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8b7e-7a85-9b53-09c3e40fc17e', 'identity_providers_pkey', 'p', '{019feb75-8b84-72f2-b4b2-8e385a82e3b9}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-8c0c-7d9e-9a96-440ea62fbab7', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8c00-72b9-b512-4719a73b24a5', 'app_invites_pkey', 'p', '{019feb75-8c08-71e5-8602-184e5835eb5a}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-8c63-78ff-bd26-bdadcccd167f', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8c5c-78a0-a5bc-ac52a3e98db5', 'app_claimed_invites_pkey', 'p', '{019feb75-8c61-702c-9c65-ecbdd569130b}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-8cc9-76a4-8255-a5f33e977de3', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8cc1-72cd-aaa8-39befebe8af8', 'org_invites_pkey', 'p', '{019feb75-8cc6-73f4-8a58-b26569aea7a6}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-8d2e-74cd-8085-72b4e6b52470', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8d26-7dd5-8a1e-47949cbdb6a7', 'org_claimed_invites_pkey', 'p', '{019feb75-8d2b-7a8e-9b8a-1b0a0e35be60}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-8e1f-7496-aab1-8716f521405e', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8da3-75f1-b809-0a4c23d44795', 'audit_log_auths_pkey', 'p', '{019feb75-8dca-7d44-81b7-54bf97d5e1b2,019feb75-8dae-7567-8663-415d687aa055}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-9154-7260-859c-ac61ed4567c0', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-9149-78eb-8455-bb07f20208c6', 'principals_pkey', 'p', '{019feb75-9151-7316-b33f-4af9fa39ad4c}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-918a-7f08-a99f-1f5ae5133764', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-9184-707a-8a09-d8870969fe13', 'principal_entities_pkey', 'p', '{019feb75-9188-71e5-8f35-5a4a53546b0a}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-91c5-7767-af33-81c3e1796edf', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-91bb-7f0a-9d9d-fd451ffa01f4', 'principal_scope_overrides_pkey', 'p', '{019feb75-91c2-781c-a83f-df2df371580a}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-92d9-7c76-b00f-860402990684', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-92cb-7779-a574-9f45714317cb', 'app_buckets_pkey', 'p', '{019feb75-92d4-7aa9-8f64-a804d5c5df13}', false, false, false, NULL, 'app', '{}'),
  ('019feb75-932e-7dc2-9c59-75ae11845f3d', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-9326-7582-bae6-2409b3215b5d', 'app_files_pkey', 'p', '{019feb75-932b-7e63-8c31-3971b83991ec}', false, false, false, NULL, 'app', '{}');


SET session_replication_role TO DEFAULT;


