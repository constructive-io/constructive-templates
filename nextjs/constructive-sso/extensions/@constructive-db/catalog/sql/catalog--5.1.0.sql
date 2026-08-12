\echo Use "CREATE EXTENSION catalog" to load this file. \quit
CREATE SCHEMA catalog_private;

GRANT USAGE ON SCHEMA catalog_private TO administrator;

GRANT USAGE ON SCHEMA catalog_private TO authenticated;

GRANT USAGE ON SCHEMA catalog_private TO anonymous;

ALTER DEFAULT PRIVILEGES IN SCHEMA catalog_private
  GRANT ALL ON TABLES TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA catalog_private
  GRANT USAGE ON SEQUENCES TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA catalog_private
  GRANT ALL ON FUNCTIONS TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA catalog_private
  GRANT ALL ON FUNCTIONS TO authenticated;

ALTER DEFAULT PRIVILEGES IN SCHEMA catalog_private
  GRANT USAGE ON SEQUENCES TO authenticated;

CREATE TABLE catalog_private.domains ();

ALTER TABLE catalog_private.domains 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE catalog_private.domains IS 'Trigger-maintained typed catalog of hostnames across all scopes; UNIQUE (hostname) is the global claim';

ALTER TABLE catalog_private.domains 
  ADD COLUMN id uuid;

ALTER TABLE catalog_private.domains 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE catalog_private.domains 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE catalog_private.domains 
  ADD CONSTRAINT domains_pkey PRIMARY KEY (id);

ALTER TABLE catalog_private.domains 
  ADD COLUMN created_at timestamptz;

ALTER TABLE catalog_private.domains 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE catalog_private.domains 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE catalog_private.domains 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE INDEX domains_created_at_idx ON catalog_private.domains (created_at);

CREATE INDEX domains_updated_at_idx ON catalog_private.domains (updated_at);

ALTER TABLE catalog_private.domains 
  ADD COLUMN owner_scope text;

ALTER TABLE catalog_private.domains 
  ALTER COLUMN owner_scope SET NOT NULL;

COMMENT ON COLUMN catalog_private.domains.owner_scope IS 'Scope of the source table that owns the row';

ALTER TABLE catalog_private.domains 
  ADD COLUMN owner_key uuid;

COMMENT ON COLUMN catalog_private.domains.owner_key IS 'Value of the source table scope key column; NULL for global-tier owners';

ALTER TABLE catalog_private.domains 
  ADD COLUMN is_visible boolean;

ALTER TABLE catalog_private.domains 
  ALTER COLUMN is_visible SET NOT NULL;

ALTER TABLE catalog_private.domains 
  ALTER COLUMN is_visible SET DEFAULT false;

COMMENT ON COLUMN catalog_private.domains.is_visible IS 'Cross-scope visibility flag propagated from the scoped source row';

ALTER TABLE catalog_private.domains 
  ADD COLUMN database_id uuid;

ALTER TABLE catalog_private.domains 
  ALTER COLUMN database_id SET NOT NULL;

COMMENT ON COLUMN catalog_private.domains.database_id IS 'Database that owns the source row: the tenant database for database-scope rows, the hosting database otherwise';

ALTER TABLE catalog_private.domains 
  ADD COLUMN hostname text;

ALTER TABLE catalog_private.domains 
  ALTER COLUMN hostname SET NOT NULL;

COMMENT ON COLUMN catalog_private.domains.hostname IS 'Lowercase fully-qualified hostname; wildcards use the *.parent form';

ALTER TABLE catalog_private.domains 
  ADD COLUMN is_wildcard boolean;

ALTER TABLE catalog_private.domains 
  ALTER COLUMN is_wildcard SET NOT NULL;

ALTER TABLE catalog_private.domains 
  ALTER COLUMN is_wildcard SET DEFAULT false;

COMMENT ON COLUMN catalog_private.domains.is_wildcard IS 'Whether this hostname is a wildcard claim';

ALTER TABLE catalog_private.domains 
  ADD COLUMN parent_hostname text;

COMMENT ON COLUMN catalog_private.domains.parent_hostname IS 'Parent hostname a wildcard claim covers';

ALTER TABLE catalog_private.domains 
  ADD COLUMN managed boolean;

ALTER TABLE catalog_private.domains 
  ALTER COLUMN managed SET NOT NULL;

ALTER TABLE catalog_private.domains 
  ALTER COLUMN managed SET DEFAULT false;

COMMENT ON COLUMN catalog_private.domains.managed IS 'Whether the platform drives this hostname''s lifecycle';

ALTER TABLE catalog_private.domains 
  ADD COLUMN verification_status text;

COMMENT ON COLUMN catalog_private.domains.verification_status IS 'Ownership verification state propagated from the source row';

ALTER TABLE catalog_private.domains 
  ADD COLUMN tls_status text;

COMMENT ON COLUMN catalog_private.domains.tls_status IS 'Certificate lifecycle state propagated from the source row';

ALTER TABLE catalog_private.domains 
  ADD COLUMN tls_secret_name text;

COMMENT ON COLUMN catalog_private.domains.tls_secret_name IS 'TLS secret name propagated from the source row';

ALTER TABLE catalog_private.domains 
  ADD CONSTRAINT domains_hostname_key 
    UNIQUE (hostname);

CREATE INDEX domains_parent_hostname_is_wildcard_idx ON catalog_private.domains (parent_hostname, is_wildcard);

CREATE INDEX domains_owner_scope_owner_key_idx ON catalog_private.domains (owner_scope, owner_key);

CREATE INDEX domains_database_id_idx ON catalog_private.domains (database_id);

CREATE TABLE catalog_private.apis ();

ALTER TABLE catalog_private.apis 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE catalog_private.apis IS 'Trigger-maintained typed catalog of api surfaces across all scopes; rendering config is read live from this table';

ALTER TABLE catalog_private.apis 
  ADD COLUMN id uuid;

ALTER TABLE catalog_private.apis 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE catalog_private.apis 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE catalog_private.apis 
  ADD CONSTRAINT apis_pkey PRIMARY KEY (id);

ALTER TABLE catalog_private.apis 
  ADD COLUMN created_at timestamptz;

ALTER TABLE catalog_private.apis 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE catalog_private.apis 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE catalog_private.apis 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE INDEX apis_created_at_idx ON catalog_private.apis (created_at);

CREATE INDEX apis_updated_at_idx ON catalog_private.apis (updated_at);

ALTER TABLE catalog_private.apis 
  ADD COLUMN owner_scope text;

ALTER TABLE catalog_private.apis 
  ALTER COLUMN owner_scope SET NOT NULL;

COMMENT ON COLUMN catalog_private.apis.owner_scope IS 'Scope of the source table that owns the row';

ALTER TABLE catalog_private.apis 
  ADD COLUMN owner_key uuid;

COMMENT ON COLUMN catalog_private.apis.owner_key IS 'Value of the source table scope key column; NULL for global-tier owners';

ALTER TABLE catalog_private.apis 
  ADD COLUMN is_visible boolean;

ALTER TABLE catalog_private.apis 
  ALTER COLUMN is_visible SET NOT NULL;

ALTER TABLE catalog_private.apis 
  ALTER COLUMN is_visible SET DEFAULT false;

COMMENT ON COLUMN catalog_private.apis.is_visible IS 'Cross-scope visibility flag propagated from the scoped source row';

ALTER TABLE catalog_private.apis 
  ADD COLUMN database_id uuid;

ALTER TABLE catalog_private.apis 
  ALTER COLUMN database_id SET NOT NULL;

COMMENT ON COLUMN catalog_private.apis.database_id IS 'Database that owns the source row: the tenant database for database-scope rows, the hosting database otherwise';

ALTER TABLE catalog_private.apis 
  ADD COLUMN name text;

ALTER TABLE catalog_private.apis 
  ALTER COLUMN name SET NOT NULL;

COMMENT ON COLUMN catalog_private.apis.name IS 'Owner-local api surface name';

ALTER TABLE catalog_private.apis 
  ADD COLUMN dbname text;

COMMENT ON COLUMN catalog_private.apis.dbname IS 'Physical database name the api renders from';

ALTER TABLE catalog_private.apis 
  ADD COLUMN role_name text;

COMMENT ON COLUMN catalog_private.apis.role_name IS 'Authenticated role the api executes as';

ALTER TABLE catalog_private.apis 
  ADD COLUMN anon_role text;

COMMENT ON COLUMN catalog_private.apis.anon_role IS 'Anonymous role the api executes as';

ALTER TABLE catalog_private.apis 
  ADD COLUMN config jsonb;

COMMENT ON COLUMN catalog_private.apis.config IS 'Rendering configuration (schemas, flags) propagated from the source row';

CREATE UNIQUE INDEX apis_database_id_owner_scope_owner_key_name_idx ON catalog_private.apis (database_id, owner_scope, owner_key, name) WHERE apis.owner_key IS NOT NULL;

CREATE UNIQUE INDEX apis_database_id_owner_scope_name_idx ON catalog_private.apis (database_id, owner_scope, name) WHERE apis.owner_key IS NULL;

CREATE INDEX apis_is_visible_idx ON catalog_private.apis (is_visible);

CREATE INDEX apis_database_id_idx ON catalog_private.apis (database_id);

CREATE TABLE catalog_private.sites ();

ALTER TABLE catalog_private.sites 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE catalog_private.sites IS 'Trigger-maintained typed catalog of site surfaces across all scopes';

ALTER TABLE catalog_private.sites 
  ADD COLUMN id uuid;

ALTER TABLE catalog_private.sites 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE catalog_private.sites 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE catalog_private.sites 
  ADD CONSTRAINT sites_pkey PRIMARY KEY (id);

ALTER TABLE catalog_private.sites 
  ADD COLUMN created_at timestamptz;

ALTER TABLE catalog_private.sites 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE catalog_private.sites 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE catalog_private.sites 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE INDEX sites_created_at_idx ON catalog_private.sites (created_at);

CREATE INDEX sites_updated_at_idx ON catalog_private.sites (updated_at);

ALTER TABLE catalog_private.sites 
  ADD COLUMN owner_scope text;

ALTER TABLE catalog_private.sites 
  ALTER COLUMN owner_scope SET NOT NULL;

COMMENT ON COLUMN catalog_private.sites.owner_scope IS 'Scope of the source table that owns the row';

ALTER TABLE catalog_private.sites 
  ADD COLUMN owner_key uuid;

COMMENT ON COLUMN catalog_private.sites.owner_key IS 'Value of the source table scope key column; NULL for global-tier owners';

ALTER TABLE catalog_private.sites 
  ADD COLUMN is_visible boolean;

ALTER TABLE catalog_private.sites 
  ALTER COLUMN is_visible SET NOT NULL;

ALTER TABLE catalog_private.sites 
  ALTER COLUMN is_visible SET DEFAULT false;

COMMENT ON COLUMN catalog_private.sites.is_visible IS 'Cross-scope visibility flag propagated from the scoped source row';

ALTER TABLE catalog_private.sites 
  ADD COLUMN database_id uuid;

ALTER TABLE catalog_private.sites 
  ALTER COLUMN database_id SET NOT NULL;

COMMENT ON COLUMN catalog_private.sites.database_id IS 'Database that owns the source row: the tenant database for database-scope rows, the hosting database otherwise';

ALTER TABLE catalog_private.sites 
  ADD COLUMN name text;

ALTER TABLE catalog_private.sites 
  ALTER COLUMN name SET NOT NULL;

COMMENT ON COLUMN catalog_private.sites.name IS 'Owner-local site surface name';

ALTER TABLE catalog_private.sites 
  ADD COLUMN title text;

