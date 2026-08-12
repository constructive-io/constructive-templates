-- Revert: schemas/myapp_memberships_public/tables/app_membership_defaults/alterations/fix0000000003


DELETE FROM myapp_memberships_public.app_membership_defaults
WHERE
  is_verified = 'f'::boolean AND is_approved = 'f'::boolean;


