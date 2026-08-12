-- Deploy: schemas/myapp_auth_private/tables/identity_providers/constraints/identity_providers_slug_key/constraint
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/identity_providers/table


ALTER TABLE myapp_auth_private.identity_providers 
  ADD CONSTRAINT identity_providers_slug_key 
    UNIQUE (slug);