COMMENT ON COLUMN catalog_private.sites.title IS 'Display title propagated from the source row';

ALTER TABLE catalog_private.sites 
  ADD COLUMN description text;

COMMENT ON COLUMN catalog_private.sites.description IS 'Display description propagated from the source row';

ALTER TABLE catalog_private.sites 
  ADD COLUMN bucket_id uuid;

COMMENT ON COLUMN catalog_private.sites.bucket_id IS 'Bucket backing propagated from the source row (resolver dereference key)';

ALTER TABLE catalog_private.sites 
  ADD COLUMN resource_id uuid;

COMMENT ON COLUMN catalog_private.sites.resource_id IS 'Resource/service backing propagated from the source row (resolver dereference key)';

ALTER TABLE catalog_private.sites 
  ADD COLUMN installation_id uuid;

COMMENT ON COLUMN catalog_private.sites.installation_id IS 'Installation (release) backing propagated from the source row (resolver dereference key)';

ALTER TABLE catalog_private.sites 
  ADD COLUMN installation_member_slug text;

COMMENT ON COLUMN catalog_private.sites.installation_member_slug IS 'Slug of the release member that serves this site, propagated from the source row';

CREATE INDEX sites_bucket_id_idx ON catalog_private.sites (bucket_id);

CREATE INDEX sites_resource_id_idx ON catalog_private.sites (resource_id);

CREATE INDEX sites_installation_id_idx ON catalog_private.sites (installation_id);

CREATE UNIQUE INDEX sites_owner_scope_owner_key_name_idx ON catalog_private.sites (owner_scope, owner_key, name) WHERE sites.owner_key IS NOT NULL;

CREATE UNIQUE INDEX sites_owner_scope_name_idx ON catalog_private.sites (owner_scope, name) WHERE sites.owner_key IS NULL;

CREATE INDEX sites_is_visible_idx ON catalog_private.sites (is_visible);

CREATE INDEX sites_database_id_idx ON catalog_private.sites (database_id);

CREATE TABLE catalog_private.namespaces ();

ALTER TABLE catalog_private.namespaces 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE catalog_private.namespaces IS 'Trigger-maintained typed catalog of namespaces across all scopes; UNIQUE (namespace_name) is the global claim';

ALTER TABLE catalog_private.namespaces 
  ADD COLUMN id uuid;

ALTER TABLE catalog_private.namespaces 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE catalog_private.namespaces 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE catalog_private.namespaces 
  ADD CONSTRAINT namespaces_pkey PRIMARY KEY (id);

ALTER TABLE catalog_private.namespaces 
  ADD COLUMN created_at timestamptz;

ALTER TABLE catalog_private.namespaces 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE catalog_private.namespaces 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE catalog_private.namespaces 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE INDEX namespaces_created_at_idx ON catalog_private.namespaces (created_at);

CREATE INDEX namespaces_updated_at_idx ON catalog_private.namespaces (updated_at);

ALTER TABLE catalog_private.namespaces 
  ADD COLUMN owner_scope text;

ALTER TABLE catalog_private.namespaces 
  ALTER COLUMN owner_scope SET NOT NULL;

COMMENT ON COLUMN catalog_private.namespaces.owner_scope IS 'Scope of the source table that owns the row';

ALTER TABLE catalog_private.namespaces 
  ADD COLUMN owner_key uuid;

COMMENT ON COLUMN catalog_private.namespaces.owner_key IS 'Value of the source table scope key column; NULL for global-tier owners';

ALTER TABLE catalog_private.namespaces 
  ADD COLUMN is_visible boolean;

ALTER TABLE catalog_private.namespaces 
  ALTER COLUMN is_visible SET NOT NULL;

ALTER TABLE catalog_private.namespaces 
  ALTER COLUMN is_visible SET DEFAULT false;

COMMENT ON COLUMN catalog_private.namespaces.is_visible IS 'Cross-scope visibility flag propagated from the scoped source row';

ALTER TABLE catalog_private.namespaces 
  ADD COLUMN database_id uuid;

ALTER TABLE catalog_private.namespaces 
  ALTER COLUMN database_id SET NOT NULL;

COMMENT ON COLUMN catalog_private.namespaces.database_id IS 'Database that owns the source row: the tenant database for database-scope rows, the hosting database otherwise';

CREATE INDEX namespaces_owner_scope_owner_key_idx ON catalog_private.namespaces (owner_scope, owner_key);

CREATE INDEX namespaces_database_id_idx ON catalog_private.namespaces (database_id);

ALTER TABLE catalog_private.namespaces 
  ADD COLUMN namespace_name text;

ALTER TABLE catalog_private.namespaces 
  ALTER COLUMN namespace_name SET NOT NULL;

COMMENT ON COLUMN catalog_private.namespaces.namespace_name IS 'Computed namespace slug; globally exclusive across all scopes';

ALTER TABLE catalog_private.namespaces 
  ADD CONSTRAINT namespaces_namespace_name_key 
    UNIQUE (namespace_name);

CREATE TABLE catalog_private.functions ();

ALTER TABLE catalog_private.functions 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE catalog_private.functions IS 'Trigger-maintained typed catalog of function definitions across all scopes';

ALTER TABLE catalog_private.functions 
  ADD COLUMN id uuid;

ALTER TABLE catalog_private.functions 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE catalog_private.functions 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE catalog_private.functions 
  ADD CONSTRAINT functions_pkey PRIMARY KEY (id);

ALTER TABLE catalog_private.functions 
  ADD COLUMN created_at timestamptz;

ALTER TABLE catalog_private.functions 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE catalog_private.functions 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE catalog_private.functions 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE INDEX functions_created_at_idx ON catalog_private.functions (created_at);

CREATE INDEX functions_updated_at_idx ON catalog_private.functions (updated_at);

ALTER TABLE catalog_private.functions 
  ADD COLUMN owner_scope text;

ALTER TABLE catalog_private.functions 
  ALTER COLUMN owner_scope SET NOT NULL;

COMMENT ON COLUMN catalog_private.functions.owner_scope IS 'Scope of the source table that owns the row';

ALTER TABLE catalog_private.functions 
  ADD COLUMN owner_key uuid;

COMMENT ON COLUMN catalog_private.functions.owner_key IS 'Value of the source table scope key column; NULL for global-tier owners';

ALTER TABLE catalog_private.functions 
  ADD COLUMN is_visible boolean;

ALTER TABLE catalog_private.functions 
  ALTER COLUMN is_visible SET NOT NULL;

ALTER TABLE catalog_private.functions 
  ALTER COLUMN is_visible SET DEFAULT false;

COMMENT ON COLUMN catalog_private.functions.is_visible IS 'Cross-scope visibility flag propagated from the scoped source row';

ALTER TABLE catalog_private.functions 
  ADD COLUMN database_id uuid;

ALTER TABLE catalog_private.functions 
  ALTER COLUMN database_id SET NOT NULL;

COMMENT ON COLUMN catalog_private.functions.database_id IS 'Database that owns the source row: the tenant database for database-scope rows, the hosting database otherwise';

CREATE INDEX functions_owner_scope_owner_key_idx ON catalog_private.functions (owner_scope, owner_key);

CREATE INDEX functions_database_id_idx ON catalog_private.functions (database_id);

ALTER TABLE catalog_private.functions 
  ADD COLUMN task_identifier text;

ALTER TABLE catalog_private.functions 
  ALTER COLUMN task_identifier SET NOT NULL;

COMMENT ON COLUMN catalog_private.functions.task_identifier IS 'Owner-local task identifier of the function definition';

ALTER TABLE catalog_private.functions 
  ADD COLUMN queue_name text;

COMMENT ON COLUMN catalog_private.functions.queue_name IS 'Job queue name for serialization, propagated from the source definition';

ALTER TABLE catalog_private.functions 
  ADD COLUMN priority int;

COMMENT ON COLUMN catalog_private.functions.priority IS 'Job priority (lower = higher priority), propagated from the source definition';

ALTER TABLE catalog_private.functions 
  ADD COLUMN max_attempts int;

COMMENT ON COLUMN catalog_private.functions.max_attempts IS 'Maximum retry attempts, propagated from the source definition';

CREATE UNIQUE INDEX functions_database_id_owner_scope_owner_key_task_identifier_idx ON catalog_private.functions (database_id, owner_scope, owner_key, task_identifier) WHERE functions.owner_key IS NOT NULL;

CREATE UNIQUE INDEX functions_database_id_owner_scope_task_identifier_idx ON catalog_private.functions (database_id, owner_scope, task_identifier) WHERE functions.owner_key IS NULL;

CREATE INDEX functions_is_visible_idx ON catalog_private.functions (is_visible);

CREATE TABLE catalog_private.resources ();

ALTER TABLE catalog_private.resources 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE catalog_private.resources IS 'Trigger-maintained typed catalog of resources across all scopes; UNIQUE (namespace_id, kind, slug)';

ALTER TABLE catalog_private.resources 
  ADD COLUMN id uuid;

ALTER TABLE catalog_private.resources 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE catalog_private.resources 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE catalog_private.resources 
  ADD CONSTRAINT resources_pkey PRIMARY KEY (id);

ALTER TABLE catalog_private.resources 
  ADD COLUMN created_at timestamptz;

ALTER TABLE catalog_private.resources 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE catalog_private.resources 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE catalog_private.resources 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE INDEX resources_created_at_idx ON catalog_private.resources (created_at);

CREATE INDEX resources_updated_at_idx ON catalog_private.resources (updated_at);

ALTER TABLE catalog_private.resources 
  ADD COLUMN owner_scope text;

ALTER TABLE catalog_private.resources 
  ALTER COLUMN owner_scope SET NOT NULL;

COMMENT ON COLUMN catalog_private.resources.owner_scope IS 'Scope of the source table that owns the row';

ALTER TABLE catalog_private.resources 
  ADD COLUMN owner_key uuid;

COMMENT ON COLUMN catalog_private.resources.owner_key IS 'Value of the source table scope key column; NULL for global-tier owners';

ALTER TABLE catalog_private.resources 
  ADD COLUMN is_visible boolean;

ALTER TABLE catalog_private.resources 
  ALTER COLUMN is_visible SET NOT NULL;

ALTER TABLE catalog_private.resources 
  ALTER COLUMN is_visible SET DEFAULT false;

COMMENT ON COLUMN catalog_private.resources.is_visible IS 'Cross-scope visibility flag propagated from the scoped source row';

ALTER TABLE catalog_private.resources 
  ADD COLUMN database_id uuid;

ALTER TABLE catalog_private.resources 
  ALTER COLUMN database_id SET NOT NULL;

COMMENT ON COLUMN catalog_private.resources.database_id IS 'Database that owns the source row: the tenant database for database-scope rows, the hosting database otherwise';

CREATE INDEX resources_owner_scope_owner_key_idx ON catalog_private.resources (owner_scope, owner_key);

CREATE INDEX resources_database_id_idx ON catalog_private.resources (database_id);

ALTER TABLE catalog_private.resources 
  ADD COLUMN namespace_id uuid;

ALTER TABLE catalog_private.resources 
  ALTER COLUMN namespace_id SET NOT NULL;

COMMENT ON COLUMN catalog_private.resources.namespace_id IS 'Namespace the resource lives in (source namespace row id)';

ALTER TABLE catalog_private.resources 
  ADD COLUMN kind text;

ALTER TABLE catalog_private.resources 
  ALTER COLUMN kind SET NOT NULL;

COMMENT ON COLUMN catalog_private.resources.kind IS 'Resource kind';

ALTER TABLE catalog_private.resources 
  ADD COLUMN slug text;

ALTER TABLE catalog_private.resources 
  ALTER COLUMN slug SET NOT NULL;

