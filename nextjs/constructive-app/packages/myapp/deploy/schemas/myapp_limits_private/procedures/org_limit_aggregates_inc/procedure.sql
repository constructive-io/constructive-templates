-- Deploy: schemas/myapp_limits_private/procedures/org_limit_aggregates_inc/procedure
-- made with <3 @ constructive.io

-- requires: schemas/myapp_limits_private/schema
-- requires: schemas/myapp_limits_public/tables/org_limit_defaults/table
-- requires: schemas/myapp_limits_public/tables/org_limit_aggregates/table


CREATE FUNCTION myapp_limits_private.org_limit_aggregates_inc(
  IN limitname citext,
  IN entity_id uuid,
  IN amount bigint DEFAULT 1
) RETURNS boolean AS $_PGFN_$
DECLARE
  max_default bigint := 0;
BEGIN
  SELECT max
  FROM myapp_limits_public.org_limit_defaults
  WHERE
    name = org_limit_aggregates_inc.limitname INTO max_default;
  IF NOT (FOUND) THEN
    max_default := 0;
  END IF;
  INSERT INTO myapp_limits_public.org_limit_aggregates (
    name,
    num,
    max,
    entity_id
  )
  VALUES
    (org_limit_aggregates_inc.limitname, 0, max_default, org_limit_aggregates_inc.entity_id)
  ON CONFLICT ON CONSTRAINT org_limit_aggregates_name_entity_id_key DO NOTHING;
  UPDATE myapp_limits_public.org_limit_aggregates AS l SET
  num = 0, period_credits = 0, max = CASE 
    WHEN (COALESCE(l.plan_max, (SELECT d.max
  FROM myapp_limits_public.org_limit_defaults AS d
  WHERE
      d.name = l.name), 0)) < 0 THEN -1 
    ELSE (COALESCE(l.plan_max, (SELECT d.max
  FROM myapp_limits_public.org_limit_defaults AS d
  WHERE
      d.name = l.name), 0)) + l.purchased_credits 
  END, window_start = pg_catalog.now()
  WHERE
    (l.name = org_limit_aggregates_inc.limitname AND l.entity_id = org_limit_aggregates_inc.entity_id) AND (l.window_duration IS NOT NULL AND (l.window_start + l.window_duration) <= pg_catalog.now());
  UPDATE myapp_limits_public.org_limit_aggregates AS l SET
  num = num + org_limit_aggregates_inc.amount
  WHERE
    (l.name = org_limit_aggregates_inc.limitname AND l.entity_id = org_limit_aggregates_inc.entity_id) AND ((CASE 
        WHEN (COALESCE(l.plan_max, max_default, 0)) < 0 THEN -1 
        ELSE ((COALESCE(l.plan_max, max_default, 0)) + l.purchased_credits) + (COALESCE(l.period_credits, 0)) 
      END) < 0 OR (CASE 
        WHEN (COALESCE(l.plan_max, max_default, 0)) < 0 THEN -1 
        ELSE ((COALESCE(l.plan_max, max_default, 0)) + l.purchased_credits) + (COALESCE(l.period_credits, 0)) 
      END) >= (l.num + org_limit_aggregates_inc.amount));
  IF FOUND THEN
    RETURN true;
  ELSE
    RETURN false;
  END IF;
  RETURN false;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

