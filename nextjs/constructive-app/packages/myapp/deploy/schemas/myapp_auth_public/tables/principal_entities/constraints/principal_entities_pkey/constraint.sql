-- Deploy: schemas/myapp_auth_public/tables/principal_entities/constraints/principal_entities_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principal_entities/table


ALTER TABLE myapp_auth_public.principal_entities 
  ADD CONSTRAINT principal_entities_pkey PRIMARY KEY (id);