COMMENT ON COLUMN catalog_private.resources.slug IS 'Resource slug within its namespace and kind';

ALTER TABLE catalog_private.resources 
  ADD CONSTRAINT resources_namespace_id_kind_slug_key 
    UNIQUE (namespace_id, kind, slug);

CREATE TABLE catalog_private.resource_definitions ();

ALTER TABLE catalog_private.resource_definitions 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE catalog_private.resource_definitions IS 'Trigger-maintained typed catalog of resource definitions across all scopes; UNIQUE (namespace_id, kind, slug)';

ALTER TABLE catalog_private.resource_definitions 
  ADD COLUMN id uuid;

ALTER TABLE catalog_private.resource_definitions 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE catalog_private.resource_definitions 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE catalog_private.resource_definitions 
  ADD CONSTRAINT resource_definitions_pkey PRIMARY KEY (id);

ALTER TABLE catalog_private.resource_definitions 
  ADD COLUMN created_at timestamptz;

ALTER TABLE catalog_private.resource_definitions 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE catalog_private.resource_definitions 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE catalog_private.resource_definitions 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE INDEX resource_definitions_created_at_idx ON catalog_private.resource_definitions (created_at);

CREATE INDEX resource_definitions_updated_at_idx ON catalog_private.resource_definitions (updated_at);

ALTER TABLE catalog_private.resource_definitions 
  ADD COLUMN owner_scope text;

ALTER TABLE catalog_private.resource_definitions 
  ALTER COLUMN owner_scope SET NOT NULL;

COMMENT ON COLUMN catalog_private.resource_definitions.owner_scope IS 'Scope of the source table that owns the row';

ALTER TABLE catalog_private.resource_definitions 
  ADD COLUMN owner_key uuid;

COMMENT ON COLUMN catalog_private.resource_definitions.owner_key IS 'Value of the source table scope key column; NULL for global-tier owners';

ALTER TABLE catalog_private.resource_definitions 
  ADD COLUMN is_visible boolean;

ALTER TABLE catalog_private.resource_definitions 
  ALTER COLUMN is_visible SET NOT NULL;

ALTER TABLE catalog_private.resource_definitions 
  ALTER COLUMN is_visible SET DEFAULT false;

COMMENT ON COLUMN catalog_private.resource_definitions.is_visible IS 'Cross-scope visibility flag propagated from the scoped source row';

ALTER TABLE catalog_private.resource_definitions 
  ADD COLUMN database_id uuid;

ALTER TABLE catalog_private.resource_definitions 
  ALTER COLUMN database_id SET NOT NULL;

COMMENT ON COLUMN catalog_private.resource_definitions.database_id IS 'Database that owns the source row: the tenant database for database-scope rows, the hosting database otherwise';

CREATE INDEX resource_definitions_owner_scope_owner_key_idx ON catalog_private.resource_definitions (owner_scope, owner_key);

CREATE INDEX resource_definitions_database_id_idx ON catalog_private.resource_definitions (database_id);

ALTER TABLE catalog_private.resource_definitions 
  ADD COLUMN namespace_id uuid;

ALTER TABLE catalog_private.resource_definitions 
  ALTER COLUMN namespace_id SET NOT NULL;

COMMENT ON COLUMN catalog_private.resource_definitions.namespace_id IS 'Namespace the definition lives in (source namespace row id)';

ALTER TABLE catalog_private.resource_definitions 
  ADD COLUMN kind text;

ALTER TABLE catalog_private.resource_definitions 
  ALTER COLUMN kind SET NOT NULL;

COMMENT ON COLUMN catalog_private.resource_definitions.kind IS 'Definition kind';

ALTER TABLE catalog_private.resource_definitions 
  ADD COLUMN slug text;

ALTER TABLE catalog_private.resource_definitions 
  ALTER COLUMN slug SET NOT NULL;

COMMENT ON COLUMN catalog_private.resource_definitions.slug IS 'Definition slug within its namespace and kind';

ALTER TABLE catalog_private.resource_definitions 
  ADD CONSTRAINT resource_definitions_namespace_id_kind_slug_key 
    UNIQUE (namespace_id, kind, slug);

CREATE TABLE catalog_private.resource_installations ();

ALTER TABLE catalog_private.resource_installations 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE catalog_private.resource_installations IS 'Trigger-maintained typed catalog of resource installations across all scopes; UNIQUE (namespace_id, slug)';

ALTER TABLE catalog_private.resource_installations 
  ADD COLUMN id uuid;

ALTER TABLE catalog_private.resource_installations 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE catalog_private.resource_installations 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE catalog_private.resource_installations 
  ADD CONSTRAINT resource_installations_pkey PRIMARY KEY (id);

ALTER TABLE catalog_private.resource_installations 
  ADD COLUMN created_at timestamptz;

ALTER TABLE catalog_private.resource_installations 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE catalog_private.resource_installations 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE catalog_private.resource_installations 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE INDEX resource_installations_created_at_idx ON catalog_private.resource_installations (created_at);

CREATE INDEX resource_installations_updated_at_idx ON catalog_private.resource_installations (updated_at);

ALTER TABLE catalog_private.resource_installations 
  ADD COLUMN owner_scope text;

ALTER TABLE catalog_private.resource_installations 
  ALTER COLUMN owner_scope SET NOT NULL;

COMMENT ON COLUMN catalog_private.resource_installations.owner_scope IS 'Scope of the source table that owns the row';

ALTER TABLE catalog_private.resource_installations 
  ADD COLUMN owner_key uuid;

COMMENT ON COLUMN catalog_private.resource_installations.owner_key IS 'Value of the source table scope key column; NULL for global-tier owners';

ALTER TABLE catalog_private.resource_installations 
  ADD COLUMN is_visible boolean;

ALTER TABLE catalog_private.resource_installations 
  ALTER COLUMN is_visible SET NOT NULL;

ALTER TABLE catalog_private.resource_installations 
  ALTER COLUMN is_visible SET DEFAULT false;

COMMENT ON COLUMN catalog_private.resource_installations.is_visible IS 'Cross-scope visibility flag propagated from the scoped source row';

ALTER TABLE catalog_private.resource_installations 
  ADD COLUMN database_id uuid;

ALTER TABLE catalog_private.resource_installations 
  ALTER COLUMN database_id SET NOT NULL;

COMMENT ON COLUMN catalog_private.resource_installations.database_id IS 'Database that owns the source row: the tenant database for database-scope rows, the hosting database otherwise';

CREATE INDEX resource_installations_owner_scope_owner_key_idx ON catalog_private.resource_installations (owner_scope, owner_key);

CREATE INDEX resource_installations_database_id_idx ON catalog_private.resource_installations (database_id);

ALTER TABLE catalog_private.resource_installations 
  ADD COLUMN namespace_id uuid;

ALTER TABLE catalog_private.resource_installations 
  ALTER COLUMN namespace_id SET NOT NULL;

COMMENT ON COLUMN catalog_private.resource_installations.namespace_id IS 'Namespace the installation lives in (source namespace row id)';

ALTER TABLE catalog_private.resource_installations 
  ADD COLUMN slug text;

ALTER TABLE catalog_private.resource_installations 
  ALTER COLUMN slug SET NOT NULL;

COMMENT ON COLUMN catalog_private.resource_installations.slug IS 'Installation slug within its namespace';

ALTER TABLE catalog_private.resource_installations 
  ADD CONSTRAINT resource_installations_namespace_id_slug_key 
    UNIQUE (namespace_id, slug);

CREATE TABLE catalog_private.apps ();

ALTER TABLE catalog_private.apps 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE catalog_private.apps IS 'Trigger-maintained typed catalog of app aggregates across all scopes';

ALTER TABLE catalog_private.apps 
  ADD COLUMN id uuid;

ALTER TABLE catalog_private.apps 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE catalog_private.apps 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE catalog_private.apps 
  ADD CONSTRAINT apps_pkey PRIMARY KEY (id);

ALTER TABLE catalog_private.apps 
  ADD COLUMN created_at timestamptz;

ALTER TABLE catalog_private.apps 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE catalog_private.apps 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE catalog_private.apps 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE INDEX apps_created_at_idx ON catalog_private.apps (created_at);

CREATE INDEX apps_updated_at_idx ON catalog_private.apps (updated_at);

ALTER TABLE catalog_private.apps 
  ADD COLUMN owner_scope text;

ALTER TABLE catalog_private.apps 
  ALTER COLUMN owner_scope SET NOT NULL;

COMMENT ON COLUMN catalog_private.apps.owner_scope IS 'Scope of the source table that owns the row';

ALTER TABLE catalog_private.apps 
  ADD COLUMN owner_key uuid;

COMMENT ON COLUMN catalog_private.apps.owner_key IS 'Value of the source table scope key column; NULL for global-tier owners';

ALTER TABLE catalog_private.apps 
  ADD COLUMN is_visible boolean;

ALTER TABLE catalog_private.apps 
  ALTER COLUMN is_visible SET NOT NULL;

ALTER TABLE catalog_private.apps 
  ALTER COLUMN is_visible SET DEFAULT false;

COMMENT ON COLUMN catalog_private.apps.is_visible IS 'Cross-scope visibility flag propagated from the scoped source row';

ALTER TABLE catalog_private.apps 
  ADD COLUMN database_id uuid;

ALTER TABLE catalog_private.apps 
  ALTER COLUMN database_id SET NOT NULL;

COMMENT ON COLUMN catalog_private.apps.database_id IS 'Database that owns the source row: the tenant database for database-scope rows, the hosting database otherwise';

CREATE INDEX apps_owner_scope_owner_key_idx ON catalog_private.apps (owner_scope, owner_key);

CREATE INDEX apps_database_id_idx ON catalog_private.apps (database_id);

ALTER TABLE catalog_private.apps 
  ADD COLUMN name text;

ALTER TABLE catalog_private.apps 
  ALTER COLUMN name SET NOT NULL;

COMMENT ON COLUMN catalog_private.apps.name IS 'Owner-local app name';

ALTER TABLE catalog_private.apps 
  ADD COLUMN config jsonb;

COMMENT ON COLUMN catalog_private.apps.config IS 'App configuration propagated from the source row';

CREATE UNIQUE INDEX apps_owner_scope_owner_key_name_idx ON catalog_private.apps (owner_scope, owner_key, name) WHERE apps.owner_key IS NOT NULL;

CREATE UNIQUE INDEX apps_owner_scope_name_idx ON catalog_private.apps (owner_scope, name) WHERE apps.owner_key IS NULL;

CREATE INDEX apps_is_visible_idx ON catalog_private.apps (is_visible);

CREATE TABLE catalog_private.buckets ();

ALTER TABLE catalog_private.buckets 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE catalog_private.buckets IS 'Trigger-maintained typed catalog of storage buckets across all scopes';

ALTER TABLE catalog_private.buckets 
  ADD COLUMN id uuid;

ALTER TABLE catalog_private.buckets 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE catalog_private.buckets 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE catalog_private.buckets 
  ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);

ALTER TABLE catalog_private.buckets 
  ADD COLUMN created_at timestamptz;

ALTER TABLE catalog_private.buckets 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE catalog_private.buckets 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE catalog_private.buckets 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE INDEX buckets_created_at_idx ON catalog_private.buckets (created_at);

CREATE INDEX buckets_updated_at_idx ON catalog_private.buckets (updated_at);

ALTER TABLE catalog_private.buckets 
  ADD COLUMN owner_scope text;

ALTER TABLE catalog_private.buckets 
  ALTER COLUMN owner_scope SET NOT NULL;

COMMENT ON COLUMN catalog_private.buckets.owner_scope IS 'Scope of the source table that owns the row';

