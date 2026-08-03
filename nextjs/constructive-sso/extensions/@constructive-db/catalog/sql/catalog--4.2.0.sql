\echo Use "CREATE EXTENSION catalog" to load this file. \quit
CREATE SCHEMA catalog_public;

GRANT USAGE ON SCHEMA catalog_public TO administrator;

GRANT USAGE ON SCHEMA catalog_public TO authenticated;

GRANT USAGE ON SCHEMA catalog_public TO anonymous;

ALTER DEFAULT PRIVILEGES IN SCHEMA catalog_public
  GRANT ALL ON TABLES TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA catalog_public
  GRANT USAGE ON SEQUENCES TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA catalog_public
  GRANT ALL ON FUNCTIONS TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA catalog_public
  GRANT ALL ON FUNCTIONS TO authenticated;

ALTER DEFAULT PRIVILEGES IN SCHEMA catalog_public
  GRANT USAGE ON SEQUENCES TO authenticated;

ALTER DEFAULT PRIVILEGES IN SCHEMA catalog_public
  GRANT ALL ON FUNCTIONS TO anonymous;

CREATE TABLE catalog_public.domains ();

ALTER TABLE catalog_public.domains 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE catalog_public.domains IS 'Trigger-maintained typed catalog of hostnames across all scopes; UNIQUE (hostname) is the global claim';

ALTER TABLE catalog_public.domains 
  ADD COLUMN id uuid;

ALTER TABLE catalog_public.domains 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE catalog_public.domains 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE catalog_public.domains 
  ADD CONSTRAINT domains_pkey PRIMARY KEY (id);

ALTER TABLE catalog_public.domains 
  ADD COLUMN created_at timestamptz;

ALTER TABLE catalog_public.domains 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE catalog_public.domains 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE catalog_public.domains 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE INDEX domains_created_at_idx ON catalog_public.domains (created_at);

CREATE INDEX domains_updated_at_idx ON catalog_public.domains (updated_at);

ALTER TABLE catalog_public.domains 
  ADD COLUMN owner_scope text;

ALTER TABLE catalog_public.domains 
  ALTER COLUMN owner_scope SET NOT NULL;

COMMENT ON COLUMN catalog_public.domains.owner_scope IS 'Scope of the source table that owns the row';

ALTER TABLE catalog_public.domains 
  ADD COLUMN owner_key uuid;

COMMENT ON COLUMN catalog_public.domains.owner_key IS 'Value of the source table scope key column; NULL for global-tier owners';

ALTER TABLE catalog_public.domains 
  ADD COLUMN is_visible boolean;

ALTER TABLE catalog_public.domains 
  ALTER COLUMN is_visible SET NOT NULL;

ALTER TABLE catalog_public.domains 
  ALTER COLUMN is_visible SET DEFAULT false;

COMMENT ON COLUMN catalog_public.domains.is_visible IS 'Cross-scope visibility flag propagated from the scoped source row';

ALTER TABLE catalog_public.domains 
  ADD COLUMN database_id uuid;

ALTER TABLE catalog_public.domains 
  ALTER COLUMN database_id SET NOT NULL;

COMMENT ON COLUMN catalog_public.domains.database_id IS 'Database that owns the source row: the tenant database for database-scope rows, the hosting database otherwise';

ALTER TABLE catalog_public.domains 
  ADD COLUMN hostname text;

ALTER TABLE catalog_public.domains 
  ALTER COLUMN hostname SET NOT NULL;

COMMENT ON COLUMN catalog_public.domains.hostname IS 'Lowercase fully-qualified hostname; wildcards use the *.parent form';

ALTER TABLE catalog_public.domains 
  ADD COLUMN is_wildcard boolean;

ALTER TABLE catalog_public.domains 
  ALTER COLUMN is_wildcard SET NOT NULL;

ALTER TABLE catalog_public.domains 
  ALTER COLUMN is_wildcard SET DEFAULT false;

COMMENT ON COLUMN catalog_public.domains.is_wildcard IS 'Whether this hostname is a wildcard claim';

ALTER TABLE catalog_public.domains 
  ADD COLUMN parent_hostname text;

COMMENT ON COLUMN catalog_public.domains.parent_hostname IS 'Parent hostname a wildcard claim covers';

ALTER TABLE catalog_public.domains 
  ADD COLUMN managed boolean;

ALTER TABLE catalog_public.domains 
  ALTER COLUMN managed SET NOT NULL;

ALTER TABLE catalog_public.domains 
  ALTER COLUMN managed SET DEFAULT false;

COMMENT ON COLUMN catalog_public.domains.managed IS 'Whether the platform drives this hostname''s lifecycle';

ALTER TABLE catalog_public.domains 
  ADD COLUMN verification_status text;

COMMENT ON COLUMN catalog_public.domains.verification_status IS 'Ownership verification state propagated from the source row';

ALTER TABLE catalog_public.domains 
  ADD COLUMN tls_status text;

COMMENT ON COLUMN catalog_public.domains.tls_status IS 'Certificate lifecycle state propagated from the source row';

ALTER TABLE catalog_public.domains 
  ADD COLUMN tls_secret_name text;

COMMENT ON COLUMN catalog_public.domains.tls_secret_name IS 'TLS secret name propagated from the source row';

ALTER TABLE catalog_public.domains 
  ADD CONSTRAINT domains_hostname_key 
    UNIQUE (hostname);

CREATE INDEX domains_parent_hostname_is_wildcard_idx ON catalog_public.domains (parent_hostname, is_wildcard);

CREATE INDEX domains_owner_scope_owner_key_idx ON catalog_public.domains (owner_scope, owner_key);

CREATE INDEX domains_database_id_idx ON catalog_public.domains (database_id);

CREATE TABLE catalog_public.apis ();

ALTER TABLE catalog_public.apis 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE catalog_public.apis IS 'Trigger-maintained typed catalog of api surfaces across all scopes; rendering config is read live from this table';

ALTER TABLE catalog_public.apis 
  ADD COLUMN id uuid;

ALTER TABLE catalog_public.apis 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE catalog_public.apis 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE catalog_public.apis 
  ADD CONSTRAINT apis_pkey PRIMARY KEY (id);

