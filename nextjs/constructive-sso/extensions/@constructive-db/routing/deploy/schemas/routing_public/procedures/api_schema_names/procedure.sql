-- Deploy: schemas/routing_public/procedures/api_schema_names/procedure
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema


CREATE FUNCTION routing_public.api_schema_names(
  target_api_id uuid
) RETURNS jsonb AS $$BEGIN
  RETURN COALESCE((SELECT jsonb_agg(sc.schema_name)
    FROM routing_public.api_schemas AS aps, metaschema_public.schema AS sc
    WHERE
      sc.id = aps.schema_id
      AND aps.api_id = target_api_id
      AND sc.schema_name IS NOT NULL), '[]'::jsonb);
END$$ LANGUAGE plpgsql STABLE SECURITY DEFINER;