ALTER TABLE catalog_private.buckets 
  ADD COLUMN owner_key uuid;

COMMENT ON COLUMN catalog_private.buckets.owner_key IS 'Value of the source table scope key column; NULL for global-tier owners';

ALTER TABLE catalog_private.buckets 
  ADD COLUMN is_visible boolean;

ALTER TABLE catalog_private.buckets 
  ALTER COLUMN is_visible SET NOT NULL;

ALTER TABLE catalog_private.buckets 
  ALTER COLUMN is_visible SET DEFAULT false;

COMMENT ON COLUMN catalog_private.buckets.is_visible IS 'Cross-scope visibility flag propagated from the scoped source row';

ALTER TABLE catalog_private.buckets 
  ADD COLUMN database_id uuid;

ALTER TABLE catalog_private.buckets 
  ALTER COLUMN database_id SET NOT NULL;

COMMENT ON COLUMN catalog_private.buckets.database_id IS 'Database that owns the source row: the tenant database for database-scope rows, the hosting database otherwise';

CREATE INDEX buckets_owner_scope_owner_key_idx ON catalog_private.buckets (owner_scope, owner_key);

CREATE INDEX buckets_database_id_idx ON catalog_private.buckets (database_id);

ALTER TABLE catalog_private.buckets 
  ADD COLUMN key text;

ALTER TABLE catalog_private.buckets 
  ALTER COLUMN key SET NOT NULL;

COMMENT ON COLUMN catalog_private.buckets.key IS 'Owner-local logical bucket key propagated from the source row';

ALTER TABLE catalog_private.buckets 
  ADD COLUMN type text;

ALTER TABLE catalog_private.buckets 
  ALTER COLUMN type SET NOT NULL;

COMMENT ON COLUMN catalog_private.buckets.type IS 'Bucket type (public/private) propagated from the source row';

ALTER TABLE catalog_private.buckets 
  ADD COLUMN physical_name text;

COMMENT ON COLUMN catalog_private.buckets.physical_name IS 'Physical S3/MinIO bucket name propagated from the source row (NULL until the physical bucket exists)';

ALTER TABLE catalog_private.buckets 
  ADD COLUMN tags text[];

COMMENT ON COLUMN catalog_private.buckets.tags IS 'Selector labels propagated from the source row (see the buckets table''s tags)';

CREATE INDEX buckets_tags_gin_idx ON catalog_private.buckets USING gin (tags);

CREATE UNIQUE INDEX buckets_database_id_owner_scope_owner_key_key_idx ON catalog_private.buckets (database_id, owner_scope, owner_key, key) WHERE buckets.owner_key IS NOT NULL;

CREATE UNIQUE INDEX buckets_database_id_owner_scope_key_idx ON catalog_private.buckets (database_id, owner_scope, key) WHERE buckets.owner_key IS NULL;

CREATE INDEX buckets_is_visible_idx ON catalog_private.buckets (is_visible);

CREATE TABLE catalog_private.bindings ();

ALTER TABLE catalog_private.bindings 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE catalog_private.bindings IS 'Trigger-maintained typed catalog of capability bindings across all scopes';

ALTER TABLE catalog_private.bindings 
  ADD COLUMN id uuid;

ALTER TABLE catalog_private.bindings 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE catalog_private.bindings 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE catalog_private.bindings 
  ADD CONSTRAINT bindings_pkey PRIMARY KEY (id);

ALTER TABLE catalog_private.bindings 
  ADD COLUMN created_at timestamptz;

ALTER TABLE catalog_private.bindings 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE catalog_private.bindings 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE catalog_private.bindings 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE INDEX bindings_created_at_idx ON catalog_private.bindings (created_at);

CREATE INDEX bindings_updated_at_idx ON catalog_private.bindings (updated_at);

ALTER TABLE catalog_private.bindings 
  ADD COLUMN owner_scope text;

ALTER TABLE catalog_private.bindings 
  ALTER COLUMN owner_scope SET NOT NULL;

COMMENT ON COLUMN catalog_private.bindings.owner_scope IS 'Scope of the source table that owns the row';

ALTER TABLE catalog_private.bindings 
  ADD COLUMN owner_key uuid;

COMMENT ON COLUMN catalog_private.bindings.owner_key IS 'Value of the source table scope key column; NULL for global-tier owners';

ALTER TABLE catalog_private.bindings 
  ADD COLUMN is_visible boolean;

ALTER TABLE catalog_private.bindings 
  ALTER COLUMN is_visible SET NOT NULL;

ALTER TABLE catalog_private.bindings 
  ALTER COLUMN is_visible SET DEFAULT false;

COMMENT ON COLUMN catalog_private.bindings.is_visible IS 'Cross-scope visibility flag propagated from the scoped source row';

ALTER TABLE catalog_private.bindings 
  ADD COLUMN database_id uuid;

ALTER TABLE catalog_private.bindings 
  ALTER COLUMN database_id SET NOT NULL;

COMMENT ON COLUMN catalog_private.bindings.database_id IS 'Database that owns the source row: the tenant database for database-scope rows, the hosting database otherwise';

CREATE INDEX bindings_owner_scope_owner_key_idx ON catalog_private.bindings (owner_scope, owner_key);

CREATE INDEX bindings_database_id_idx ON catalog_private.bindings (database_id);

ALTER TABLE catalog_private.bindings 
  ADD COLUMN function_id uuid;

COMMENT ON COLUMN catalog_private.bindings.function_id IS 'Function definition holding the binding, propagated from the source row';

ALTER TABLE catalog_private.bindings 
  ADD COLUMN graph_id uuid;

COMMENT ON COLUMN catalog_private.bindings.graph_id IS 'Flow graph holding the binding, propagated from the source row';

ALTER TABLE catalog_private.bindings 
  ADD COLUMN bucket_id uuid;

COMMENT ON COLUMN catalog_private.bindings.bucket_id IS 'Bucket the binding targets, propagated from the source row';

ALTER TABLE catalog_private.bindings 
  ADD COLUMN lifecycle text;

ALTER TABLE catalog_private.bindings 
  ALTER COLUMN lifecycle SET NOT NULL;

COMMENT ON COLUMN catalog_private.bindings.lifecycle IS 'Lifecycle the binding applies to (deployment/execution/root_execution), propagated from the source row';

ALTER TABLE catalog_private.bindings 
  ADD COLUMN key text;

ALTER TABLE catalog_private.bindings 
  ALTER COLUMN key SET NOT NULL;

COMMENT ON COLUMN catalog_private.bindings.key IS 'Capability key the binding fulfils, propagated from the source row';

CREATE INDEX bindings_function_id_key_database_id_owner_scope_owner_key_idx ON catalog_private.bindings (function_id, key, database_id, owner_scope, owner_key);

CREATE INDEX bindings_graph_id_key_database_id_owner_scope_owner_key_idx ON catalog_private.bindings (graph_id, key, database_id, owner_scope, owner_key);

CREATE INDEX bindings_bucket_id_idx ON catalog_private.bindings (bucket_id);

CREATE TABLE catalog_private.sites_web_config ();

ALTER TABLE catalog_private.sites_web_config 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE catalog_private.sites_web_config IS 'Trigger-maintained typed catalog mirror of site web-config across all scopes';

ALTER TABLE catalog_private.sites_web_config 
  ADD COLUMN id uuid;

ALTER TABLE catalog_private.sites_web_config 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE catalog_private.sites_web_config 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE catalog_private.sites_web_config 
  ADD CONSTRAINT sites_web_configs_pkey PRIMARY KEY (id);

ALTER TABLE catalog_private.sites_web_config 
  ADD COLUMN created_at timestamptz;

ALTER TABLE catalog_private.sites_web_config 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE catalog_private.sites_web_config 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE catalog_private.sites_web_config 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE INDEX sites_web_config_created_at_idx ON catalog_private.sites_web_config (created_at);

CREATE INDEX sites_web_config_updated_at_idx ON catalog_private.sites_web_config (updated_at);

ALTER TABLE catalog_private.sites_web_config 
  ADD COLUMN owner_scope text;

ALTER TABLE catalog_private.sites_web_config 
  ALTER COLUMN owner_scope SET NOT NULL;

COMMENT ON COLUMN catalog_private.sites_web_config.owner_scope IS 'Scope of the source table that owns the row';

ALTER TABLE catalog_private.sites_web_config 
  ADD COLUMN owner_key uuid;

COMMENT ON COLUMN catalog_private.sites_web_config.owner_key IS 'Value of the source table scope key column; NULL for global-tier owners';

ALTER TABLE catalog_private.sites_web_config 
  ADD COLUMN is_visible boolean;

ALTER TABLE catalog_private.sites_web_config 
  ALTER COLUMN is_visible SET NOT NULL;

ALTER TABLE catalog_private.sites_web_config 
  ALTER COLUMN is_visible SET DEFAULT false;

COMMENT ON COLUMN catalog_private.sites_web_config.is_visible IS 'Cross-scope visibility flag propagated from the scoped source row';

ALTER TABLE catalog_private.sites_web_config 
  ADD COLUMN database_id uuid;

ALTER TABLE catalog_private.sites_web_config 
  ALTER COLUMN database_id SET NOT NULL;

COMMENT ON COLUMN catalog_private.sites_web_config.database_id IS 'Database that owns the source row: the tenant database for database-scope rows, the hosting database otherwise';

CREATE INDEX sites_web_configs_owner_scope_owner_key_idx ON catalog_private.sites_web_config (owner_scope, owner_key);

CREATE INDEX sites_web_configs_database_id_idx ON catalog_private.sites_web_config (database_id);

ALTER TABLE catalog_private.sites_web_config 
  ADD COLUMN site_id uuid;

ALTER TABLE catalog_private.sites_web_config 
  ALTER COLUMN site_id SET NOT NULL;

COMMENT ON COLUMN catalog_private.sites_web_config.site_id IS 'Site this configuration belongs to (resolver join key propagated from the source row)';

ALTER TABLE catalog_private.sites_web_config 
  ADD COLUMN index_document text;

COMMENT ON COLUMN catalog_private.sites_web_config.index_document IS 'Default object served for directory-style requests, propagated from the source row';

ALTER TABLE catalog_private.sites_web_config 
  ADD COLUMN clean_urls boolean;

COMMENT ON COLUMN catalog_private.sites_web_config.clean_urls IS 'Extensionless path resolution flag propagated from the source row (NULL = gateway default)';

ALTER TABLE catalog_private.sites_web_config 
  ADD COLUMN spa_fallback boolean;

COMMENT ON COLUMN catalog_private.sites_web_config.spa_fallback IS 'SPA fallback flag propagated from the source row (NULL = gateway default)';

ALTER TABLE catalog_private.sites_web_config 
  ADD COLUMN metadata jsonb;

COMMENT ON COLUMN catalog_private.sites_web_config.metadata IS 'Additional serving configuration propagated from the source row';

CREATE UNIQUE INDEX sites_web_configs_site_id_idx ON catalog_private.sites_web_config (site_id);

CREATE TABLE catalog_private.sites_error_pages ();

ALTER TABLE catalog_private.sites_error_pages 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE catalog_private.sites_error_pages IS 'Trigger-maintained typed catalog mirror of site error pages across all scopes';

ALTER TABLE catalog_private.sites_error_pages 
  ADD COLUMN id uuid;

ALTER TABLE catalog_private.sites_error_pages 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE catalog_private.sites_error_pages 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE catalog_private.sites_error_pages 
  ADD CONSTRAINT sites_error_pages_pkey PRIMARY KEY (id);

ALTER TABLE catalog_private.sites_error_pages 
  ADD COLUMN created_at timestamptz;

