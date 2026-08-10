-- Deploy: schemas/myapp_profiles_public/tables/org_membership_profiles/constraints/org_membership_profiles_actor_id_fkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/myapp_users_public/schema
-- requires: schemas/myapp_profiles_public/schema
-- requires: schemas/myapp_users_public/tables/users/table
-- requires: schemas/myapp_profiles_public/tables/org_membership_profiles/table


ALTER TABLE myapp_profiles_public.org_membership_profiles 
  ADD CONSTRAINT org_membership_profiles_actor_id_fkey 
    FOREIGN KEY(actor_id) 
    REFERENCES myapp_users_public.users (id) 
    ON DELETE CASCADE;