ALTER TABLE catalog_public.apis 
  ADD COLUMN created_at timestamptz;

ALTER TABLE catalog_public.apis 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE catalog_public.apis 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE catalog_public.apis 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE INDEX apis_created_at_idx ON catalog_public.apis (created_at);

CREATE INDEX apis_updated_at_idx ON catalog_public.apis (updated_at);

ALTER TABLE catalog_public.apis 
  ADD COLUMN owner_scope text;

ALTER TABLE catalog_public.apis 
  ALTER COLUMN owner_scope SET NOT NULL;

COMMENT ON COLUMN catalog_public.apis.owner_scope IS 'Scope of the source table that owns the row';

ALTER TABLE catalog_public.apis 
  ADD COLUMN owner_key uuid;

COMMENT ON COLUMN catalog_public.apis.owner_key IS 'Value of the source table scope key column; NULL for global-tier owners';

ALTER TABLE catalog_public.apis 
  ADD COLUMN is_visible boolean;

ALTER TABLE catalog_public.apis 
  ALTER COLUMN is_visible SET NOT NULL;

ALTER TABLE catalog_public.apis 
  ALTER COLUMN is_visible SET DEFAULT false;

COMMENT ON COLUMN catalog_public.apis.is_visible IS 'Cross-scope visibility flag propagated from the scoped source row';

ALTER TABLE catalog_public.apis 
  ADD COLUMN database_id uuid;

ALTER TABLE catalog_public.apis 
  ALTER COLUMN database_id SET NOT NULL;

COMMENT ON COLUMN catalog_public.apis.database_id IS 'Database that owns the source row: the tenant database for database-scope rows, the hosting database otherwise';

ALTER TABLE catalog_public.apis 
  ADD COLUMN name text;

ALTER TABLE catalog_public.apis 
  ALTER COLUMN name SET NOT NULL;

COMMENT ON COLUMN catalog_public.apis.name IS 'Owner-local api surface name';

ALTER TABLE catalog_public.apis 
  ADD COLUMN dbname text;

COMMENT ON COLUMN catalog_public.apis.dbname IS 'Physical database name the api renders from';

ALTER TABLE catalog_public.apis 
  ADD COLUMN role_name text;

COMMENT ON COLUMN catalog_public.apis.role_name IS 'Authenticated role the api executes as';

ALTER TABLE catalog_public.apis 
  ADD COLUMN anon_role text;

COMMENT ON COLUMN catalog_public.apis.anon_role IS 'Anonymous role the api executes as';

ALTER TABLE catalog_public.apis 
  ADD COLUMN config jsonb;

COMMENT ON COLUMN catalog_public.apis.config IS 'Rendering configuration (schemas, flags) propagated from the source row';

CREATE UNIQUE INDEX apis_owner_scope_owner_key_name_idx ON catalog_public.apis (owner_scope, owner_key, name) WHERE apis.owner_key IS NOT NULL;

CREATE UNIQUE INDEX apis_owner_scope_name_idx ON catalog_public.apis (owner_scope, name) WHERE apis.owner_key IS NULL;

CREATE INDEX apis_is_visible_idx ON catalog_public.apis (is_visible);

CREATE INDEX apis_database_id_idx ON catalog_public.apis (database_id);

CREATE TABLE catalog_public.sites ();

ALTER TABLE catalog_public.sites 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE catalog_public.sites IS 'Trigger-maintained typed catalog of site surfaces across all scopes';

ALTER TABLE catalog_public.sites 
  ADD COLUMN id uuid;

ALTER TABLE catalog_public.sites 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE catalog_public.sites 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE catalog_public.sites 
  ADD CONSTRAINT sites_pkey PRIMARY KEY (id);

ALTER TABLE catalog_public.sites 
  ADD COLUMN created_at timestamptz;

ALTER TABLE catalog_public.sites 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE catalog_public.sites 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE catalog_public.sites 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE INDEX sites_created_at_idx ON catalog_public.sites (created_at);

CREATE INDEX sites_updated_at_idx ON catalog_public.sites (updated_at);

ALTER TABLE catalog_public.sites 
  ADD COLUMN owner_scope text;

ALTER TABLE catalog_public.sites 
  ALTER COLUMN owner_scope SET NOT NULL;

COMMENT ON COLUMN catalog_public.sites.owner_scope IS 'Scope of the source table that owns the row';

ALTER TABLE catalog_public.sites 
  ADD COLUMN owner_key uuid;

COMMENT ON COLUMN catalog_public.sites.owner_key IS 'Value of the source table scope key column; NULL for global-tier owners';

ALTER TABLE catalog_public.sites 
  ADD COLUMN is_visible boolean;

ALTER TABLE catalog_public.sites 
  ALTER COLUMN is_visible SET NOT NULL;

ALTER TABLE catalog_public.sites 
  ALTER COLUMN is_visible SET DEFAULT false;

COMMENT ON COLUMN catalog_public.sites.is_visible IS 'Cross-scope visibility flag propagated from the scoped source row';

ALTER TABLE catalog_public.sites 
  ADD COLUMN database_id uuid;

ALTER TABLE catalog_public.sites 
  ALTER COLUMN database_id SET NOT NULL;

COMMENT ON COLUMN catalog_public.sites.database_id IS 'Database that owns the source row: the tenant database for database-scope rows, the hosting database otherwise';

ALTER TABLE catalog_public.sites 
  ADD COLUMN name text;

ALTER TABLE catalog_public.sites 
  ALTER COLUMN name SET NOT NULL;

COMMENT ON COLUMN catalog_public.sites.name IS 'Owner-local site surface name';

ALTER TABLE catalog_public.sites 
  ADD COLUMN title text;

COMMENT ON COLUMN catalog_public.sites.title IS 'Display title propagated from the source row';

ALTER TABLE catalog_public.sites 
  ADD COLUMN description text;

COMMENT ON COLUMN catalog_public.sites.description IS 'Display description propagated from the source row';

ALTER TABLE catalog_public.sites 
  ADD COLUMN config jsonb;

COMMENT ON COLUMN catalog_public.sites.config IS 'Site configuration propagated from the source row';

CREATE UNIQUE INDEX sites_owner_scope_owner_key_name_idx ON catalog_public.sites (owner_scope, owner_key, name) WHERE sites.owner_key IS NOT NULL;

