-- Deploy: schemas/myapp_profiles_private/trigger_fns/app_membership_profiles_remove_tg
-- made with <3 @ constructive.io

-- requires: schemas/myapp_profiles_private/schema
-- requires: schemas/myapp_memberships_public/tables/app_memberships/table
-- requires: schemas/myapp_profiles_public/tables/app_membership_profiles/table


CREATE FUNCTION myapp_profiles_private.app_membership_profiles_remove_tg() RETURNS TRIGGER AS $_PGFN_$
BEGIN
  UPDATE myapp_memberships_public.app_memberships SET
  profile_id = COALESCE((SELECT mp.profile_id
  FROM myapp_profiles_public.app_membership_profiles AS mp
  WHERE
    mp.membership_id = OLD.membership_id AND mp.profile_id = app_memberships.profile_id), (SELECT mp.profile_id
  FROM myapp_profiles_public.app_membership_profiles AS mp
  WHERE
    mp.membership_id = OLD.membership_id
  ORDER BY
    mp.created_at ASC,
    mp.profile_id ASC
  LIMIT
  1))
  WHERE
    id = OLD.membership_id;
  RETURN OLD;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