ALTER TABLE catalog_private.sites_error_pages 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE catalog_private.sites_error_pages 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE catalog_private.sites_error_pages 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE INDEX sites_error_pages_created_at_idx ON catalog_private.sites_error_pages (created_at);

CREATE INDEX sites_error_pages_updated_at_idx ON catalog_private.sites_error_pages (updated_at);

ALTER TABLE catalog_private.sites_error_pages 
  ADD COLUMN owner_scope text;

ALTER TABLE catalog_private.sites_error_pages 
  ALTER COLUMN owner_scope SET NOT NULL;

COMMENT ON COLUMN catalog_private.sites_error_pages.owner_scope IS 'Scope of the source table that owns the row';

ALTER TABLE catalog_private.sites_error_pages 
  ADD COLUMN owner_key uuid;

COMMENT ON COLUMN catalog_private.sites_error_pages.owner_key IS 'Value of the source table scope key column; NULL for global-tier owners';

ALTER TABLE catalog_private.sites_error_pages 
  ADD COLUMN is_visible boolean;

ALTER TABLE catalog_private.sites_error_pages 
  ALTER COLUMN is_visible SET NOT NULL;

ALTER TABLE catalog_private.sites_error_pages 
  ALTER COLUMN is_visible SET DEFAULT false;

COMMENT ON COLUMN catalog_private.sites_error_pages.is_visible IS 'Cross-scope visibility flag propagated from the scoped source row';

ALTER TABLE catalog_private.sites_error_pages 
  ADD COLUMN database_id uuid;

ALTER TABLE catalog_private.sites_error_pages 
  ALTER COLUMN database_id SET NOT NULL;

COMMENT ON COLUMN catalog_private.sites_error_pages.database_id IS 'Database that owns the source row: the tenant database for database-scope rows, the hosting database otherwise';

CREATE INDEX sites_error_pages_owner_scope_owner_key_idx ON catalog_private.sites_error_pages (owner_scope, owner_key);

CREATE INDEX sites_error_pages_database_id_idx ON catalog_private.sites_error_pages (database_id);

ALTER TABLE catalog_private.sites_error_pages 
  ADD COLUMN site_id uuid;

ALTER TABLE catalog_private.sites_error_pages 
  ALTER COLUMN site_id SET NOT NULL;

COMMENT ON COLUMN catalog_private.sites_error_pages.site_id IS 'Site this error page belongs to (resolver aggregation key propagated from the source row)';

ALTER TABLE catalog_private.sites_error_pages 
  ADD COLUMN status_code int;

ALTER TABLE catalog_private.sites_error_pages 
  ALTER COLUMN status_code SET NOT NULL;

COMMENT ON COLUMN catalog_private.sites_error_pages.status_code IS 'HTTP status code this custom page is served for, propagated from the source row';

ALTER TABLE catalog_private.sites_error_pages 
  ADD COLUMN object_path text;

ALTER TABLE catalog_private.sites_error_pages 
  ALTER COLUMN object_path SET NOT NULL;

COMMENT ON COLUMN catalog_private.sites_error_pages.object_path IS 'Bucket object served for this status code, propagated from the source row';

CREATE INDEX sites_error_pages_site_id_idx ON catalog_private.sites_error_pages (site_id);

CREATE TABLE catalog_private.sites_app_links ();

ALTER TABLE catalog_private.sites_app_links 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE catalog_private.sites_app_links IS 'Trigger-maintained typed catalog mirror of site app-link associations across all scopes';

ALTER TABLE catalog_private.sites_app_links 
  ADD COLUMN id uuid;

ALTER TABLE catalog_private.sites_app_links 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE catalog_private.sites_app_links 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE catalog_private.sites_app_links 
  ADD CONSTRAINT sites_app_links_pkey PRIMARY KEY (id);

ALTER TABLE catalog_private.sites_app_links 
  ADD COLUMN created_at timestamptz;

ALTER TABLE catalog_private.sites_app_links 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE catalog_private.sites_app_links 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE catalog_private.sites_app_links 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE INDEX sites_app_links_created_at_idx ON catalog_private.sites_app_links (created_at);

CREATE INDEX sites_app_links_updated_at_idx ON catalog_private.sites_app_links (updated_at);

ALTER TABLE catalog_private.sites_app_links 
  ADD COLUMN owner_scope text;

ALTER TABLE catalog_private.sites_app_links 
  ALTER COLUMN owner_scope SET NOT NULL;

COMMENT ON COLUMN catalog_private.sites_app_links.owner_scope IS 'Scope of the source table that owns the row';

ALTER TABLE catalog_private.sites_app_links 
  ADD COLUMN owner_key uuid;

COMMENT ON COLUMN catalog_private.sites_app_links.owner_key IS 'Value of the source table scope key column; NULL for global-tier owners';

ALTER TABLE catalog_private.sites_app_links 
  ADD COLUMN is_visible boolean;

ALTER TABLE catalog_private.sites_app_links 
  ALTER COLUMN is_visible SET NOT NULL;

ALTER TABLE catalog_private.sites_app_links 
  ALTER COLUMN is_visible SET DEFAULT false;

COMMENT ON COLUMN catalog_private.sites_app_links.is_visible IS 'Cross-scope visibility flag propagated from the scoped source row';

ALTER TABLE catalog_private.sites_app_links 
  ADD COLUMN database_id uuid;

ALTER TABLE catalog_private.sites_app_links 
  ALTER COLUMN database_id SET NOT NULL;

COMMENT ON COLUMN catalog_private.sites_app_links.database_id IS 'Database that owns the source row: the tenant database for database-scope rows, the hosting database otherwise';

CREATE INDEX sites_app_links_owner_scope_owner_key_idx ON catalog_private.sites_app_links (owner_scope, owner_key);

CREATE INDEX sites_app_links_database_id_idx ON catalog_private.sites_app_links (database_id);

ALTER TABLE catalog_private.sites_app_links 
  ADD COLUMN site_id uuid;

ALTER TABLE catalog_private.sites_app_links 
  ALTER COLUMN site_id SET NOT NULL;

COMMENT ON COLUMN catalog_private.sites_app_links.site_id IS 'Site this app-link association belongs to (serving-edge aggregation key propagated from the source row)';

ALTER TABLE catalog_private.sites_app_links 
  ADD COLUMN platform text;

ALTER TABLE catalog_private.sites_app_links 
  ALTER COLUMN platform SET NOT NULL;

COMMENT ON COLUMN catalog_private.sites_app_links.platform IS 'Target platform for this association (ios, android), propagated from the source row';

ALTER TABLE catalog_private.sites_app_links 
  ADD COLUMN app_identifier text;

ALTER TABLE catalog_private.sites_app_links 
  ALTER COLUMN app_identifier SET NOT NULL;

COMMENT ON COLUMN catalog_private.sites_app_links.app_identifier IS 'App identifier (iOS bundle id or Android package name), propagated from the source row';

ALTER TABLE catalog_private.sites_app_links 
  ADD COLUMN team_id text;

COMMENT ON COLUMN catalog_private.sites_app_links.team_id IS 'Apple Developer team id, propagated from the source row';

ALTER TABLE catalog_private.sites_app_links 
  ADD COLUMN sha256_cert_fingerprints text[];

ALTER TABLE catalog_private.sites_app_links 
  ALTER COLUMN sha256_cert_fingerprints SET NOT NULL;

ALTER TABLE catalog_private.sites_app_links 
  ALTER COLUMN sha256_cert_fingerprints SET DEFAULT CAST(ARRAY[] AS text[]);

COMMENT ON COLUMN catalog_private.sites_app_links.sha256_cert_fingerprints IS 'Android signing certificate SHA-256 fingerprints, propagated from the source row';

ALTER TABLE catalog_private.sites_app_links 
  ADD COLUMN path_components text[];

ALTER TABLE catalog_private.sites_app_links 
  ALTER COLUMN path_components SET NOT NULL;

ALTER TABLE catalog_private.sites_app_links 
  ALTER COLUMN path_components SET DEFAULT CAST(ARRAY[] AS text[]);

COMMENT ON COLUMN catalog_private.sites_app_links.path_components IS 'Path patterns this association applies to, propagated from the source row';

ALTER TABLE catalog_private.sites_app_links 
  ADD COLUMN webcredentials boolean;

ALTER TABLE catalog_private.sites_app_links 
  ALTER COLUMN webcredentials SET NOT NULL;

ALTER TABLE catalog_private.sites_app_links 
  ALTER COLUMN webcredentials SET DEFAULT false;

COMMENT ON COLUMN catalog_private.sites_app_links.webcredentials IS 'Whether to emit the webcredentials service, propagated from the source row';

ALTER TABLE catalog_private.sites_app_links 
  ADD COLUMN store_url text;

COMMENT ON COLUMN catalog_private.sites_app_links.store_url IS 'App/Play store URL, propagated from the source row';

CREATE INDEX sites_app_links_site_id_idx ON catalog_private.sites_app_links (site_id);

CREATE TABLE catalog_private.sites_deep_links ();

ALTER TABLE catalog_private.sites_deep_links 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE catalog_private.sites_deep_links IS 'Trigger-maintained typed catalog mirror of site deep links across all scopes';

ALTER TABLE catalog_private.sites_deep_links 
  ADD COLUMN id uuid;

ALTER TABLE catalog_private.sites_deep_links 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE catalog_private.sites_deep_links 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE catalog_private.sites_deep_links 
  ADD CONSTRAINT sites_deep_links_pkey PRIMARY KEY (id);

ALTER TABLE catalog_private.sites_deep_links 
  ADD COLUMN created_at timestamptz;

ALTER TABLE catalog_private.sites_deep_links 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE catalog_private.sites_deep_links 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE catalog_private.sites_deep_links 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE INDEX sites_deep_links_created_at_idx ON catalog_private.sites_deep_links (created_at);

CREATE INDEX sites_deep_links_updated_at_idx ON catalog_private.sites_deep_links (updated_at);

ALTER TABLE catalog_private.sites_deep_links 
  ADD COLUMN owner_scope text;

ALTER TABLE catalog_private.sites_deep_links 
  ALTER COLUMN owner_scope SET NOT NULL;

COMMENT ON COLUMN catalog_private.sites_deep_links.owner_scope IS 'Scope of the source table that owns the row';

ALTER TABLE catalog_private.sites_deep_links 
  ADD COLUMN owner_key uuid;

COMMENT ON COLUMN catalog_private.sites_deep_links.owner_key IS 'Value of the source table scope key column; NULL for global-tier owners';

ALTER TABLE catalog_private.sites_deep_links 
  ADD COLUMN is_visible boolean;

ALTER TABLE catalog_private.sites_deep_links 
  ALTER COLUMN is_visible SET NOT NULL;

ALTER TABLE catalog_private.sites_deep_links 
  ALTER COLUMN is_visible SET DEFAULT false;

COMMENT ON COLUMN catalog_private.sites_deep_links.is_visible IS 'Cross-scope visibility flag propagated from the scoped source row';

ALTER TABLE catalog_private.sites_deep_links 
  ADD COLUMN database_id uuid;

ALTER TABLE catalog_private.sites_deep_links 
  ALTER COLUMN database_id SET NOT NULL;

COMMENT ON COLUMN catalog_private.sites_deep_links.database_id IS 'Database that owns the source row: the tenant database for database-scope rows, the hosting database otherwise';

CREATE INDEX sites_deep_links_owner_scope_owner_key_idx ON catalog_private.sites_deep_links (owner_scope, owner_key);

CREATE INDEX sites_deep_links_database_id_idx ON catalog_private.sites_deep_links (database_id);