CREATE UNIQUE INDEX sites_owner_scope_name_idx ON catalog_public.sites (owner_scope, name) WHERE sites.owner_key IS NULL;

CREATE INDEX sites_is_visible_idx ON catalog_public.sites (is_visible);

CREATE INDEX sites_database_id_idx ON catalog_public.sites (database_id);

CREATE TABLE catalog_public.namespaces ();

ALTER TABLE catalog_public.namespaces 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE catalog_public.namespaces IS 'Trigger-maintained typed catalog of namespaces across all scopes; UNIQUE (namespace_name) is the global claim';

ALTER TABLE catalog_public.namespaces 
  ADD COLUMN id uuid;

ALTER TABLE catalog_public.namespaces 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE catalog_public.namespaces 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE catalog_public.namespaces 
  ADD CONSTRAINT namespaces_pkey PRIMARY KEY (id);

ALTER TABLE catalog_public.namespaces 
  ADD COLUMN created_at timestamptz;

ALTER TABLE catalog_public.namespaces 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE catalog_public.namespaces 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE catalog_public.namespaces 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE INDEX namespaces_created_at_idx ON catalog_public.namespaces (created_at);

CREATE INDEX namespaces_updated_at_idx ON catalog_public.namespaces (updated_at);

ALTER TABLE catalog_public.namespaces 
  ADD COLUMN owner_scope text;

ALTER TABLE catalog_public.namespaces 
  ALTER COLUMN owner_scope SET NOT NULL;

COMMENT ON COLUMN catalog_public.namespaces.owner_scope IS 'Scope of the source table that owns the row';

ALTER TABLE catalog_public.namespaces 
  ADD COLUMN owner_key uuid;

COMMENT ON COLUMN catalog_public.namespaces.owner_key IS 'Value of the source table scope key column; NULL for global-tier owners';

ALTER TABLE catalog_public.namespaces 
  ADD COLUMN is_visible boolean;

ALTER TABLE catalog_public.namespaces 
  ALTER COLUMN is_visible SET NOT NULL;

ALTER TABLE catalog_public.namespaces 
  ALTER COLUMN is_visible SET DEFAULT false;

COMMENT ON COLUMN catalog_public.namespaces.is_visible IS 'Cross-scope visibility flag propagated from the scoped source row';

ALTER TABLE catalog_public.namespaces 
  ADD COLUMN database_id uuid;

ALTER TABLE catalog_public.namespaces 
  ALTER COLUMN database_id SET NOT NULL;

COMMENT ON COLUMN catalog_public.namespaces.database_id IS 'Database that owns the source row: the tenant database for database-scope rows, the hosting database otherwise';

CREATE INDEX namespaces_owner_scope_owner_key_idx ON catalog_public.namespaces (owner_scope, owner_key);

CREATE INDEX namespaces_database_id_idx ON catalog_public.namespaces (database_id);

ALTER TABLE catalog_public.namespaces 
  ADD COLUMN namespace_name text;

ALTER TABLE catalog_public.namespaces 
  ALTER COLUMN namespace_name SET NOT NULL;

COMMENT ON COLUMN catalog_public.namespaces.namespace_name IS 'Computed namespace slug; globally exclusive across all scopes';

ALTER TABLE catalog_public.namespaces 
  ADD CONSTRAINT namespaces_namespace_name_key 
    UNIQUE (namespace_name);

CREATE TABLE catalog_public.functions ();

ALTER TABLE catalog_public.functions 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE catalog_public.functions IS 'Trigger-maintained typed catalog of function definitions across all scopes';

ALTER TABLE catalog_public.functions 
  ADD COLUMN id uuid;

ALTER TABLE catalog_public.functions 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE catalog_public.functions 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE catalog_public.functions 
  ADD CONSTRAINT functions_pkey PRIMARY KEY (id);

ALTER TABLE catalog_public.functions 
  ADD COLUMN created_at timestamptz;

ALTER TABLE catalog_public.functions 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE catalog_public.functions 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE catalog_public.functions 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE INDEX functions_created_at_idx ON catalog_public.functions (created_at);

CREATE INDEX functions_updated_at_idx ON catalog_public.functions (updated_at);

ALTER TABLE catalog_public.functions 
  ADD COLUMN owner_scope text;

ALTER TABLE catalog_public.functions 
  ALTER COLUMN owner_scope SET NOT NULL;

COMMENT ON COLUMN catalog_public.functions.owner_scope IS 'Scope of the source table that owns the row';

ALTER TABLE catalog_public.functions 
  ADD COLUMN owner_key uuid;

COMMENT ON COLUMN catalog_public.functions.owner_key IS 'Value of the source table scope key column; NULL for global-tier owners';

ALTER TABLE catalog_public.functions 
  ADD COLUMN is_visible boolean;

ALTER TABLE catalog_public.functions 
  ALTER COLUMN is_visible SET NOT NULL;

ALTER TABLE catalog_public.functions 
  ALTER COLUMN is_visible SET DEFAULT false;

COMMENT ON COLUMN catalog_public.functions.is_visible IS 'Cross-scope visibility flag propagated from the scoped source row';

ALTER TABLE catalog_public.functions 
  ADD COLUMN database_id uuid;

ALTER TABLE catalog_public.functions 
  ALTER COLUMN database_id SET NOT NULL;

COMMENT ON COLUMN catalog_public.functions.database_id IS 'Database that owns the source row: the tenant database for database-scope rows, the hosting database otherwise';

CREATE INDEX functions_owner_scope_owner_key_idx ON catalog_public.functions (owner_scope, owner_key);

CREATE INDEX functions_database_id_idx ON catalog_public.functions (database_id);

ALTER TABLE catalog_public.functions 
  ADD COLUMN task_identifier text;

ALTER TABLE catalog_public.functions 
  ALTER COLUMN task_identifier SET NOT NULL;

COMMENT ON COLUMN catalog_public.functions.task_identifier IS 'Owner-local task identifier of the function definition';

CREATE UNIQUE INDEX functions_owner_scope_owner_key_task_identifier_idx ON catalog_public.functions (owner_scope, owner_key, task_identifier) WHERE functions.owner_key IS NOT NULL;

