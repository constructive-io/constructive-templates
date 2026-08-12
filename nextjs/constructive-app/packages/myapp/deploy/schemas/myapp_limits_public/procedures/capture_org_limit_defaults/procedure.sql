-- Deploy: schemas/myapp_limits_public/procedures/capture_org_limit_defaults/procedure
-- made with <3 @ constructive.io

-- requires: schemas/myapp_limits_public/schema
-- requires: schemas/myapp_limits_public/tables/org_limit_defaults/table


CREATE FUNCTION myapp_limits_public.capture_org_limit_defaults() RETURNS jsonb AS $_PGFN_$
BEGIN
  RETURN (SELECT
    COALESCE(jsonb_agg(jsonb_build_object('name', d.name, 'max', d.max) ORDER BY d.name ), '[]'::jsonb)
  FROM myapp_limits_public.org_limit_defaults AS d);
END;
$_PGFN_$ LANGUAGE plpgsql STABLE;