ALTER TABLE catalog_private.sites_deep_links 
  ADD COLUMN site_id uuid;

ALTER TABLE catalog_private.sites_deep_links 
  ALTER COLUMN site_id SET NOT NULL;

COMMENT ON COLUMN catalog_private.sites_deep_links.site_id IS 'Site this deep link belongs to (serving-edge lookup key propagated from the source row)';

ALTER TABLE catalog_private.sites_deep_links 
  ADD COLUMN slug text;

ALTER TABLE catalog_private.sites_deep_links 
  ALTER COLUMN slug SET NOT NULL;

COMMENT ON COLUMN catalog_private.sites_deep_links.slug IS 'Link name unique per site, propagated from the source row';

ALTER TABLE catalog_private.sites_deep_links 
  ADD COLUMN app_path text;

ALTER TABLE catalog_private.sites_deep_links 
  ALTER COLUMN app_path SET NOT NULL;

COMMENT ON COLUMN catalog_private.sites_deep_links.app_path IS 'In-app route the installed app opens, propagated from the source row';

ALTER TABLE catalog_private.sites_deep_links 
  ADD COLUMN web_path text;

COMMENT ON COLUMN catalog_private.sites_deep_links.web_path IS 'Web fallback path on the owning site, propagated from the source row';

ALTER TABLE catalog_private.sites_deep_links 
  ADD COLUMN fallback_url text;

COMMENT ON COLUMN catalog_private.sites_deep_links.fallback_url IS 'Absolute external fallback URL, propagated from the source row';

CREATE UNIQUE INDEX sites_deep_links_site_id_slug_idx ON catalog_private.sites_deep_links (site_id, slug);

GRANT SELECT ON catalog_private.domains TO authenticated;

GRANT INSERT ON catalog_private.domains TO authenticated;

GRANT UPDATE ON catalog_private.domains TO authenticated;

GRANT DELETE ON catalog_private.domains TO authenticated;

GRANT SELECT ON catalog_private.apis TO authenticated;

GRANT INSERT ON catalog_private.apis TO authenticated;

GRANT UPDATE ON catalog_private.apis TO authenticated;

GRANT DELETE ON catalog_private.apis TO authenticated;

GRANT SELECT ON catalog_private.sites TO authenticated;

GRANT INSERT ON catalog_private.sites TO authenticated;

GRANT UPDATE ON catalog_private.sites TO authenticated;

GRANT DELETE ON catalog_private.sites TO authenticated;

GRANT SELECT ON catalog_private.namespaces TO authenticated;

GRANT INSERT ON catalog_private.namespaces TO authenticated;

GRANT UPDATE ON catalog_private.namespaces TO authenticated;

GRANT DELETE ON catalog_private.namespaces TO authenticated;

GRANT SELECT ON catalog_private.functions TO authenticated;

GRANT INSERT ON catalog_private.functions TO authenticated;

GRANT UPDATE ON catalog_private.functions TO authenticated;

GRANT DELETE ON catalog_private.functions TO authenticated;

GRANT SELECT ON catalog_private.resources TO authenticated;

GRANT INSERT ON catalog_private.resources TO authenticated;

GRANT UPDATE ON catalog_private.resources TO authenticated;

GRANT DELETE ON catalog_private.resources TO authenticated;

GRANT SELECT ON catalog_private.resource_definitions TO authenticated;

GRANT INSERT ON catalog_private.resource_definitions TO authenticated;

GRANT UPDATE ON catalog_private.resource_definitions TO authenticated;

GRANT DELETE ON catalog_private.resource_definitions TO authenticated;

GRANT SELECT ON catalog_private.resource_installations TO authenticated;

GRANT INSERT ON catalog_private.resource_installations TO authenticated;

GRANT UPDATE ON catalog_private.resource_installations TO authenticated;

GRANT DELETE ON catalog_private.resource_installations TO authenticated;

GRANT SELECT ON catalog_private.apps TO authenticated;

GRANT INSERT ON catalog_private.apps TO authenticated;

GRANT UPDATE ON catalog_private.apps TO authenticated;

GRANT DELETE ON catalog_private.apps TO authenticated;

GRANT SELECT ON catalog_private.buckets TO authenticated;

GRANT INSERT ON catalog_private.buckets TO authenticated;

GRANT UPDATE ON catalog_private.buckets TO authenticated;

GRANT DELETE ON catalog_private.buckets TO authenticated;

GRANT SELECT ON catalog_private.bindings TO authenticated;

GRANT INSERT ON catalog_private.bindings TO authenticated;

GRANT UPDATE ON catalog_private.bindings TO authenticated;

GRANT DELETE ON catalog_private.bindings TO authenticated;

GRANT SELECT ON catalog_private.sites_web_config TO authenticated;

GRANT INSERT ON catalog_private.sites_web_config TO authenticated;

GRANT UPDATE ON catalog_private.sites_web_config TO authenticated;

GRANT DELETE ON catalog_private.sites_web_config TO authenticated;

GRANT SELECT ON catalog_private.sites_error_pages TO authenticated;

GRANT INSERT ON catalog_private.sites_error_pages TO authenticated;

GRANT UPDATE ON catalog_private.sites_error_pages TO authenticated;

GRANT DELETE ON catalog_private.sites_error_pages TO authenticated;

GRANT SELECT ON catalog_private.sites_app_links TO authenticated;

GRANT INSERT ON catalog_private.sites_app_links TO authenticated;

GRANT UPDATE ON catalog_private.sites_app_links TO authenticated;

GRANT DELETE ON catalog_private.sites_app_links TO authenticated;

GRANT SELECT ON catalog_private.sites_deep_links TO authenticated;

GRANT INSERT ON catalog_private.sites_deep_links TO authenticated;

GRANT UPDATE ON catalog_private.sites_deep_links TO authenticated;

GRANT DELETE ON catalog_private.sites_deep_links TO authenticated;