CREATE UNIQUE INDEX functions_owner_scope_task_identifier_idx ON catalog_public.functions (owner_scope, task_identifier) WHERE functions.owner_key IS NULL;

CREATE INDEX functions_is_visible_idx ON catalog_public.functions (is_visible);

CREATE TABLE catalog_public.resources ();

ALTER TABLE catalog_public.resources 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE catalog_public.resources IS 'Trigger-maintained typed catalog of resources across all scopes; UNIQUE (namespace_id, kind, slug)';

ALTER TABLE catalog_public.resources 
  ADD COLUMN id uuid;

ALTER TABLE catalog_public.resources 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE catalog_public.resources 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE catalog_public.resources 
  ADD CONSTRAINT resources_pkey PRIMARY KEY (id);

ALTER TABLE catalog_public.resources 
  ADD COLUMN created_at timestamptz;

ALTER TABLE catalog_public.resources 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE catalog_public.resources 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE catalog_public.resources 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE INDEX resources_created_at_idx ON catalog_public.resources (created_at);

CREATE INDEX resources_updated_at_idx ON catalog_public.resources (updated_at);

ALTER TABLE catalog_public.resources 
  ADD COLUMN owner_scope text;

ALTER TABLE catalog_public.resources 
  ALTER COLUMN owner_scope SET NOT NULL;

COMMENT ON COLUMN catalog_public.resources.owner_scope IS 'Scope of the source table that owns the row';

ALTER TABLE catalog_public.resources 
  ADD COLUMN owner_key uuid;

COMMENT ON COLUMN catalog_public.resources.owner_key IS 'Value of the source table scope key column; NULL for global-tier owners';

ALTER TABLE catalog_public.resources 
  ADD COLUMN is_visible boolean;

ALTER TABLE catalog_public.resources 
  ALTER COLUMN is_visible SET NOT NULL;

ALTER TABLE catalog_public.resources 
  ALTER COLUMN is_visible SET DEFAULT false;

COMMENT ON COLUMN catalog_public.resources.is_visible IS 'Cross-scope visibility flag propagated from the scoped source row';

ALTER TABLE catalog_public.resources 
  ADD COLUMN database_id uuid;

ALTER TABLE catalog_public.resources 
  ALTER COLUMN database_id SET NOT NULL;

COMMENT ON COLUMN catalog_public.resources.database_id IS 'Database that owns the source row: the tenant database for database-scope rows, the hosting database otherwise';

CREATE INDEX resources_owner_scope_owner_key_idx ON catalog_public.resources (owner_scope, owner_key);

CREATE INDEX resources_database_id_idx ON catalog_public.resources (database_id);

ALTER TABLE catalog_public.resources 
  ADD COLUMN namespace_id uuid;

ALTER TABLE catalog_public.resources 
  ALTER COLUMN namespace_id SET NOT NULL;

COMMENT ON COLUMN catalog_public.resources.namespace_id IS 'Namespace the resource lives in (source namespace row id)';

ALTER TABLE catalog_public.resources 
  ADD COLUMN kind text;

ALTER TABLE catalog_public.resources 
  ALTER COLUMN kind SET NOT NULL;

COMMENT ON COLUMN catalog_public.resources.kind IS 'Resource kind';

ALTER TABLE catalog_public.resources 
  ADD COLUMN slug text;

ALTER TABLE catalog_public.resources 
  ALTER COLUMN slug SET NOT NULL;

COMMENT ON COLUMN catalog_public.resources.slug IS 'Resource slug within its namespace and kind';

ALTER TABLE catalog_public.resources 
  ADD CONSTRAINT resources_namespace_id_kind_slug_key 
    UNIQUE (namespace_id, kind, slug);

CREATE TABLE catalog_public.resource_definitions ();

ALTER TABLE catalog_public.resource_definitions 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE catalog_public.resource_definitions IS 'Trigger-maintained typed catalog of resource definitions across all scopes; UNIQUE (namespace_id, kind, slug)';

ALTER TABLE catalog_public.resource_definitions 
  ADD COLUMN id uuid;

ALTER TABLE catalog_public.resource_definitions 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE catalog_public.resource_definitions 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE catalog_public.resource_definitions 
  ADD CONSTRAINT resource_definitions_pkey PRIMARY KEY (id);

ALTER TABLE catalog_public.resource_definitions 
  ADD COLUMN created_at timestamptz;

ALTER TABLE catalog_public.resource_definitions 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE catalog_public.resource_definitions 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE catalog_public.resource_definitions 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE INDEX resource_definitions_created_at_idx ON catalog_public.resource_definitions (created_at);

CREATE INDEX resource_definitions_updated_at_idx ON catalog_public.resource_definitions (updated_at);

ALTER TABLE catalog_public.resource_definitions 
  ADD COLUMN owner_scope text;

ALTER TABLE catalog_public.resource_definitions 
  ALTER COLUMN owner_scope SET NOT NULL;

COMMENT ON COLUMN catalog_public.resource_definitions.owner_scope IS 'Scope of the source table that owns the row';

ALTER TABLE catalog_public.resource_definitions 
  ADD COLUMN owner_key uuid;

COMMENT ON COLUMN catalog_public.resource_definitions.owner_key IS 'Value of the source table scope key column; NULL for global-tier owners';

ALTER TABLE catalog_public.resource_definitions 
  ADD COLUMN is_visible boolean;

ALTER TABLE catalog_public.resource_definitions 
  ALTER COLUMN is_visible SET NOT NULL;

ALTER TABLE catalog_public.resource_definitions 
  ALTER COLUMN is_visible SET DEFAULT false;

COMMENT ON COLUMN catalog_public.resource_definitions.is_visible IS 'Cross-scope visibility flag propagated from the scoped source row';

ALTER TABLE catalog_public.resource_definitions 
  ADD COLUMN database_id uuid;

ALTER TABLE catalog_public.resource_definitions 
  ALTER COLUMN database_id SET NOT NULL;

COMMENT ON COLUMN catalog_public.resource_definitions.database_id IS 'Database that owns the source row: the tenant database for database-scope rows, the hosting database otherwise';

