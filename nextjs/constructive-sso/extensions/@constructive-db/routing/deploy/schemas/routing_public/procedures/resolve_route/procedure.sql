-- Deploy: schemas/routing_public/procedures/resolve_route/procedure
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema


CREATE FUNCTION routing_public.resolve_route(
  request_host text,
  request_path text,
  request_method text,
  OUT route_binding_id uuid,
  OUT hostname text,
  OUT matched_wildcard boolean,
  OUT matched_path text,
  OUT method text,
  OUT priority int,
  OUT domain_id uuid,
  OUT target_catalog_id uuid,
  OUT target_module text,
  OUT target_source_id uuid,
  OUT target_owner_scope text,
  OUT target_owner_key uuid,
  OUT resolved_config jsonb,
  OUT verification_status text,
  OUT tls_status text,
  OUT tls_secret_name text
) RETURNS record AS $$
SELECT
  rb.id AS route_binding_id,
  hb.hostname AS hostname,
  hb.hostname <> split_part(lower(request_host), ':', 1) AS matched_wildcard,
  rb.path AS matched_path,
  rb.method AS method,
  rb.priority AS priority,
  rb.domain_id AS domain_id,
  COALESCE(rb.target_api_id, rb.target_site_id, rb.target_function_id, rb.target_service_id, rb.target_bucket_id) AS target_catalog_id,
CASE 
    WHEN rb.target_api_id IS NOT NULL THEN 'api' 
    WHEN rb.target_site_id IS NOT NULL THEN 'site' 
    WHEN rb.target_function_id IS NOT NULL THEN 'function' 
    WHEN rb.target_service_id IS NOT NULL THEN 'service' 
    WHEN rb.target_bucket_id IS NOT NULL THEN 'bucket' 
  END AS target_module,
  COALESCE(a.id, s.id, f.id, res.id, b.id) AS target_source_id,
  COALESCE(a.owner_scope, s.owner_scope, f.owner_scope, res.owner_scope, b.owner_scope) AS target_owner_scope,
  COALESCE(a.owner_key, s.owner_key, f.owner_key, res.owner_key, b.owner_key) AS target_owner_key,
CASE 
    WHEN rb.target_api_id IS NOT NULL THEN ((COALESCE(a.config, '{}'::jsonb)) || jsonb_strip_nulls(jsonb_build_object('name', a.name, 'dbname', a.dbname, 'role_name', a.role_name, 'anon_role', a.anon_role, 'api_id', a.id, 'database_id', a.database_id))) || jsonb_build_object('schemas', "routing_public".api_schema_names(a.id)) 
    WHEN rb.target_site_id IS NOT NULL THEN (COALESCE(s.config, '{}'::jsonb)) || jsonb_strip_nulls(jsonb_build_object('name', s.name)) 
    WHEN rb.target_function_id IS NOT NULL THEN jsonb_strip_nulls(jsonb_build_object('task_identifier', f.task_identifier)) 
    WHEN rb.target_service_id IS NOT NULL THEN jsonb_strip_nulls(jsonb_build_object('namespace_id', res.namespace_id, 'kind', res.kind, 'slug', res.slug)) 
    WHEN rb.target_bucket_id IS NOT NULL THEN (COALESCE(r.config, '{}'::jsonb)) || jsonb_strip_nulls(jsonb_build_object('bucket_id', b.id, 'bucket_key', b.key, 'bucket_type', b.type, 'physical_name', b.physical_name, 'database_id', b.database_id)) 
  END AS resolved_config,
  hb.verification_status AS verification_status,
  hb.tls_status AS tls_status,
  hb.tls_secret_name AS tls_secret_name
FROM "routing_public".hostname_bindings AS hb INNER JOIN "routing_public".route_bindings AS rb ON rb.domain_id = hb.domain_id LEFT OUTER JOIN "catalog_public".apis AS a ON a.id = rb.target_api_id LEFT OUTER JOIN "catalog_public".sites AS s ON s.id = rb.target_site_id LEFT OUTER JOIN "catalog_public".functions AS f ON f.id = rb.target_function_id LEFT OUTER JOIN "catalog_public".resources AS res ON res.id = rb.target_service_id LEFT OUTER JOIN "catalog_public".buckets AS b ON b.id = rb.target_bucket_id LEFT OUTER JOIN "routing_public".routes AS r ON r.id = rb.id
WHERE
  (hb.hostname = split_part(lower(request_host), ':', 1) OR (hb.is_wildcard AND hb.parent_hostname = substr(split_part(lower(request_host), ':', 1), strpos(split_part(lower(request_host), ':', 1), '.') + 1))) AND ((rb.path = '/' OR (concat('/', ltrim(COALESCE(request_path, '/'), '/')) = rb.path OR "left"(concat('/', ltrim(COALESCE(request_path, '/'), '/')), length(rb.path) + 1) = (rb.path || '/'))) AND ((rb.method IS NULL OR upper(rb.method) = upper(request_method)) AND rb.is_active))
ORDER BY
  hb.hostname = split_part(lower(request_host), ':', 1) DESC,
  length(rb.path) DESC,
  rb.method IS NOT NULL DESC,
  rb.priority DESC,
  rb.id ASC
LIMIT
1
$$ LANGUAGE sql STABLE SECURITY DEFINER;