CREATE FUNCTION catalog_private.tg_platform_domains_catalog_sync() RETURNS trigger AS $EOFCODE$BEGIN
  INSERT INTO catalog_private.domains (
    id,
    owner_scope,
    owner_key,
    is_visible,
    database_id,
    hostname,
    is_wildcard,
    parent_hostname,
    managed,
    verification_status,
    tls_status,
    tls_secret_name
  ) VALUES
    (new.id, 'platform', NULL, COALESCE(new.is_published, false), jwt_private.current_database_id(), new.hostname, new.is_wildcard, new.parent_hostname, new.managed, new.verification_status, new.tls_status, new.tls_secret_name) ON CONFLICT (id) DO UPDATE SET 
    owner_key = excluded.owner_key,
    is_visible = excluded.is_visible,
    database_id = excluded.database_id,
    hostname = excluded.hostname,
    is_wildcard = excluded.is_wildcard,
    parent_hostname = excluded.parent_hostname,
    managed = excluded.managed,
    verification_status = excluded.verification_status,
    tls_status = excluded.tls_status,
    tls_secret_name = excluded.tls_secret_name;
  RETURN NEW;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_platform_domains_catalog_del() RETURNS trigger AS $EOFCODE$BEGIN
  DELETE FROM catalog_private.domains WHERE id = old.id;
  RETURN OLD;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_domains_catalog_sync() RETURNS trigger AS $EOFCODE$BEGIN
  INSERT INTO catalog_private.domains (
    id,
    owner_scope,
    owner_key,
    is_visible,
    database_id,
    hostname,
    is_wildcard,
    parent_hostname,
    managed,
    verification_status,
    tls_status,
    tls_secret_name
  ) VALUES
    (new.id, 'database', new.database_id, COALESCE(new.is_published, false), new.database_id, new.hostname, new.is_wildcard, new.parent_hostname, new.managed, new.verification_status, new.tls_status, new.tls_secret_name) ON CONFLICT (id) DO UPDATE SET 
    owner_key = excluded.owner_key,
    is_visible = excluded.is_visible,
    database_id = excluded.database_id,
    hostname = excluded.hostname,
    is_wildcard = excluded.is_wildcard,
    parent_hostname = excluded.parent_hostname,
    managed = excluded.managed,
    verification_status = excluded.verification_status,
    tls_status = excluded.tls_status,
    tls_secret_name = excluded.tls_secret_name;
  RETURN NEW;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_domains_catalog_del() RETURNS trigger AS $EOFCODE$BEGIN
  DELETE FROM catalog_private.domains WHERE id = old.id;
  RETURN OLD;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_platform_apis_catalog_sync() RETURNS trigger AS $EOFCODE$BEGIN
  INSERT INTO catalog_private.apis (
    id,
    owner_scope,
    owner_key,
    is_visible,
    database_id,
    name,
    dbname,
    role_name,
    anon_role,
    config
  ) VALUES
    (new.id, 'platform', NULL, COALESCE(new.is_published, false), jwt_private.current_database_id(), new.name, new.dbname, new.role_name, new.anon_role, new.config) ON CONFLICT (id) DO UPDATE SET 
    owner_key = excluded.owner_key,
    is_visible = excluded.is_visible,
    database_id = excluded.database_id,
    name = excluded.name,
    dbname = excluded.dbname,
    role_name = excluded.role_name,
    anon_role = excluded.anon_role,
    config = excluded.config;
  RETURN NEW;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_platform_apis_catalog_del() RETURNS trigger AS $EOFCODE$BEGIN
  DELETE FROM catalog_private.apis WHERE id = old.id;
  RETURN OLD;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_apis_catalog_sync() RETURNS trigger AS $EOFCODE$BEGIN
  INSERT INTO catalog_private.apis (
    id,
    owner_scope,
    owner_key,
    is_visible,
    database_id,
    name,
    dbname,
    role_name,
    anon_role,
    config
  ) VALUES
    (new.id, 'database', new.database_id, COALESCE(new.is_published, false), new.database_id, new.name, new.dbname, new.role_name, new.anon_role, new.config) ON CONFLICT (id) DO UPDATE SET 
    owner_key = excluded.owner_key,
    is_visible = excluded.is_visible,
    database_id = excluded.database_id,
    name = excluded.name,
    dbname = excluded.dbname,
    role_name = excluded.role_name,
    anon_role = excluded.anon_role,
    config = excluded.config;
  RETURN NEW;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_apis_catalog_del() RETURNS trigger AS $EOFCODE$BEGIN
  DELETE FROM catalog_private.apis WHERE id = old.id;
  RETURN OLD;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_platform_sites_catalog_sync() RETURNS trigger AS $EOFCODE$BEGIN
  INSERT INTO catalog_private.sites (
    id,
    owner_scope,
    owner_key,
    is_visible,
    database_id,
    name,
    title,
    description,
    bucket_id,
    resource_id,
    installation_id,
    installation_member_slug
  ) VALUES
    (new.id, 'platform', NULL, COALESCE(new.is_published, false), jwt_private.current_database_id(), new.name, new.title, new.description, new.bucket_id, new.resource_id, new.installation_id, new.installation_member_slug) ON CONFLICT (id) DO UPDATE SET 
    owner_key = excluded.owner_key,
    is_visible = excluded.is_visible,
    database_id = excluded.database_id,
    name = excluded.name,
    title = excluded.title,
    description = excluded.description,
    bucket_id = excluded.bucket_id,
    resource_id = excluded.resource_id,
    installation_id = excluded.installation_id,
    installation_member_slug = excluded.installation_member_slug;
  RETURN NEW;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_platform_sites_catalog_del() RETURNS trigger AS $EOFCODE$BEGIN
  DELETE FROM catalog_private.sites WHERE id = old.id;
  RETURN OLD;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_platform_site_web_configs_catalog_sync() RETURNS trigger AS $EOFCODE$BEGIN
  INSERT INTO catalog_private.sites_web_config (
    id,
    owner_scope,
    owner_key,
    is_visible,
    database_id,
    site_id,
    index_document,
    clean_urls,
    spa_fallback,
    metadata
  ) VALUES
    (new.id, 'platform', NULL, false, jwt_private.current_database_id(), new.site_id, new.index_document, new.clean_urls, new.spa_fallback, new.metadata) ON CONFLICT (id) DO UPDATE SET 
    owner_key = excluded.owner_key,
    is_visible = excluded.is_visible,
    database_id = excluded.database_id,
    site_id = excluded.site_id,
    index_document = excluded.index_document,
    clean_urls = excluded.clean_urls,
    spa_fallback = excluded.spa_fallback,
    metadata = excluded.metadata;
  RETURN NEW;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_platform_site_web_configs_catalog_del() RETURNS trigger AS $EOFCODE$BEGIN
  DELETE FROM catalog_private.sites_web_config WHERE id = old.id;
  RETURN OLD;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_platform_site_error_pages_catalog_sync() RETURNS trigger AS $EOFCODE$BEGIN
  INSERT INTO catalog_private.sites_error_pages (
    id,
    owner_scope,
    owner_key,
    is_visible,
    database_id,
    site_id,
    status_code,
    object_path
  ) VALUES
    (new.id, 'platform', NULL, false, jwt_private.current_database_id(), new.site_id, new.status_code, new.object_path) ON CONFLICT (id) DO UPDATE SET 
    owner_key = excluded.owner_key,
    is_visible = excluded.is_visible,
    database_id = excluded.database_id,
    site_id = excluded.site_id,
    status_code = excluded.status_code,
    object_path = excluded.object_path;
  RETURN NEW;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_platform_site_error_pages_catalog_del() RETURNS trigger AS $EOFCODE$BEGIN
  DELETE FROM catalog_private.sites_error_pages WHERE id = old.id;
  RETURN OLD;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_platform_site_app_links_catalog_sync() RETURNS trigger AS $EOFCODE$BEGIN
  INSERT INTO catalog_private.sites_app_links (
    id,
    owner_scope,
    owner_key,
    is_visible,
    database_id,
    site_id,
    platform,
    app_identifier,
    team_id,
    sha256_cert_fingerprints,
    path_components,
    webcredentials,
    store_url
  ) VALUES
    (new.id, 'platform', NULL, false, jwt_private.current_database_id(), new.site_id, new.platform, new.app_identifier, new.team_id, new.sha256_cert_fingerprints, new.path_components, new.webcredentials, new.store_url) ON CONFLICT (id) DO UPDATE SET 
    owner_key = excluded.owner_key,
    is_visible = excluded.is_visible,
    database_id = excluded.database_id,
    site_id = excluded.site_id,
    platform = excluded.platform,
    app_identifier = excluded.app_identifier,
    team_id = excluded.team_id,
    sha256_cert_fingerprints = excluded.sha256_cert_fingerprints,
    path_components = excluded.path_components,
    webcredentials = excluded.webcredentials,
    store_url = excluded.store_url;
  RETURN NEW;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_platform_site_app_links_catalog_del() RETURNS trigger AS $EOFCODE$BEGIN
  DELETE FROM catalog_private.sites_app_links WHERE id = old.id;
  RETURN OLD;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_platform_site_deep_links_catalog_sync() RETURNS trigger AS $EOFCODE$BEGIN
  INSERT INTO catalog_private.sites_deep_links (
    id,
    owner_scope,
    owner_key,
    is_visible,
    database_id,
    site_id,
    slug,
    app_path,
    web_path,
    fallback_url
  ) VALUES
    (new.id, 'platform', NULL, false, jwt_private.current_database_id(), new.site_id, new.slug, new.app_path, new.web_path, new.fallback_url) ON CONFLICT (id) DO UPDATE SET 
    owner_key = excluded.owner_key,
    is_visible = excluded.is_visible,
    database_id = excluded.database_id,
    site_id = excluded.site_id,
    slug = excluded.slug,
    app_path = excluded.app_path,
    web_path = excluded.web_path,
    fallback_url = excluded.fallback_url;
  RETURN NEW;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_platform_site_deep_links_catalog_del() RETURNS trigger AS $EOFCODE$BEGIN
  DELETE FROM catalog_private.sites_deep_links WHERE id = old.id;
  RETURN OLD;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_sites_catalog_sync() RETURNS trigger AS $EOFCODE$BEGIN
  INSERT INTO catalog_private.sites (
    id,
    owner_scope,
    owner_key,
    is_visible,
    database_id,
    name,
    title,
    description,
    bucket_id,
    resource_id,
    installation_id,
    installation_member_slug
  ) VALUES
    (new.id, 'database', new.database_id, COALESCE(new.is_published, false), new.database_id, new.name, new.title, new.description, new.bucket_id, new.resource_id, new.installation_id, new.installation_member_slug) ON CONFLICT (id) DO UPDATE SET 
    owner_key = excluded.owner_key,
    is_visible = excluded.is_visible,
    database_id = excluded.database_id,
    name = excluded.name,
    title = excluded.title,
    description = excluded.description,
    bucket_id = excluded.bucket_id,
    resource_id = excluded.resource_id,
    installation_id = excluded.installation_id,
    installation_member_slug = excluded.installation_member_slug;
  RETURN NEW;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_sites_catalog_del() RETURNS trigger AS $EOFCODE$BEGIN
  DELETE FROM catalog_private.sites WHERE id = old.id;
  RETURN OLD;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_site_web_configs_catalog_sync() RETURNS trigger AS $EOFCODE$BEGIN
  INSERT INTO catalog_private.sites_web_config (
    id,
    owner_scope,
    owner_key,
    is_visible,
    database_id,
    site_id,
    index_document,
    clean_urls,
    spa_fallback,
    metadata
  ) VALUES
    (new.id, 'database', new.database_id, false, new.database_id, new.site_id, new.index_document, new.clean_urls, new.spa_fallback, new.metadata) ON CONFLICT (id) DO UPDATE SET 
    owner_key = excluded.owner_key,
    is_visible = excluded.is_visible,
    database_id = excluded.database_id,
    site_id = excluded.site_id,
    index_document = excluded.index_document,
    clean_urls = excluded.clean_urls,
    spa_fallback = excluded.spa_fallback,
    metadata = excluded.metadata;
  RETURN NEW;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_site_web_configs_catalog_del() RETURNS trigger AS $EOFCODE$BEGIN
  DELETE FROM catalog_private.sites_web_config WHERE id = old.id;
  RETURN OLD;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_site_error_pages_catalog_sync() RETURNS trigger AS $EOFCODE$BEGIN
  INSERT INTO catalog_private.sites_error_pages (
    id,
    owner_scope,
    owner_key,
    is_visible,
    database_id,
    site_id,
    status_code,
    object_path
  ) VALUES
    (new.id, 'database', new.database_id, false, new.database_id, new.site_id, new.status_code, new.object_path) ON CONFLICT (id) DO UPDATE SET 
    owner_key = excluded.owner_key,
    is_visible = excluded.is_visible,
    database_id = excluded.database_id,
    site_id = excluded.site_id,
    status_code = excluded.status_code,
    object_path = excluded.object_path;
  RETURN NEW;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_site_error_pages_catalog_del() RETURNS trigger AS $EOFCODE$BEGIN
  DELETE FROM catalog_private.sites_error_pages WHERE id = old.id;
  RETURN OLD;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_site_app_links_catalog_sync() RETURNS trigger AS $EOFCODE$BEGIN
  INSERT INTO catalog_private.sites_app_links (
    id,
    owner_scope,
    owner_key,
    is_visible,
    database_id,
    site_id,
    platform,
    app_identifier,
    team_id,
    sha256_cert_fingerprints,
    path_components,
    webcredentials,
    store_url
  ) VALUES
    (new.id, 'database', new.database_id, false, new.database_id, new.site_id, new.platform, new.app_identifier, new.team_id, new.sha256_cert_fingerprints, new.path_components, new.webcredentials, new.store_url) ON CONFLICT (id) DO UPDATE SET 
    owner_key = excluded.owner_key,
    is_visible = excluded.is_visible,
    database_id = excluded.database_id,
    site_id = excluded.site_id,
    platform = excluded.platform,
    app_identifier = excluded.app_identifier,
    team_id = excluded.team_id,
    sha256_cert_fingerprints = excluded.sha256_cert_fingerprints,
    path_components = excluded.path_components,
    webcredentials = excluded.webcredentials,
    store_url = excluded.store_url;
  RETURN NEW;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_site_app_links_catalog_del() RETURNS trigger AS $EOFCODE$BEGIN
  DELETE FROM catalog_private.sites_app_links WHERE id = old.id;
  RETURN OLD;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_site_deep_links_catalog_sync() RETURNS trigger AS $EOFCODE$BEGIN
  INSERT INTO catalog_private.sites_deep_links (
    id,
    owner_scope,
    owner_key,
    is_visible,
    database_id,
    site_id,
    slug,
    app_path,
    web_path,
    fallback_url
  ) VALUES
    (new.id, 'database', new.database_id, false, new.database_id, new.site_id, new.slug, new.app_path, new.web_path, new.fallback_url) ON CONFLICT (id) DO UPDATE SET 
    owner_key = excluded.owner_key,
    is_visible = excluded.is_visible,
    database_id = excluded.database_id,
    site_id = excluded.site_id,
    slug = excluded.slug,
    app_path = excluded.app_path,
    web_path = excluded.web_path,
    fallback_url = excluded.fallback_url;
  RETURN NEW;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_site_deep_links_catalog_del() RETURNS trigger AS $EOFCODE$BEGIN
  DELETE FROM catalog_private.sites_deep_links WHERE id = old.id;
  RETURN OLD;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_platform_namespaces_catalog_sync() RETURNS trigger AS $EOFCODE$BEGIN
  INSERT INTO catalog_private.namespaces (
    id,
    owner_scope,
    owner_key,
    is_visible,
    database_id,
    namespace_name
  ) VALUES
    (new.id, 'platform', NULL, false, jwt_private.current_database_id(), new.namespace_name) ON CONFLICT (id) DO UPDATE SET 
    owner_key = excluded.owner_key,
    is_visible = excluded.is_visible,
    database_id = excluded.database_id,
    namespace_name = excluded.namespace_name;
  RETURN NEW;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_platform_namespaces_catalog_del() RETURNS trigger AS $EOFCODE$BEGIN
  DELETE FROM catalog_private.namespaces WHERE id = old.id;
  RETURN OLD;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_namespaces_catalog_sync() RETURNS trigger AS $EOFCODE$BEGIN
  INSERT INTO catalog_private.namespaces (
    id,
    owner_scope,
    owner_key,
    is_visible,
    database_id,
    namespace_name
  ) VALUES
    (new.id, 'database', new.database_id, false, new.database_id, new.namespace_name) ON CONFLICT (id) DO UPDATE SET 
    owner_key = excluded.owner_key,
    is_visible = excluded.is_visible,
    database_id = excluded.database_id,
    namespace_name = excluded.namespace_name;
  RETURN NEW;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_namespaces_catalog_del() RETURNS trigger AS $EOFCODE$BEGIN
  DELETE FROM catalog_private.namespaces WHERE id = old.id;
  RETURN OLD;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_platform_function_definitions_catalog_sync() RETURNS trigger AS $EOFCODE$BEGIN
  INSERT INTO catalog_private.functions (
    id,
    owner_scope,
    owner_key,
    is_visible,
    database_id,
    task_identifier,
    queue_name,
    priority,
    max_attempts
  ) VALUES
    (new.id, 'platform', NULL, COALESCE(new.is_published, false), jwt_private.current_database_id(), new.task_identifier, new.queue_name, new.priority, new.max_attempts) ON CONFLICT (id) DO UPDATE SET 
    owner_key = excluded.owner_key,
    is_visible = excluded.is_visible,
    database_id = excluded.database_id,
    task_identifier = excluded.task_identifier,
    queue_name = excluded.queue_name,
    priority = excluded.priority,
    max_attempts = excluded.max_attempts;
  RETURN NEW;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_platform_function_definitions_catalog_del() RETURNS trigger AS $EOFCODE$BEGIN
  DELETE FROM catalog_private.functions WHERE id = old.id;
  RETURN OLD;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_platform_function_capability_bindings_catalog_sync() RETURNS trigger AS $EOFCODE$BEGIN
  INSERT INTO catalog_private.bindings (
    id,
    owner_scope,
    owner_key,
    is_visible,
    database_id,
    function_id,
    graph_id,
    bucket_id,
    lifecycle,
    key
  ) VALUES
    (new.id, 'platform', NULL, false, jwt_private.current_database_id(), new.function_id, new.graph_id, new.bucket_id, new.lifecycle, new.key) ON CONFLICT (id) DO UPDATE SET 
    owner_key = excluded.owner_key,
    is_visible = excluded.is_visible,
    database_id = excluded.database_id,
    function_id = excluded.function_id,
    graph_id = excluded.graph_id,
    bucket_id = excluded.bucket_id,
    lifecycle = excluded.lifecycle,
    key = excluded.key;
  RETURN NEW;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_platform_function_capability_bindings_catalog_del() RETURNS trigger AS $EOFCODE$BEGIN
  DELETE FROM catalog_private.bindings WHERE id = old.id;
  RETURN OLD;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_function_definitions_catalog_sync() RETURNS trigger AS $EOFCODE$BEGIN
  INSERT INTO catalog_private.functions (
    id,
    owner_scope,
    owner_key,
    is_visible,
    database_id,
    task_identifier,
    queue_name,
    priority,
    max_attempts
  ) VALUES
    (new.id, 'database', new.database_id, COALESCE(new.is_published, false), new.database_id, new.task_identifier, new.queue_name, new.priority, new.max_attempts) ON CONFLICT (id) DO UPDATE SET 
    owner_key = excluded.owner_key,
    is_visible = excluded.is_visible,
    database_id = excluded.database_id,
    task_identifier = excluded.task_identifier,
    queue_name = excluded.queue_name,
    priority = excluded.priority,
    max_attempts = excluded.max_attempts;
  RETURN NEW;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_function_definitions_catalog_del() RETURNS trigger AS $EOFCODE$BEGIN
  DELETE FROM catalog_private.functions WHERE id = old.id;
  RETURN OLD;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_function_capability_bindings_catalog_sync() RETURNS trigger AS $EOFCODE$BEGIN
  INSERT INTO catalog_private.bindings (
    id,
    owner_scope,
    owner_key,
    is_visible,
    database_id,
    function_id,
    graph_id,
    bucket_id,
    lifecycle,
    key
  ) VALUES
    (new.id, 'database', new.database_id, false, new.database_id, new.function_id, new.graph_id, new.bucket_id, new.lifecycle, new.key) ON CONFLICT (id) DO UPDATE SET 
    owner_key = excluded.owner_key,
    is_visible = excluded.is_visible,
    database_id = excluded.database_id,
    function_id = excluded.function_id,
    graph_id = excluded.graph_id,
    bucket_id = excluded.bucket_id,
    lifecycle = excluded.lifecycle,
    key = excluded.key;
  RETURN NEW;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_function_capability_bindings_catalog_del() RETURNS trigger AS $EOFCODE$BEGIN
  DELETE FROM catalog_private.bindings WHERE id = old.id;
  RETURN OLD;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_platform_buckets_catalog_sync() RETURNS trigger AS $EOFCODE$BEGIN
  INSERT INTO catalog_private.buckets (
    id,
    owner_scope,
    owner_key,
    is_visible,
    database_id,
    key,
    type,
    physical_name,
    tags
  ) VALUES
    (new.id, 'platform', NULL, COALESCE(new.is_public, false), jwt_private.current_database_id(), new.key, new.type, new.physical_name, new.tags) ON CONFLICT (id) DO UPDATE SET 
    owner_key = excluded.owner_key,
    is_visible = excluded.is_visible,
    database_id = excluded.database_id,
    key = excluded.key,
    type = excluded.type,
    physical_name = excluded.physical_name,
    tags = excluded.tags;
  RETURN NEW;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_platform_buckets_catalog_del() RETURNS trigger AS $EOFCODE$BEGIN
  DELETE FROM catalog_private.buckets WHERE id = old.id;
  RETURN OLD;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_buckets_catalog_sync() RETURNS trigger AS $EOFCODE$BEGIN
  INSERT INTO catalog_private.buckets (
    id,
    owner_scope,
    owner_key,
    is_visible,
    database_id,
    key,
    type,
    physical_name,
    tags
  ) VALUES
    (new.id, 'database', new.database_id, COALESCE(new.is_public, false), new.database_id, new.key, new.type, new.physical_name, new.tags) ON CONFLICT (id) DO UPDATE SET 
    owner_key = excluded.owner_key,
    is_visible = excluded.is_visible,
    database_id = excluded.database_id,
    key = excluded.key,
    type = excluded.type,
    physical_name = excluded.physical_name,
    tags = excluded.tags;
  RETURN NEW;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_buckets_catalog_del() RETURNS trigger AS $EOFCODE$BEGIN
  DELETE FROM catalog_private.buckets WHERE id = old.id;
  RETURN OLD;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_platform_resources_catalog_sync() RETURNS trigger AS $EOFCODE$BEGIN
  INSERT INTO catalog_private.resources (
    id,
    owner_scope,
    owner_key,
    is_visible,
    database_id,
    namespace_id,
    kind,
    slug
  ) VALUES
    (new.id, 'platform', NULL, false, jwt_private.current_database_id(), new.namespace_id, new.kind, new.slug) ON CONFLICT (id) DO UPDATE SET 
    owner_key = excluded.owner_key,
    is_visible = excluded.is_visible,
    database_id = excluded.database_id,
    namespace_id = excluded.namespace_id,
    kind = excluded.kind,
    slug = excluded.slug;
  RETURN NEW;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_platform_resources_catalog_del() RETURNS trigger AS $EOFCODE$BEGIN
  DELETE FROM catalog_private.resources WHERE id = old.id;
  RETURN OLD;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_platform_resource_definitions_catalog_sync() RETURNS trigger AS $EOFCODE$BEGIN
  INSERT INTO catalog_private.resource_definitions (
    id,
    owner_scope,
    owner_key,
    is_visible,
    database_id,
    namespace_id,
    kind,
    slug
  ) VALUES
    (new.id, 'platform', NULL, false, jwt_private.current_database_id(), new.namespace_id, new.kind, new.slug) ON CONFLICT (id) DO UPDATE SET 
    owner_key = excluded.owner_key,
    is_visible = excluded.is_visible,
    database_id = excluded.database_id,
    namespace_id = excluded.namespace_id,
    kind = excluded.kind,
    slug = excluded.slug;
  RETURN NEW;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_platform_resource_definitions_catalog_del() RETURNS trigger AS $EOFCODE$BEGIN
  DELETE FROM catalog_private.resource_definitions WHERE id = old.id;
  RETURN OLD;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_platform_resource_installations_catalog_sync() RETURNS trigger AS $EOFCODE$BEGIN
  INSERT INTO catalog_private.resource_installations (
    id,
    owner_scope,
    owner_key,
    is_visible,
    database_id,
    namespace_id,
    slug
  ) VALUES
    (new.id, 'platform', NULL, false, jwt_private.current_database_id(), new.namespace_id, new.slug) ON CONFLICT (id) DO UPDATE SET 
    owner_key = excluded.owner_key,
    is_visible = excluded.is_visible,
    database_id = excluded.database_id,
    namespace_id = excluded.namespace_id,
    slug = excluded.slug;
  RETURN NEW;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_platform_resource_installations_catalog_del() RETURNS trigger AS $EOFCODE$BEGIN
  DELETE FROM catalog_private.resource_installations WHERE id = old.id;
  RETURN OLD;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_resources_catalog_sync() RETURNS trigger AS $EOFCODE$BEGIN
  INSERT INTO catalog_private.resources (
    id,
    owner_scope,
    owner_key,
    is_visible,
    database_id,
    namespace_id,
    kind,
    slug
  ) VALUES
    (new.id, 'database', new.database_id, false, new.database_id, new.namespace_id, new.kind, new.slug) ON CONFLICT (id) DO UPDATE SET 
    owner_key = excluded.owner_key,
    is_visible = excluded.is_visible,
    database_id = excluded.database_id,
    namespace_id = excluded.namespace_id,
    kind = excluded.kind,
    slug = excluded.slug;
  RETURN NEW;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_resources_catalog_del() RETURNS trigger AS $EOFCODE$BEGIN
  DELETE FROM catalog_private.resources WHERE id = old.id;
  RETURN OLD;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_resource_definitions_catalog_sync() RETURNS trigger AS $EOFCODE$BEGIN
  INSERT INTO catalog_private.resource_definitions (
    id,
    owner_scope,
    owner_key,
    is_visible,
    database_id,
    namespace_id,
    kind,
    slug
  ) VALUES
    (new.id, 'database', new.database_id, false, new.database_id, new.namespace_id, new.kind, new.slug) ON CONFLICT (id) DO UPDATE SET 
    owner_key = excluded.owner_key,
    is_visible = excluded.is_visible,
    database_id = excluded.database_id,
    namespace_id = excluded.namespace_id,
    kind = excluded.kind,
    slug = excluded.slug;
  RETURN NEW;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_resource_definitions_catalog_del() RETURNS trigger AS $EOFCODE$BEGIN
  DELETE FROM catalog_private.resource_definitions WHERE id = old.id;
  RETURN OLD;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_resource_installations_catalog_sync() RETURNS trigger AS $EOFCODE$BEGIN
  INSERT INTO catalog_private.resource_installations (
    id,
    owner_scope,
    owner_key,
    is_visible,
    database_id,
    namespace_id,
    slug
  ) VALUES
    (new.id, 'database', new.database_id, false, new.database_id, new.namespace_id, new.slug) ON CONFLICT (id) DO UPDATE SET 
    owner_key = excluded.owner_key,
    is_visible = excluded.is_visible,
    database_id = excluded.database_id,
    namespace_id = excluded.namespace_id,
    slug = excluded.slug;
  RETURN NEW;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_resource_installations_catalog_del() RETURNS trigger AS $EOFCODE$BEGIN
  DELETE FROM catalog_private.resource_installations WHERE id = old.id;
  RETURN OLD;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_apps_catalog_sync() RETURNS trigger AS $EOFCODE$BEGIN
  INSERT INTO catalog_private.apps (
    id,
    owner_scope,
    owner_key,
    is_visible,
    database_id,
    name,
    config
  ) VALUES
    (new.id, 'database', new.database_id, COALESCE(new.is_published, false), new.database_id, new.name, new.config) ON CONFLICT (id) DO UPDATE SET 
    owner_key = excluded.owner_key,
    is_visible = excluded.is_visible,
    database_id = excluded.database_id,
    name = excluded.name,
    config = excluded.config;
  RETURN NEW;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_private.tg_apps_catalog_del() RETURNS trigger AS $EOFCODE$BEGIN
  DELETE FROM catalog_private.apps WHERE id = old.id;
  RETURN OLD;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;