CREATE INDEX resource_definitions_owner_scope_owner_key_idx ON catalog_public.resource_definitions (owner_scope, owner_key);

CREATE INDEX resource_definitions_database_id_idx ON catalog_public.resource_definitions (database_id);

ALTER TABLE catalog_public.resource_definitions 
  ADD COLUMN namespace_id uuid;

ALTER TABLE catalog_public.resource_definitions 
  ALTER COLUMN namespace_id SET NOT NULL;

COMMENT ON COLUMN catalog_public.resource_definitions.namespace_id IS 'Namespace the definition lives in (source namespace row id)';

ALTER TABLE catalog_public.resource_definitions 
  ADD COLUMN kind text;

ALTER TABLE catalog_public.resource_definitions 
  ALTER COLUMN kind SET NOT NULL;

COMMENT ON COLUMN catalog_public.resource_definitions.kind IS 'Definition kind';

ALTER TABLE catalog_public.resource_definitions 
  ADD COLUMN slug text;

ALTER TABLE catalog_public.resource_definitions 
  ALTER COLUMN slug SET NOT NULL;

COMMENT ON COLUMN catalog_public.resource_definitions.slug IS 'Definition slug within its namespace and kind';

ALTER TABLE catalog_public.resource_definitions 
  ADD CONSTRAINT resource_definitions_namespace_id_kind_slug_key 
    UNIQUE (namespace_id, kind, slug);

CREATE TABLE catalog_public.resource_installations ();

ALTER TABLE catalog_public.resource_installations 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE catalog_public.resource_installations IS 'Trigger-maintained typed catalog of resource installations across all scopes; UNIQUE (namespace_id, slug)';

ALTER TABLE catalog_public.resource_installations 
  ADD COLUMN id uuid;

ALTER TABLE catalog_public.resource_installations 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE catalog_public.resource_installations 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE catalog_public.resource_installations 
  ADD CONSTRAINT resource_installations_pkey PRIMARY KEY (id);

ALTER TABLE catalog_public.resource_installations 
  ADD COLUMN created_at timestamptz;

ALTER TABLE catalog_public.resource_installations 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE catalog_public.resource_installations 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE catalog_public.resource_installations 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE INDEX resource_installations_created_at_idx ON catalog_public.resource_installations (created_at);

CREATE INDEX resource_installations_updated_at_idx ON catalog_public.resource_installations (updated_at);

ALTER TABLE catalog_public.resource_installations 
  ADD COLUMN owner_scope text;

ALTER TABLE catalog_public.resource_installations 
  ALTER COLUMN owner_scope SET NOT NULL;

COMMENT ON COLUMN catalog_public.resource_installations.owner_scope IS 'Scope of the source table that owns the row';

ALTER TABLE catalog_public.resource_installations 
  ADD COLUMN owner_key uuid;

COMMENT ON COLUMN catalog_public.resource_installations.owner_key IS 'Value of the source table scope key column; NULL for global-tier owners';

ALTER TABLE catalog_public.resource_installations 
  ADD COLUMN is_visible boolean;

ALTER TABLE catalog_public.resource_installations 
  ALTER COLUMN is_visible SET NOT NULL;

ALTER TABLE catalog_public.resource_installations 
  ALTER COLUMN is_visible SET DEFAULT false;

COMMENT ON COLUMN catalog_public.resource_installations.is_visible IS 'Cross-scope visibility flag propagated from the scoped source row';

ALTER TABLE catalog_public.resource_installations 
  ADD COLUMN database_id uuid;

ALTER TABLE catalog_public.resource_installations 
  ALTER COLUMN database_id SET NOT NULL;

COMMENT ON COLUMN catalog_public.resource_installations.database_id IS 'Database that owns the source row: the tenant database for database-scope rows, the hosting database otherwise';

CREATE INDEX resource_installations_owner_scope_owner_key_idx ON catalog_public.resource_installations (owner_scope, owner_key);

CREATE INDEX resource_installations_database_id_idx ON catalog_public.resource_installations (database_id);

ALTER TABLE catalog_public.resource_installations 
  ADD COLUMN namespace_id uuid;

ALTER TABLE catalog_public.resource_installations 
  ALTER COLUMN namespace_id SET NOT NULL;

COMMENT ON COLUMN catalog_public.resource_installations.namespace_id IS 'Namespace the installation lives in (source namespace row id)';

ALTER TABLE catalog_public.resource_installations 
  ADD COLUMN slug text;

ALTER TABLE catalog_public.resource_installations 
  ALTER COLUMN slug SET NOT NULL;

COMMENT ON COLUMN catalog_public.resource_installations.slug IS 'Installation slug within its namespace';

ALTER TABLE catalog_public.resource_installations 
  ADD CONSTRAINT resource_installations_namespace_id_slug_key 
    UNIQUE (namespace_id, slug);

CREATE TABLE catalog_public.apps ();

ALTER TABLE catalog_public.apps 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE catalog_public.apps IS 'Trigger-maintained typed catalog of app aggregates across all scopes';

ALTER TABLE catalog_public.apps 
  ADD COLUMN id uuid;

ALTER TABLE catalog_public.apps 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE catalog_public.apps 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE catalog_public.apps 
  ADD CONSTRAINT apps_pkey PRIMARY KEY (id);

ALTER TABLE catalog_public.apps 
  ADD COLUMN created_at timestamptz;

ALTER TABLE catalog_public.apps 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE catalog_public.apps 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE catalog_public.apps 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE INDEX apps_created_at_idx ON catalog_public.apps (created_at);

CREATE INDEX apps_updated_at_idx ON catalog_public.apps (updated_at);

ALTER TABLE catalog_public.apps 
  ADD COLUMN owner_scope text;

ALTER TABLE catalog_public.apps 
  ALTER COLUMN owner_scope SET NOT NULL;

COMMENT ON COLUMN catalog_public.apps.owner_scope IS 'Scope of the source table that owns the row';

ALTER TABLE catalog_public.apps 
  ADD COLUMN owner_key uuid;

COMMENT ON COLUMN catalog_public.apps.owner_key IS 'Value of the source table scope key column; NULL for global-tier owners';

ALTER TABLE catalog_public.apps 
  ADD COLUMN is_visible boolean;

ALTER TABLE catalog_public.apps 
  ALTER COLUMN is_visible SET NOT NULL;

ALTER TABLE catalog_public.apps 
  ALTER COLUMN is_visible SET DEFAULT false;

COMMENT ON COLUMN catalog_public.apps.is_visible IS 'Cross-scope visibility flag propagated from the scoped source row';

ALTER TABLE catalog_public.apps 
  ADD COLUMN database_id uuid;

ALTER TABLE catalog_public.apps 
  ALTER COLUMN database_id SET NOT NULL;

COMMENT ON COLUMN catalog_public.apps.database_id IS 'Database that owns the source row: the tenant database for database-scope rows, the hosting database otherwise';

CREATE INDEX apps_owner_scope_owner_key_idx ON catalog_public.apps (owner_scope, owner_key);

CREATE INDEX apps_database_id_idx ON catalog_public.apps (database_id);

ALTER TABLE catalog_public.apps 
  ADD COLUMN name text;

ALTER TABLE catalog_public.apps 
  ALTER COLUMN name SET NOT NULL;

COMMENT ON COLUMN catalog_public.apps.name IS 'Owner-local app name';

ALTER TABLE catalog_public.apps 
  ADD COLUMN config jsonb;

COMMENT ON COLUMN catalog_public.apps.config IS 'App configuration propagated from the source row';

CREATE UNIQUE INDEX apps_owner_scope_owner_key_name_idx ON catalog_public.apps (owner_scope, owner_key, name) WHERE apps.owner_key IS NOT NULL;

CREATE UNIQUE INDEX apps_owner_scope_name_idx ON catalog_public.apps (owner_scope, name) WHERE apps.owner_key IS NULL;

CREATE INDEX apps_is_visible_idx ON catalog_public.apps (is_visible);

CREATE TABLE catalog_public.buckets ();

ALTER TABLE catalog_public.buckets 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE catalog_public.buckets IS 'Trigger-maintained typed catalog of storage buckets across all scopes';

ALTER TABLE catalog_public.buckets 
  ADD COLUMN id uuid;

ALTER TABLE catalog_public.buckets 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE catalog_public.buckets 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE catalog_public.buckets 
  ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);

ALTER TABLE catalog_public.buckets 
  ADD COLUMN created_at timestamptz;

ALTER TABLE catalog_public.buckets 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE catalog_public.buckets 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE catalog_public.buckets 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE INDEX buckets_created_at_idx ON catalog_public.buckets (created_at);

CREATE INDEX buckets_updated_at_idx ON catalog_public.buckets (updated_at);

ALTER TABLE catalog_public.buckets 
  ADD COLUMN owner_scope text;

ALTER TABLE catalog_public.buckets 
  ALTER COLUMN owner_scope SET NOT NULL;

COMMENT ON COLUMN catalog_public.buckets.owner_scope IS 'Scope of the source table that owns the row';

ALTER TABLE catalog_public.buckets 
  ADD COLUMN owner_key uuid;

COMMENT ON COLUMN catalog_public.buckets.owner_key IS 'Value of the source table scope key column; NULL for global-tier owners';

ALTER TABLE catalog_public.buckets 
  ADD COLUMN is_visible boolean;

ALTER TABLE catalog_public.buckets 
  ALTER COLUMN is_visible SET NOT NULL;

ALTER TABLE catalog_public.buckets 
  ALTER COLUMN is_visible SET DEFAULT false;

COMMENT ON COLUMN catalog_public.buckets.is_visible IS 'Cross-scope visibility flag propagated from the scoped source row';

ALTER TABLE catalog_public.buckets 
  ADD COLUMN database_id uuid;

ALTER TABLE catalog_public.buckets 
  ALTER COLUMN database_id SET NOT NULL;

COMMENT ON COLUMN catalog_public.buckets.database_id IS 'Database that owns the source row: the tenant database for database-scope rows, the hosting database otherwise';

CREATE INDEX buckets_owner_scope_owner_key_idx ON catalog_public.buckets (owner_scope, owner_key);

CREATE INDEX buckets_database_id_idx ON catalog_public.buckets (database_id);

ALTER TABLE catalog_public.buckets 
  ADD COLUMN key text;

ALTER TABLE catalog_public.buckets 
  ALTER COLUMN key SET NOT NULL;

COMMENT ON COLUMN catalog_public.buckets.key IS 'Owner-local logical bucket key propagated from the source row';

ALTER TABLE catalog_public.buckets 
  ADD COLUMN type text;

ALTER TABLE catalog_public.buckets 
  ALTER COLUMN type SET NOT NULL;

COMMENT ON COLUMN catalog_public.buckets.type IS 'Bucket type (public/private) propagated from the source row';

ALTER TABLE catalog_public.buckets 
  ADD COLUMN physical_name text;

COMMENT ON COLUMN catalog_public.buckets.physical_name IS 'Physical S3/MinIO bucket name propagated from the source row (NULL until the physical bucket exists)';

CREATE UNIQUE INDEX buckets_owner_scope_owner_key_key_idx ON catalog_public.buckets (owner_scope, owner_key, key) WHERE buckets.owner_key IS NOT NULL;

CREATE UNIQUE INDEX buckets_owner_scope_key_idx ON catalog_public.buckets (owner_scope, key) WHERE buckets.owner_key IS NULL;

CREATE INDEX buckets_is_visible_idx ON catalog_public.buckets (is_visible);

GRANT SELECT ON catalog_public.domains TO authenticated;

GRANT INSERT ON catalog_public.domains TO authenticated;

GRANT UPDATE ON catalog_public.domains TO authenticated;

GRANT DELETE ON catalog_public.domains TO authenticated;

GRANT SELECT ON catalog_public.apis TO authenticated;

GRANT INSERT ON catalog_public.apis TO authenticated;

GRANT UPDATE ON catalog_public.apis TO authenticated;

GRANT DELETE ON catalog_public.apis TO authenticated;

GRANT SELECT ON catalog_public.sites TO authenticated;

GRANT INSERT ON catalog_public.sites TO authenticated;

GRANT UPDATE ON catalog_public.sites TO authenticated;

GRANT DELETE ON catalog_public.sites TO authenticated;

GRANT SELECT ON catalog_public.namespaces TO authenticated;

GRANT INSERT ON catalog_public.namespaces TO authenticated;

GRANT UPDATE ON catalog_public.namespaces TO authenticated;

GRANT DELETE ON catalog_public.namespaces TO authenticated;

GRANT SELECT ON catalog_public.functions TO authenticated;

GRANT INSERT ON catalog_public.functions TO authenticated;

GRANT UPDATE ON catalog_public.functions TO authenticated;

GRANT DELETE ON catalog_public.functions TO authenticated;

GRANT SELECT ON catalog_public.resources TO authenticated;

GRANT INSERT ON catalog_public.resources TO authenticated;

GRANT UPDATE ON catalog_public.resources TO authenticated;

GRANT DELETE ON catalog_public.resources TO authenticated;

GRANT SELECT ON catalog_public.resource_definitions TO authenticated;

GRANT INSERT ON catalog_public.resource_definitions TO authenticated;

GRANT UPDATE ON catalog_public.resource_definitions TO authenticated;

GRANT DELETE ON catalog_public.resource_definitions TO authenticated;

GRANT SELECT ON catalog_public.resource_installations TO authenticated;

GRANT INSERT ON catalog_public.resource_installations TO authenticated;

GRANT UPDATE ON catalog_public.resource_installations TO authenticated;

GRANT DELETE ON catalog_public.resource_installations TO authenticated;

GRANT SELECT ON catalog_public.apps TO authenticated;

GRANT INSERT ON catalog_public.apps TO authenticated;

GRANT UPDATE ON catalog_public.apps TO authenticated;

GRANT DELETE ON catalog_public.apps TO authenticated;

GRANT SELECT ON catalog_public.buckets TO authenticated;

GRANT INSERT ON catalog_public.buckets TO authenticated;

GRANT UPDATE ON catalog_public.buckets TO authenticated;

GRANT DELETE ON catalog_public.buckets TO authenticated;

CREATE FUNCTION catalog_public.tg_platform_domains_catalog_sync() RETURNS trigger AS $EOFCODE$BEGIN
  INSERT INTO catalog_public.domains (
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

CREATE FUNCTION catalog_public.tg_platform_domains_catalog_del() RETURNS trigger AS $EOFCODE$BEGIN
  DELETE FROM catalog_public.domains WHERE id = old.id;
  RETURN OLD;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_public.tg_domains_catalog_sync() RETURNS trigger AS $EOFCODE$BEGIN
  INSERT INTO catalog_public.domains (
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

CREATE FUNCTION catalog_public.tg_domains_catalog_del() RETURNS trigger AS $EOFCODE$BEGIN
  DELETE FROM catalog_public.domains WHERE id = old.id;
  RETURN OLD;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_public.tg_platform_apis_catalog_sync() RETURNS trigger AS $EOFCODE$BEGIN
  INSERT INTO catalog_public.apis (
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

CREATE FUNCTION catalog_public.tg_platform_apis_catalog_del() RETURNS trigger AS $EOFCODE$BEGIN
  DELETE FROM catalog_public.apis WHERE id = old.id;
  RETURN OLD;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_public.tg_apis_catalog_sync() RETURNS trigger AS $EOFCODE$BEGIN
  INSERT INTO catalog_public.apis (
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

CREATE FUNCTION catalog_public.tg_apis_catalog_del() RETURNS trigger AS $EOFCODE$BEGIN
  DELETE FROM catalog_public.apis WHERE id = old.id;
  RETURN OLD;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_public.tg_platform_sites_catalog_sync() RETURNS trigger AS $EOFCODE$BEGIN
  INSERT INTO catalog_public.sites (
    id,
    owner_scope,
    owner_key,
    is_visible,
    database_id,
    name,
    title,
    description,
    config
  ) VALUES
    (new.id, 'platform', NULL, COALESCE(new.is_published, false), jwt_private.current_database_id(), new.name, new.title, new.description, new.config) ON CONFLICT (id) DO UPDATE SET 
    owner_key = excluded.owner_key,
    is_visible = excluded.is_visible,
    database_id = excluded.database_id,
    name = excluded.name,
    title = excluded.title,
    description = excluded.description,
    config = excluded.config;
  RETURN NEW;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_public.tg_platform_sites_catalog_del() RETURNS trigger AS $EOFCODE$BEGIN
  DELETE FROM catalog_public.sites WHERE id = old.id;
  RETURN OLD;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_public.tg_sites_catalog_sync() RETURNS trigger AS $EOFCODE$BEGIN
  INSERT INTO catalog_public.sites (
    id,
    owner_scope,
    owner_key,
    is_visible,
    database_id,
    name,
    title,
    description,
    config
  ) VALUES
    (new.id, 'database', new.database_id, COALESCE(new.is_published, false), new.database_id, new.name, new.title, new.description, new.config) ON CONFLICT (id) DO UPDATE SET 
    owner_key = excluded.owner_key,
    is_visible = excluded.is_visible,
    database_id = excluded.database_id,
    name = excluded.name,
    title = excluded.title,
    description = excluded.description,
    config = excluded.config;
  RETURN NEW;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_public.tg_sites_catalog_del() RETURNS trigger AS $EOFCODE$BEGIN
  DELETE FROM catalog_public.sites WHERE id = old.id;
  RETURN OLD;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_public.tg_platform_namespaces_catalog_sync() RETURNS trigger AS $EOFCODE$BEGIN
  INSERT INTO catalog_public.namespaces (
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

CREATE FUNCTION catalog_public.tg_platform_namespaces_catalog_del() RETURNS trigger AS $EOFCODE$BEGIN
  DELETE FROM catalog_public.namespaces WHERE id = old.id;
  RETURN OLD;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_public.tg_namespaces_catalog_sync() RETURNS trigger AS $EOFCODE$BEGIN
  INSERT INTO catalog_public.namespaces (
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

CREATE FUNCTION catalog_public.tg_namespaces_catalog_del() RETURNS trigger AS $EOFCODE$BEGIN
  DELETE FROM catalog_public.namespaces WHERE id = old.id;
  RETURN OLD;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_public.tg_platform_function_definitions_catalog_sync() RETURNS trigger AS $EOFCODE$BEGIN
  INSERT INTO catalog_public.functions (
    id,
    owner_scope,
    owner_key,
    is_visible,
    database_id,
    task_identifier
  ) VALUES
    (new.id, 'platform', NULL, COALESCE(new.is_published, false), jwt_private.current_database_id(), new.task_identifier) ON CONFLICT (id) DO UPDATE SET 
    owner_key = excluded.owner_key,
    is_visible = excluded.is_visible,
    database_id = excluded.database_id,
    task_identifier = excluded.task_identifier;
  RETURN NEW;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_public.tg_platform_function_definitions_catalog_del() RETURNS trigger AS $EOFCODE$BEGIN
  DELETE FROM catalog_public.functions WHERE id = old.id;
  RETURN OLD;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_public.tg_function_definitions_catalog_sync() RETURNS trigger AS $EOFCODE$BEGIN
  INSERT INTO catalog_public.functions (
    id,
    owner_scope,
    owner_key,
    is_visible,
    database_id,
    task_identifier
  ) VALUES
    (new.id, 'database', new.database_id, COALESCE(new.is_published, false), new.database_id, new.task_identifier) ON CONFLICT (id) DO UPDATE SET 
    owner_key = excluded.owner_key,
    is_visible = excluded.is_visible,
    database_id = excluded.database_id,
    task_identifier = excluded.task_identifier;
  RETURN NEW;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_public.tg_function_definitions_catalog_del() RETURNS trigger AS $EOFCODE$BEGIN
  DELETE FROM catalog_public.functions WHERE id = old.id;
  RETURN OLD;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_public.tg_platform_buckets_catalog_sync() RETURNS trigger AS $EOFCODE$BEGIN
  INSERT INTO catalog_public.buckets (
    id,
    owner_scope,
    owner_key,
    is_visible,
    database_id,
    key,
    type,
    physical_name
  ) VALUES
    (new.id, 'platform', NULL, COALESCE(new.is_public, false), jwt_private.current_database_id(), new.key, new.type, new.physical_name) ON CONFLICT (id) DO UPDATE SET 
    owner_key = excluded.owner_key,
    is_visible = excluded.is_visible,
    database_id = excluded.database_id,
    key = excluded.key,
    type = excluded.type,
    physical_name = excluded.physical_name;
  RETURN NEW;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_public.tg_platform_buckets_catalog_del() RETURNS trigger AS $EOFCODE$BEGIN
  DELETE FROM catalog_public.buckets WHERE id = old.id;
  RETURN OLD;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_public.tg_buckets_catalog_sync() RETURNS trigger AS $EOFCODE$BEGIN
  INSERT INTO catalog_public.buckets (
    id,
    owner_scope,
    owner_key,
    is_visible,
    database_id,
    key,
    type,
    physical_name
  ) VALUES
    (new.id, 'database', new.database_id, COALESCE(new.is_public, false), new.database_id, new.key, new.type, new.physical_name) ON CONFLICT (id) DO UPDATE SET 
    owner_key = excluded.owner_key,
    is_visible = excluded.is_visible,
    database_id = excluded.database_id,
    key = excluded.key,
    type = excluded.type,
    physical_name = excluded.physical_name;
  RETURN NEW;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_public.tg_buckets_catalog_del() RETURNS trigger AS $EOFCODE$BEGIN
  DELETE FROM catalog_public.buckets WHERE id = old.id;
  RETURN OLD;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_public.tg_platform_resources_catalog_sync() RETURNS trigger AS $EOFCODE$BEGIN
  INSERT INTO catalog_public.resources (
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

CREATE FUNCTION catalog_public.tg_platform_resources_catalog_del() RETURNS trigger AS $EOFCODE$BEGIN
  DELETE FROM catalog_public.resources WHERE id = old.id;
  RETURN OLD;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_public.tg_platform_resource_definitions_catalog_sync() RETURNS trigger AS $EOFCODE$BEGIN
  INSERT INTO catalog_public.resource_definitions (
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

CREATE FUNCTION catalog_public.tg_platform_resource_definitions_catalog_del() RETURNS trigger AS $EOFCODE$BEGIN
  DELETE FROM catalog_public.resource_definitions WHERE id = old.id;
  RETURN OLD;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_public.tg_platform_resource_installations_catalog_sync() RETURNS trigger AS $EOFCODE$BEGIN
  INSERT INTO catalog_public.resource_installations (
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

CREATE FUNCTION catalog_public.tg_platform_resource_installations_catalog_del() RETURNS trigger AS $EOFCODE$BEGIN
  DELETE FROM catalog_public.resource_installations WHERE id = old.id;
  RETURN OLD;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_public.tg_resources_catalog_sync() RETURNS trigger AS $EOFCODE$BEGIN
  INSERT INTO catalog_public.resources (
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

CREATE FUNCTION catalog_public.tg_resources_catalog_del() RETURNS trigger AS $EOFCODE$BEGIN
  DELETE FROM catalog_public.resources WHERE id = old.id;
  RETURN OLD;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_public.tg_resource_definitions_catalog_sync() RETURNS trigger AS $EOFCODE$BEGIN
  INSERT INTO catalog_public.resource_definitions (
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

CREATE FUNCTION catalog_public.tg_resource_definitions_catalog_del() RETURNS trigger AS $EOFCODE$BEGIN
  DELETE FROM catalog_public.resource_definitions WHERE id = old.id;
  RETURN OLD;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_public.tg_resource_installations_catalog_sync() RETURNS trigger AS $EOFCODE$BEGIN
  INSERT INTO catalog_public.resource_installations (
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

CREATE FUNCTION catalog_public.tg_resource_installations_catalog_del() RETURNS trigger AS $EOFCODE$BEGIN
  DELETE FROM catalog_public.resource_installations WHERE id = old.id;
  RETURN OLD;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION catalog_public.tg_apps_catalog_sync() RETURNS trigger AS $EOFCODE$BEGIN
  INSERT INTO catalog_public.apps (
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

CREATE FUNCTION catalog_public.tg_apps_catalog_del() RETURNS trigger AS $EOFCODE$BEGIN
  DELETE FROM catalog_public.apps WHERE id = old.id;
  RETURN OLD;
END$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;