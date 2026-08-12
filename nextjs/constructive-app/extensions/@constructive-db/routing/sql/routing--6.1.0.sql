\echo Use "CREATE EXTENSION routing" to load this file. \quit
CREATE TABLE routing_public.domains ();

ALTER TABLE routing_public.domains 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE routing_public.domains IS 'Fully-qualified hostnames owned by this scope; each row claims its hostname globally through the catalog';

ALTER TABLE routing_public.domains 
  ADD COLUMN id uuid;

ALTER TABLE routing_public.domains 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE routing_public.domains 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE routing_public.domains 
  ADD CONSTRAINT domains_pkey PRIMARY KEY (id);

ALTER TABLE routing_public.domains 
  ADD COLUMN created_at timestamptz;

ALTER TABLE routing_public.domains 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE routing_public.domains 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE routing_public.domains 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE INDEX domains_created_at_idx ON routing_public.domains (created_at);

CREATE INDEX domains_updated_at_idx ON routing_public.domains (updated_at);

ALTER TABLE routing_public.domains 
  ADD COLUMN hostname text;

ALTER TABLE routing_public.domains 
  ALTER COLUMN hostname SET NOT NULL;

COMMENT ON COLUMN routing_public.domains.hostname IS 'Lowercase fully-qualified hostname; wildcards use the *.parent form';

ALTER TABLE routing_public.domains 
  ADD COLUMN managed boolean;

ALTER TABLE routing_public.domains 
  ALTER COLUMN managed SET NOT NULL;

ALTER TABLE routing_public.domains 
  ALTER COLUMN managed SET DEFAULT false;

COMMENT ON COLUMN routing_public.domains.managed IS 'Whether the platform drives this hostname''s DNS verification and certificate lifecycle';

ALTER TABLE routing_public.domains 
  ADD COLUMN is_wildcard boolean;

ALTER TABLE routing_public.domains 
  ALTER COLUMN is_wildcard SET NOT NULL;

ALTER TABLE routing_public.domains 
  ALTER COLUMN is_wildcard SET DEFAULT false;

COMMENT ON COLUMN routing_public.domains.is_wildcard IS 'Whether this hostname is a *.parent wildcard claim';

ALTER TABLE routing_public.domains 
  ADD COLUMN parent_hostname text;

COMMENT ON COLUMN routing_public.domains.parent_hostname IS 'Parent hostname a wildcard claim covers (example.com for *.example.com)';

ALTER TABLE routing_public.domains 
  ADD COLUMN verification_status text;

ALTER TABLE routing_public.domains 
  ALTER COLUMN verification_status SET NOT NULL;

ALTER TABLE routing_public.domains 
  ALTER COLUMN verification_status SET DEFAULT 'unverified';

COMMENT ON COLUMN routing_public.domains.verification_status IS 'Ownership verification state of this hostname';

ALTER TABLE routing_public.domains 
  ADD COLUMN verified_at timestamptz;

COMMENT ON COLUMN routing_public.domains.verified_at IS 'When ownership verification last succeeded';

ALTER TABLE routing_public.domains 
  ADD COLUMN tls_status text;

ALTER TABLE routing_public.domains 
  ALTER COLUMN tls_status SET NOT NULL;

ALTER TABLE routing_public.domains 
  ALTER COLUMN tls_status SET DEFAULT 'none';

COMMENT ON COLUMN routing_public.domains.tls_status IS 'Certificate lifecycle state for this hostname';

ALTER TABLE routing_public.domains 
  ADD COLUMN tls_ready_at timestamptz;

COMMENT ON COLUMN routing_public.domains.tls_ready_at IS 'When the certificate last became ready';

ALTER TABLE routing_public.domains 
  ADD COLUMN tls_secret_name text;

COMMENT ON COLUMN routing_public.domains.tls_secret_name IS 'Name of the TLS secret serving this hostname';

ALTER TABLE routing_public.domains 
  ADD COLUMN is_published boolean;

ALTER TABLE routing_public.domains 
  ALTER COLUMN is_published SET NOT NULL;

ALTER TABLE routing_public.domains 
  ALTER COLUMN is_published SET DEFAULT false;

COMMENT ON COLUMN routing_public.domains.is_published IS 'Whether other scopes may see and bind under this hostname';

ALTER TABLE routing_public.domains 
  ADD COLUMN config jsonb;

COMMENT ON COLUMN routing_public.domains.config IS 'Module-specific configuration for this hostname';

ALTER TABLE routing_public.domains 
  ADD COLUMN database_id uuid;

ALTER TABLE routing_public.domains 
  ALTER COLUMN database_id SET NOT NULL;

COMMENT ON COLUMN routing_public.domains.database_id IS 'Database that owns this resource (database-scoped isolation)';

COMMENT ON TABLE routing_public.domains IS '@scope database
@scopeKey database_id
@scopeTier database
Fully-qualified hostnames owned by this scope; each row claims its hostname globally through the catalog';

CREATE INDEX routing_public_domains_database_id_idx ON routing_public.domains (database_id);

ALTER TABLE routing_public.domains 
  ADD CONSTRAINT domains_hostname_key 
    UNIQUE (hostname);

ALTER TABLE routing_public.domains 
  ADD CONSTRAINT domains_hostname_chk 
    CHECK (hostname = lower(hostname));

ALTER TABLE routing_public.domains 
  ADD CONSTRAINT domains_is_wildcard_hostname_parent_hostname_chk 
    CHECK (
    is_wildcard = ("left"(hostname, 2) = '*.')
      AND is_wildcard = (parent_hostname IS NOT NULL)
  );

ALTER TABLE routing_public.domains 
  ADD CONSTRAINT domains_verification_status_chk 
    CHECK (verification_status IN ('unverified', 'pending', 'verified', 'failed'));

ALTER TABLE routing_public.domains 
  ADD CONSTRAINT domains_tls_status_chk 
    CHECK (tls_status IN ('none', 'pending', 'ready', 'failed'));

CREATE TABLE routing_public.domain_verifications ();

ALTER TABLE routing_public.domain_verifications 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE routing_public.domain_verifications IS 'Ownership verification challenges issued for a domain';

ALTER TABLE routing_public.domain_verifications 
  ADD COLUMN id uuid;

ALTER TABLE routing_public.domain_verifications 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE routing_public.domain_verifications 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE routing_public.domain_verifications 
  ADD CONSTRAINT domain_verifications_pkey PRIMARY KEY (id);

ALTER TABLE routing_public.domain_verifications 
  ADD COLUMN created_at timestamptz;

ALTER TABLE routing_public.domain_verifications 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE routing_public.domain_verifications 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE routing_public.domain_verifications 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE INDEX domain_verifications_created_at_idx ON routing_public.domain_verifications (created_at);

CREATE INDEX domain_verifications_updated_at_idx ON routing_public.domain_verifications (updated_at);

ALTER TABLE routing_public.domain_verifications 
  ADD COLUMN domain_id uuid;

COMMENT ON COLUMN routing_public.domain_verifications.domain_id IS 'Scoped domain this verification challenge belongs to';

ALTER TABLE routing_public.domain_verifications 
  ADD COLUMN managed_domain_id uuid;

COMMENT ON COLUMN routing_public.domain_verifications.managed_domain_id IS 'Managed hostname this verification challenge belongs to';

ALTER TABLE routing_public.domain_verifications 
  ADD COLUMN method text;

ALTER TABLE routing_public.domain_verifications 
  ALTER COLUMN method SET NOT NULL;

COMMENT ON COLUMN routing_public.domain_verifications.method IS 'Verification method (dns-txt, http-token, …)';

ALTER TABLE routing_public.domain_verifications 
  ADD COLUMN record_type text;

COMMENT ON COLUMN routing_public.domain_verifications.record_type IS 'DNS record type the challenge expects';

ALTER TABLE routing_public.domain_verifications 
  ADD COLUMN record_name text;

COMMENT ON COLUMN routing_public.domain_verifications.record_name IS 'DNS record name the challenge expects';

ALTER TABLE routing_public.domain_verifications 
  ADD COLUMN record_value text;

COMMENT ON COLUMN routing_public.domain_verifications.record_value IS 'DNS record value the challenge expects';

ALTER TABLE routing_public.domain_verifications 
  ADD COLUMN status text;

ALTER TABLE routing_public.domain_verifications 
  ALTER COLUMN status SET NOT NULL;

ALTER TABLE routing_public.domain_verifications 
  ALTER COLUMN status SET DEFAULT 'pending';

COMMENT ON COLUMN routing_public.domain_verifications.status IS 'Challenge state';

ALTER TABLE routing_public.domain_verifications 
  ADD COLUMN attempts int;

ALTER TABLE routing_public.domain_verifications 
  ALTER COLUMN attempts SET NOT NULL;

ALTER TABLE routing_public.domain_verifications 
  ALTER COLUMN attempts SET DEFAULT 0;

COMMENT ON COLUMN routing_public.domain_verifications.attempts IS 'How many times this challenge has been probed';

ALTER TABLE routing_public.domain_verifications 
  ADD COLUMN error text;

COMMENT ON COLUMN routing_public.domain_verifications.error IS 'Last verification error, if any';

ALTER TABLE routing_public.domain_verifications 
  ADD COLUMN expires_at timestamptz;

COMMENT ON COLUMN routing_public.domain_verifications.expires_at IS 'When this challenge expires';

ALTER TABLE routing_public.domain_verifications 
  ADD COLUMN verified_at timestamptz;

COMMENT ON COLUMN routing_public.domain_verifications.verified_at IS 'When this challenge succeeded';

ALTER TABLE routing_public.domain_verifications 
  ADD COLUMN last_checked_at timestamptz;

COMMENT ON COLUMN routing_public.domain_verifications.last_checked_at IS 'When this challenge was last probed';

ALTER TABLE routing_public.domain_verifications 
  ADD COLUMN database_id uuid;

ALTER TABLE routing_public.domain_verifications 
  ALTER COLUMN database_id SET NOT NULL;

COMMENT ON COLUMN routing_public.domain_verifications.database_id IS 'Database that owns this resource (database-scoped isolation)';

COMMENT ON TABLE routing_public.domain_verifications IS '@scope database
@scopeKey database_id
@scopeTier database
Ownership verification challenges issued for a domain';

CREATE INDEX domain_verifications_database_id_idx ON routing_public.domain_verifications (database_id);

ALTER TABLE routing_public.domain_verifications 
  ADD CONSTRAINT domain_verifications_domain_id_fkey
    FOREIGN KEY(domain_id)
    REFERENCES routing_public.domains (id)
    ON DELETE CASCADE;

ALTER TABLE routing_public.domain_verifications 
  ADD CONSTRAINT domain_verifications_domain_id_managed_domain_id_chk 
    CHECK (num_nonnulls(domain_id, managed_domain_id) = 1);

CREATE INDEX domain_verifications_domain_id_idx ON routing_public.domain_verifications (domain_id);

CREATE INDEX domain_verifications_managed_domain_id_idx ON routing_public.domain_verifications (managed_domain_id);

CREATE TABLE routing_public.domain_events ();

ALTER TABLE routing_public.domain_events 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE routing_public.domain_events IS 'Audit trail of domain lifecycle events';

ALTER TABLE routing_public.domain_events 
  ADD COLUMN id uuid;

ALTER TABLE routing_public.domain_events 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE routing_public.domain_events 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE routing_public.domain_events 
  ADD CONSTRAINT domain_events_pkey PRIMARY KEY (id);

ALTER TABLE routing_public.domain_events 
  ADD COLUMN created_at timestamptz;

ALTER TABLE routing_public.domain_events 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE routing_public.domain_events 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE routing_public.domain_events 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE INDEX domain_events_created_at_idx ON routing_public.domain_events (created_at);

CREATE INDEX domain_events_updated_at_idx ON routing_public.domain_events (updated_at);

ALTER TABLE routing_public.domain_events 
  ADD COLUMN domain_id uuid;

COMMENT ON COLUMN routing_public.domain_events.domain_id IS 'Scoped domain this event belongs to';

ALTER TABLE routing_public.domain_events 
  ADD COLUMN managed_domain_id uuid;

COMMENT ON COLUMN routing_public.domain_events.managed_domain_id IS 'Managed hostname this event belongs to';

ALTER TABLE routing_public.domain_events 
  ADD COLUMN actor_id uuid;

COMMENT ON COLUMN routing_public.domain_events.actor_id IS 'User who triggered this event, if any';

ALTER TABLE routing_public.domain_events 
  ADD COLUMN domain_verification_id uuid;

COMMENT ON COLUMN routing_public.domain_events.domain_verification_id IS 'Verification challenge this event relates to, if any';

ALTER TABLE routing_public.domain_events 
  ADD COLUMN event_type text;

ALTER TABLE routing_public.domain_events 
  ALTER COLUMN event_type SET NOT NULL;

COMMENT ON COLUMN routing_public.domain_events.event_type IS 'Lifecycle event discriminator';

ALTER TABLE routing_public.domain_events 
  ADD COLUMN message text;

COMMENT ON COLUMN routing_public.domain_events.message IS 'Human-readable event message';

ALTER TABLE routing_public.domain_events 
  ADD COLUMN metadata jsonb;

COMMENT ON COLUMN routing_public.domain_events.metadata IS 'Structured event metadata';

ALTER TABLE routing_public.domain_events 
  ADD COLUMN database_id uuid;

ALTER TABLE routing_public.domain_events 
  ALTER COLUMN database_id SET NOT NULL;

COMMENT ON COLUMN routing_public.domain_events.database_id IS 'Database that owns this resource (database-scoped isolation)';

COMMENT ON TABLE routing_public.domain_events IS '@scope database
@scopeKey database_id
@scopeTier database
Audit trail of domain lifecycle events';

CREATE INDEX domain_events_database_id_idx ON routing_public.domain_events (database_id);

ALTER TABLE routing_public.domain_events 
  ADD CONSTRAINT domain_events_domain_id_fkey
    FOREIGN KEY(domain_id)
    REFERENCES routing_public.domains (id)
    ON DELETE CASCADE;

ALTER TABLE routing_public.domain_events 
  ADD CONSTRAINT domain_events_domain_verification_id_fkey
    FOREIGN KEY(domain_verification_id)
    REFERENCES routing_public.domain_verifications (id)
    ON DELETE SET NULL;

ALTER TABLE routing_public.domain_events 
  ADD CONSTRAINT domain_events_domain_id_managed_domain_id_chk 
    CHECK (num_nonnulls(domain_id, managed_domain_id) = 1);

CREATE INDEX domain_events_domain_id_idx ON routing_public.domain_events (domain_id);

CREATE INDEX domain_events_managed_domain_id_idx ON routing_public.domain_events (managed_domain_id);

CREATE TABLE routing_public.managed_domains ();

ALTER TABLE routing_public.managed_domains 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE routing_public.managed_domains IS 'Platform-operated hostnames whose DNS and certificate lifecycle the platform drives';

ALTER TABLE routing_public.managed_domains 
  ADD COLUMN id uuid;

ALTER TABLE routing_public.managed_domains 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE routing_public.managed_domains 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE routing_public.managed_domains 
  ADD CONSTRAINT managed_domains_pkey PRIMARY KEY (id);

ALTER TABLE routing_public.managed_domains 
  ADD COLUMN created_at timestamptz;

ALTER TABLE routing_public.managed_domains 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE routing_public.managed_domains 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE routing_public.managed_domains 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE INDEX managed_domains_created_at_idx ON routing_public.managed_domains (created_at);

CREATE INDEX managed_domains_updated_at_idx ON routing_public.managed_domains (updated_at);

ALTER TABLE routing_public.managed_domains 
  ADD COLUMN domain text;

ALTER TABLE routing_public.managed_domains 
  ALTER COLUMN domain SET NOT NULL;

COMMENT ON COLUMN routing_public.managed_domains.domain IS 'Lowercase fully-qualified managed hostname; wildcards use the *.parent form';

ALTER TABLE routing_public.managed_domains 
  ADD COLUMN is_wildcard boolean;

ALTER TABLE routing_public.managed_domains 
  ALTER COLUMN is_wildcard SET NOT NULL;

ALTER TABLE routing_public.managed_domains 
  ALTER COLUMN is_wildcard SET DEFAULT false;

COMMENT ON COLUMN routing_public.managed_domains.is_wildcard IS 'Whether this managed hostname is a *.parent wildcard';

ALTER TABLE routing_public.managed_domains 
  ADD COLUMN allow_public_usage boolean;

ALTER TABLE routing_public.managed_domains 
  ALTER COLUMN allow_public_usage SET NOT NULL;

ALTER TABLE routing_public.managed_domains 
  ALTER COLUMN allow_public_usage SET DEFAULT false;

COMMENT ON COLUMN routing_public.managed_domains.allow_public_usage IS 'Whether tenants may claim subdomains under this managed hostname';

ALTER TABLE routing_public.managed_domains 
  ADD COLUMN verification_status text;

ALTER TABLE routing_public.managed_domains 
  ALTER COLUMN verification_status SET NOT NULL;

ALTER TABLE routing_public.managed_domains 
  ALTER COLUMN verification_status SET DEFAULT 'pending';

COMMENT ON COLUMN routing_public.managed_domains.verification_status IS 'DNS ownership verification state of this managed hostname';

ALTER TABLE routing_public.managed_domains 
  ADD COLUMN verified_at timestamptz;

COMMENT ON COLUMN routing_public.managed_domains.verified_at IS 'When ownership verification last succeeded';

ALTER TABLE routing_public.managed_domains 
  ADD COLUMN tls_status text;

ALTER TABLE routing_public.managed_domains 
  ALTER COLUMN tls_status SET NOT NULL;

ALTER TABLE routing_public.managed_domains 
  ALTER COLUMN tls_status SET DEFAULT 'none';

COMMENT ON COLUMN routing_public.managed_domains.tls_status IS 'TLS provisioning state for this managed hostname';

ALTER TABLE routing_public.managed_domains 
  ADD COLUMN tls_ready_at timestamptz;

COMMENT ON COLUMN routing_public.managed_domains.tls_ready_at IS 'When TLS last became ready';

ALTER TABLE routing_public.managed_domains 
  ADD COLUMN cert_status text;

ALTER TABLE routing_public.managed_domains 
  ALTER COLUMN cert_status SET NOT NULL;

ALTER TABLE routing_public.managed_domains 
  ALTER COLUMN cert_status SET DEFAULT 'none';

COMMENT ON COLUMN routing_public.managed_domains.cert_status IS 'Certificate issuance state for this managed hostname';

ALTER TABLE routing_public.managed_domains 
  ADD COLUMN annotations jsonb;

ALTER TABLE routing_public.managed_domains 
  ALTER COLUMN annotations SET NOT NULL;

ALTER TABLE routing_public.managed_domains 
  ALTER COLUMN annotations SET DEFAULT '{}'::jsonb;

COMMENT ON COLUMN routing_public.managed_domains.annotations IS 'Free-form operator annotations for this managed hostname';

ALTER TABLE routing_public.managed_domains 
  ADD COLUMN database_id uuid;

ALTER TABLE routing_public.managed_domains 
  ALTER COLUMN database_id SET NOT NULL;

COMMENT ON COLUMN routing_public.managed_domains.database_id IS 'Database that owns this resource (database-scoped isolation)';

COMMENT ON TABLE routing_public.managed_domains IS '@scope database
@scopeKey database_id
@scopeTier database
Platform-operated hostnames whose DNS and certificate lifecycle the platform drives';

CREATE INDEX managed_domains_database_id_idx ON routing_public.managed_domains (database_id);

ALTER TABLE routing_public.managed_domains 
  ADD CONSTRAINT managed_domains_domain_key 
    UNIQUE (domain);

ALTER TABLE routing_public.managed_domains 
  ADD CONSTRAINT managed_domains_domain_chk 
    CHECK (domain = lower(domain));

ALTER TABLE routing_public.managed_domains 
  ADD CONSTRAINT managed_domains_verification_status_chk 
    CHECK (verification_status IN ('pending', 'checking', 'verified', 'failed', 'expired'));

ALTER TABLE routing_public.managed_domains 
  ADD CONSTRAINT managed_domains_tls_status_chk 
    CHECK (tls_status IN ('none', 'provisioning', 'active', 'failed'));

ALTER TABLE routing_public.managed_domains 
  ADD CONSTRAINT managed_domains_cert_status_chk 
    CHECK (cert_status IN ('none', 'issuing', 'active', 'error'));

ALTER TABLE routing_public.domain_verifications 
  ADD CONSTRAINT domain_verifications_managed_domain_id_fkey
    FOREIGN KEY(managed_domain_id)
    REFERENCES routing_public.managed_domains (id)
    ON DELETE CASCADE;

ALTER TABLE routing_public.domain_events 
  ADD CONSTRAINT domain_events_managed_domain_id_fkey
    FOREIGN KEY(managed_domain_id)
    REFERENCES routing_public.managed_domains (id)
    ON DELETE CASCADE;

CREATE TRIGGER catalog_sync
  AFTER INSERT OR UPDATE
  ON routing_public.domains
  FOR EACH ROW
  EXECUTE PROCEDURE catalog_private.tg_domains_catalog_sync();

CREATE TRIGGER catalog_del
  AFTER DELETE
  ON routing_public.domains
  FOR EACH ROW
  EXECUTE PROCEDURE catalog_private.tg_domains_catalog_del();

GRANT SELECT ON routing_public.domains TO authenticated;

GRANT INSERT ON routing_public.domains TO authenticated;

GRANT UPDATE ON routing_public.domains TO authenticated;

GRANT DELETE ON routing_public.domains TO authenticated;

GRANT SELECT ON routing_public.domain_verifications TO authenticated;

GRANT INSERT ON routing_public.domain_verifications TO authenticated;

GRANT UPDATE ON routing_public.domain_verifications TO authenticated;

GRANT DELETE ON routing_public.domain_verifications TO authenticated;

GRANT SELECT ON routing_public.domain_events TO authenticated;

GRANT INSERT ON routing_public.domain_events TO authenticated;

GRANT UPDATE ON routing_public.domain_events TO authenticated;

GRANT DELETE ON routing_public.domain_events TO authenticated;

GRANT SELECT ON routing_public.managed_domains TO authenticated;

GRANT INSERT ON routing_public.managed_domains TO authenticated;

GRANT UPDATE ON routing_public.managed_domains TO authenticated;

GRANT DELETE ON routing_public.managed_domains TO authenticated;

CREATE TABLE routing_public.apis ();

ALTER TABLE routing_public.apis 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE routing_public.apis IS 'API surfaces exposed by this scope; publication makes a surface bindable from other scopes';

ALTER TABLE routing_public.apis 
  ADD COLUMN id uuid;

ALTER TABLE routing_public.apis 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE routing_public.apis 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE routing_public.apis 
  ADD CONSTRAINT apis_pkey PRIMARY KEY (id);

ALTER TABLE routing_public.apis 
  ADD COLUMN created_at timestamptz;

ALTER TABLE routing_public.apis 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE routing_public.apis 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE routing_public.apis 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE INDEX apis_created_at_idx ON routing_public.apis (created_at);

CREATE INDEX apis_updated_at_idx ON routing_public.apis (updated_at);

ALTER TABLE routing_public.apis 
  ADD COLUMN name text;

ALTER TABLE routing_public.apis 
  ALTER COLUMN name SET NOT NULL;

COMMENT ON COLUMN routing_public.apis.name IS 'Owner-local API surface name';

ALTER TABLE routing_public.apis 
  ADD COLUMN dbname text;

COMMENT ON COLUMN routing_public.apis.dbname IS 'Database this API surface serves';

ALTER TABLE routing_public.apis 
  ADD COLUMN role_name text;

COMMENT ON COLUMN routing_public.apis.role_name IS 'Authenticated role the API executes as';

ALTER TABLE routing_public.apis 
  ADD COLUMN anon_role text;

COMMENT ON COLUMN routing_public.apis.anon_role IS 'Anonymous role the API executes as';

ALTER TABLE routing_public.apis 
  ADD COLUMN is_published boolean;

ALTER TABLE routing_public.apis 
  ALTER COLUMN is_published SET NOT NULL;

ALTER TABLE routing_public.apis 
  ALTER COLUMN is_published SET DEFAULT false;

COMMENT ON COLUMN routing_public.apis.is_published IS 'Whether other scopes may see and route to this API surface';

ALTER TABLE routing_public.apis 
  ADD COLUMN config jsonb;

COMMENT ON COLUMN routing_public.apis.config IS 'Module-specific configuration for this API surface';

ALTER TABLE routing_public.apis 
  ADD COLUMN database_id uuid;

ALTER TABLE routing_public.apis 
  ALTER COLUMN database_id SET NOT NULL;

COMMENT ON COLUMN routing_public.apis.database_id IS 'Database that owns this resource (database-scoped isolation)';

COMMENT ON TABLE routing_public.apis IS '@scope database
@scopeKey database_id
@scopeTier database
API surfaces exposed by this scope; publication makes a surface bindable from other scopes';

ALTER TABLE routing_public.apis 
  ADD CONSTRAINT apis_database_id_name_key 
    UNIQUE (database_id, name);

CREATE TABLE routing_public.api_schemas ();

ALTER TABLE routing_public.api_schemas 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE routing_public.api_schemas IS 'Join table linking API surfaces to the metaschema schemas they expose';

ALTER TABLE routing_public.api_schemas 
  ADD COLUMN id uuid;

ALTER TABLE routing_public.api_schemas 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE routing_public.api_schemas 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE routing_public.api_schemas 
  ADD CONSTRAINT api_schemas_pkey PRIMARY KEY (id);

ALTER TABLE routing_public.api_schemas 
  ADD COLUMN created_at timestamptz;

ALTER TABLE routing_public.api_schemas 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE routing_public.api_schemas 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE routing_public.api_schemas 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE INDEX api_schemas_created_at_idx ON routing_public.api_schemas (created_at);

CREATE INDEX api_schemas_updated_at_idx ON routing_public.api_schemas (updated_at);

ALTER TABLE routing_public.api_schemas 
  ADD COLUMN api_id uuid;

ALTER TABLE routing_public.api_schemas 
  ALTER COLUMN api_id SET NOT NULL;

COMMENT ON COLUMN routing_public.api_schemas.api_id IS 'API surface that exposes this schema';

ALTER TABLE routing_public.api_schemas 
  ADD COLUMN schema_id uuid;

ALTER TABLE routing_public.api_schemas 
  ALTER COLUMN schema_id SET NOT NULL;

COMMENT ON COLUMN routing_public.api_schemas.schema_id IS 'Metaschema schema exposed through the API surface';

ALTER TABLE routing_public.api_schemas 
  ADD COLUMN database_id uuid;

ALTER TABLE routing_public.api_schemas 
  ALTER COLUMN database_id SET NOT NULL;

COMMENT ON COLUMN routing_public.api_schemas.database_id IS 'Database that owns this resource (database-scoped isolation)';

COMMENT ON TABLE routing_public.api_schemas IS '@scope database
@scopeKey database_id
@scopeTier database
Join table linking API surfaces to the metaschema schemas they expose';

CREATE INDEX api_schemas_database_id_idx ON routing_public.api_schemas (database_id);

ALTER TABLE routing_public.api_schemas 
  ADD CONSTRAINT api_schemas_api_id_fkey
    FOREIGN KEY(api_id)
    REFERENCES routing_public.apis (id)
    ON DELETE CASCADE;

ALTER TABLE routing_public.api_schemas 
  ADD CONSTRAINT api_schemas_api_id_schema_id_key 
    UNIQUE (api_id, schema_id);

CREATE INDEX api_schemas_api_id_idx ON routing_public.api_schemas (api_id);

CREATE INDEX api_schemas_schema_id_idx ON routing_public.api_schemas (schema_id);

CREATE TABLE routing_public.api_settings ();

ALTER TABLE routing_public.api_settings 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE routing_public.api_settings IS 'Per-API feature flag overrides; NULL columns inherit from database_settings';

ALTER TABLE routing_public.api_settings 
  ADD COLUMN id uuid;

ALTER TABLE routing_public.api_settings 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE routing_public.api_settings 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE routing_public.api_settings 
  ADD CONSTRAINT api_settings_pkey PRIMARY KEY (id);

ALTER TABLE routing_public.api_settings 
  ADD COLUMN created_at timestamptz;

ALTER TABLE routing_public.api_settings 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE routing_public.api_settings 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE routing_public.api_settings 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE INDEX api_settings_created_at_idx ON routing_public.api_settings (created_at);

CREATE INDEX api_settings_updated_at_idx ON routing_public.api_settings (updated_at);

ALTER TABLE routing_public.api_settings 
  ADD COLUMN api_id uuid;

ALTER TABLE routing_public.api_settings 
  ALTER COLUMN api_id SET NOT NULL;

COMMENT ON COLUMN routing_public.api_settings.api_id IS 'API surface these settings override for';

ALTER TABLE routing_public.api_settings 
  ADD COLUMN enable_aggregates boolean;

COMMENT ON COLUMN routing_public.api_settings.enable_aggregates IS 'Override: enable aggregate queries (NULL = inherit from database_settings)';

ALTER TABLE routing_public.api_settings 
  ADD COLUMN enable_postgis boolean;

COMMENT ON COLUMN routing_public.api_settings.enable_postgis IS 'Override: enable PostGIS spatial types (NULL = inherit from database_settings)';

ALTER TABLE routing_public.api_settings 
  ADD COLUMN enable_search boolean;

COMMENT ON COLUMN routing_public.api_settings.enable_search IS 'Override: enable unified search (NULL = inherit from database_settings)';

ALTER TABLE routing_public.api_settings 
  ADD COLUMN enable_direct_uploads boolean;

COMMENT ON COLUMN routing_public.api_settings.enable_direct_uploads IS 'Override: enable direct (multipart) file uploads (NULL = inherit from database_settings)';

ALTER TABLE routing_public.api_settings 
  ADD COLUMN enable_presigned_uploads boolean;

COMMENT ON COLUMN routing_public.api_settings.enable_presigned_uploads IS 'Override: enable presigned URL upload flow (NULL = inherit from database_settings)';

ALTER TABLE routing_public.api_settings 
  ADD COLUMN enable_many_to_many boolean;

COMMENT ON COLUMN routing_public.api_settings.enable_many_to_many IS 'Override: enable many-to-many relationships (NULL = inherit from database_settings)';

ALTER TABLE routing_public.api_settings 
  ADD COLUMN enable_connection_filter boolean;

COMMENT ON COLUMN routing_public.api_settings.enable_connection_filter IS 'Override: enable connection filter (NULL = inherit from database_settings)';

ALTER TABLE routing_public.api_settings 
  ADD COLUMN enable_ltree boolean;

COMMENT ON COLUMN routing_public.api_settings.enable_ltree IS 'Override: enable ltree hierarchical data type (NULL = inherit from database_settings)';

ALTER TABLE routing_public.api_settings 
  ADD COLUMN enable_llm boolean;

COMMENT ON COLUMN routing_public.api_settings.enable_llm IS 'Override: enable LLM/AI integration features (NULL = inherit from database_settings)';

ALTER TABLE routing_public.api_settings 
  ADD COLUMN enable_realtime boolean;

COMMENT ON COLUMN routing_public.api_settings.enable_realtime IS 'Override: enable realtime subscriptions (NULL = inherit from database_settings)';

ALTER TABLE routing_public.api_settings 
  ADD COLUMN enable_bulk boolean;

COMMENT ON COLUMN routing_public.api_settings.enable_bulk IS 'Override: enable bulk mutations (NULL = inherit from database_settings)';

ALTER TABLE routing_public.api_settings 
  ADD COLUMN enable_i18n boolean;

COMMENT ON COLUMN routing_public.api_settings.enable_i18n IS 'Override: enable internationalization plugin (NULL = inherit from database_settings)';

ALTER TABLE routing_public.api_settings 
  ADD COLUMN statement_timeout_ms bigint;

COMMENT ON COLUMN routing_public.api_settings.statement_timeout_ms IS 'Override: GraphQL statement timeout in milliseconds (NULL = inherit from database_settings). Clamped by the plan cap at read time.';

ALTER TABLE routing_public.api_settings 
  ADD COLUMN options jsonb;

ALTER TABLE routing_public.api_settings 
  ALTER COLUMN options SET NOT NULL;

ALTER TABLE routing_public.api_settings 
  ALTER COLUMN options SET DEFAULT '{}'::jsonb;

COMMENT ON COLUMN routing_public.api_settings.options IS 'Extensible JSON for additional per-API settings that do not have dedicated columns';

ALTER TABLE routing_public.api_settings 
  ADD COLUMN database_id uuid;

ALTER TABLE routing_public.api_settings 
  ALTER COLUMN database_id SET NOT NULL;

COMMENT ON COLUMN routing_public.api_settings.database_id IS 'Database that owns this resource (database-scoped isolation)';

COMMENT ON TABLE routing_public.api_settings IS '@scope database
@scopeKey database_id
@scopeTier database
Per-API feature flag overrides; NULL columns inherit from database_settings';

CREATE INDEX api_settings_database_id_idx ON routing_public.api_settings (database_id);

ALTER TABLE routing_public.api_settings 
  ADD CONSTRAINT api_settings_api_id_fkey
    FOREIGN KEY(api_id)
    REFERENCES routing_public.apis (id)
    ON DELETE CASCADE;

ALTER TABLE routing_public.api_settings 
  ADD CONSTRAINT api_settings_api_id_key 
    UNIQUE (api_id);

CREATE TABLE routing_public.cors_settings ();

ALTER TABLE routing_public.cors_settings 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE routing_public.cors_settings IS 'Scope-wide and per-API CORS origin configuration; NULL api_id means scope-wide default';

ALTER TABLE routing_public.cors_settings 
  ADD COLUMN id uuid;

ALTER TABLE routing_public.cors_settings 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE routing_public.cors_settings 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE routing_public.cors_settings 
  ADD CONSTRAINT cors_settings_pkey PRIMARY KEY (id);

ALTER TABLE routing_public.cors_settings 
  ADD COLUMN created_at timestamptz;

ALTER TABLE routing_public.cors_settings 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE routing_public.cors_settings 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE routing_public.cors_settings 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE INDEX cors_settings_created_at_idx ON routing_public.cors_settings (created_at);

CREATE INDEX cors_settings_updated_at_idx ON routing_public.cors_settings (updated_at);

ALTER TABLE routing_public.cors_settings 
  ADD COLUMN api_id uuid;

COMMENT ON COLUMN routing_public.cors_settings.api_id IS 'Optional API surface for per-API override; NULL means scope-wide default';

ALTER TABLE routing_public.cors_settings 
  ADD COLUMN allowed_origins text[];

ALTER TABLE routing_public.cors_settings 
  ALTER COLUMN allowed_origins SET NOT NULL;

ALTER TABLE routing_public.cors_settings 
  ALTER COLUMN allowed_origins SET DEFAULT CAST(ARRAY[] AS text[]);

COMMENT ON COLUMN routing_public.cors_settings.allowed_origins IS 'Array of allowed CORS origins (e.g. https://example.com)';

ALTER TABLE routing_public.cors_settings 
  ADD COLUMN database_id uuid;

ALTER TABLE routing_public.cors_settings 
  ALTER COLUMN database_id SET NOT NULL;

COMMENT ON COLUMN routing_public.cors_settings.database_id IS 'Database that owns this resource (database-scoped isolation)';

COMMENT ON TABLE routing_public.cors_settings IS '@scope database
@scopeKey database_id
@scopeTier database
Scope-wide and per-API CORS origin configuration; NULL api_id means scope-wide default';

ALTER TABLE routing_public.cors_settings 
  ADD CONSTRAINT cors_settings_api_id_fkey
    FOREIGN KEY(api_id)
    REFERENCES routing_public.apis (id)
    ON DELETE CASCADE;

ALTER TABLE routing_public.cors_settings 
  ADD CONSTRAINT cors_settings_database_id_api_id_key 
    UNIQUE (database_id, api_id);

CREATE INDEX cors_settings_api_id_idx ON routing_public.cors_settings (api_id);

CREATE TRIGGER catalog_sync
  AFTER INSERT OR UPDATE
  ON routing_public.apis
  FOR EACH ROW
  EXECUTE PROCEDURE catalog_private.tg_apis_catalog_sync();

CREATE TRIGGER catalog_del
  AFTER DELETE
  ON routing_public.apis
  FOR EACH ROW
  EXECUTE PROCEDURE catalog_private.tg_apis_catalog_del();

GRANT SELECT ON routing_public.apis TO authenticated;

GRANT INSERT ON routing_public.apis TO authenticated;

GRANT UPDATE ON routing_public.apis TO authenticated;

GRANT DELETE ON routing_public.apis TO authenticated;

GRANT SELECT ON routing_public.api_schemas TO authenticated;

GRANT INSERT ON routing_public.api_schemas TO authenticated;

GRANT UPDATE ON routing_public.api_schemas TO authenticated;

GRANT DELETE ON routing_public.api_schemas TO authenticated;

GRANT SELECT ON routing_public.api_settings TO authenticated;

GRANT INSERT ON routing_public.api_settings TO authenticated;

GRANT UPDATE ON routing_public.api_settings TO authenticated;

GRANT DELETE ON routing_public.api_settings TO authenticated;

GRANT SELECT ON routing_public.cors_settings TO authenticated;

GRANT INSERT ON routing_public.cors_settings TO authenticated;

GRANT UPDATE ON routing_public.cors_settings TO authenticated;

GRANT DELETE ON routing_public.cors_settings TO authenticated;

CREATE TABLE routing_public.sites ();

ALTER TABLE routing_public.sites 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE routing_public.sites IS 'Site surfaces exposed by this scope; publication makes a surface bindable from other scopes';

ALTER TABLE routing_public.sites 
  ADD COLUMN id uuid;

ALTER TABLE routing_public.sites 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE routing_public.sites 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE routing_public.sites 
  ADD CONSTRAINT sites_pkey PRIMARY KEY (id);

ALTER TABLE routing_public.sites 
  ADD COLUMN created_at timestamptz;

ALTER TABLE routing_public.sites 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE routing_public.sites 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE routing_public.sites 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE INDEX sites_created_at_idx ON routing_public.sites (created_at);

CREATE INDEX sites_updated_at_idx ON routing_public.sites (updated_at);

ALTER TABLE routing_public.sites 
  ADD COLUMN name text;

ALTER TABLE routing_public.sites 
  ALTER COLUMN name SET NOT NULL;

COMMENT ON COLUMN routing_public.sites.name IS 'Owner-local site surface name';

ALTER TABLE routing_public.sites 
  ADD COLUMN title text;

COMMENT ON COLUMN routing_public.sites.title IS 'Human-readable site title';

ALTER TABLE routing_public.sites 
  ADD COLUMN description text;

COMMENT ON COLUMN routing_public.sites.description IS 'Human-readable site description';

ALTER TABLE routing_public.sites 
  ADD COLUMN is_published boolean;

ALTER TABLE routing_public.sites 
  ALTER COLUMN is_published SET NOT NULL;

ALTER TABLE routing_public.sites 
  ALTER COLUMN is_published SET DEFAULT false;

COMMENT ON COLUMN routing_public.sites.is_published IS 'Whether other scopes may see and route to this site surface';

ALTER TABLE routing_public.sites 
  ADD COLUMN bucket_id uuid;

COMMENT ON COLUMN routing_public.sites.bucket_id IS 'Catalog bucket that backs this site (static content store; exactly one of bucket_id/resource_id)';

ALTER TABLE routing_public.sites 
  ADD COLUMN resource_id uuid;

COMMENT ON COLUMN routing_public.sites.resource_id IS 'Catalog resource/service that backs this site (SSR/app Service pinned to one concrete resource row; exactly one of bucket_id/resource_id/installation_id)';

ALTER TABLE routing_public.sites 
  ADD COLUMN installation_id uuid;

COMMENT ON COLUMN routing_public.sites.installation_id IS 'Catalog resource_installation (release) that backs this site; the servable member is named by installation_member_slug (exactly one of bucket_id/resource_id/installation_id)';

ALTER TABLE routing_public.sites 
  ADD COLUMN installation_member_slug text;

COMMENT ON COLUMN routing_public.sites.installation_member_slug IS 'Slug of the release member (a Service resource) that serves this site; set iff installation_id is set';

ALTER TABLE routing_public.sites 
  ADD COLUMN active_commit_id uuid;

COMMENT ON COLUMN routing_public.sites.active_commit_id IS 'Infra-store commit pinned as the live page content for this site (manual publish pointer; NULL = nothing published yet)';

ALTER TABLE routing_public.sites 
  ADD CONSTRAINT sites_bucket_id_resource_id_installation_id_chk 
    CHECK (num_nonnulls(bucket_id, resource_id, installation_id) = 1);

ALTER TABLE routing_public.sites 
  ADD CONSTRAINT sites_installation_id_installation_member_slug_chk 
    CHECK (num_nonnulls(installation_id, installation_member_slug) <> 1);

ALTER TABLE routing_public.sites 
  ADD CONSTRAINT sites_bucket_id_fkey
    FOREIGN KEY(bucket_id)
    REFERENCES catalog_private.buckets (id)
    ON DELETE CASCADE;

CREATE INDEX routing_public_sites_bucket_id_idx ON routing_public.sites (bucket_id);

ALTER TABLE routing_public.sites 
  ADD CONSTRAINT sites_resource_id_fkey
    FOREIGN KEY(resource_id)
    REFERENCES catalog_private.resources (id)
    ON DELETE CASCADE;

CREATE INDEX routing_public_sites_resource_id_idx ON routing_public.sites (resource_id);

ALTER TABLE routing_public.sites 
  ADD CONSTRAINT sites_installation_id_fkey
    FOREIGN KEY(installation_id)
    REFERENCES catalog_private.resource_installations (id)
    ON DELETE RESTRICT;

CREATE INDEX routing_public_sites_installation_id_idx ON routing_public.sites (installation_id);

ALTER TABLE routing_public.sites 
  ADD COLUMN database_id uuid;

ALTER TABLE routing_public.sites 
  ALTER COLUMN database_id SET NOT NULL;

COMMENT ON COLUMN routing_public.sites.database_id IS 'Database that owns this resource (database-scoped isolation)';

COMMENT ON TABLE routing_public.sites IS '@scope database
@scopeKey database_id
@scopeTier database
Site surfaces exposed by this scope; publication makes a surface bindable from other scopes';

ALTER TABLE routing_public.sites 
  ADD CONSTRAINT sites_database_id_name_key 
    UNIQUE (database_id, name);

CREATE TABLE routing_public.site_metadata ();

ALTER TABLE routing_public.site_metadata 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE routing_public.site_metadata IS 'SEO and social sharing metadata for a site surface';

ALTER TABLE routing_public.site_metadata 
  ADD COLUMN id uuid;

ALTER TABLE routing_public.site_metadata 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE routing_public.site_metadata 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE routing_public.site_metadata 
  ADD CONSTRAINT site_metadata_pkey PRIMARY KEY (id);

ALTER TABLE routing_public.site_metadata 
  ADD COLUMN created_at timestamptz;

ALTER TABLE routing_public.site_metadata 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE routing_public.site_metadata 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE routing_public.site_metadata 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE INDEX site_metadata_created_at_idx ON routing_public.site_metadata (created_at);

CREATE INDEX site_metadata_updated_at_idx ON routing_public.site_metadata (updated_at);

ALTER TABLE routing_public.site_metadata 
  ADD COLUMN site_id uuid;

ALTER TABLE routing_public.site_metadata 
  ALTER COLUMN site_id SET NOT NULL;

COMMENT ON COLUMN routing_public.site_metadata.site_id IS 'Site surface this metadata belongs to';

ALTER TABLE routing_public.site_metadata 
  ADD COLUMN title text;

COMMENT ON COLUMN routing_public.site_metadata.title IS 'Meta title (max 120 characters)';

ALTER TABLE routing_public.site_metadata 
  ADD COLUMN description text;

COMMENT ON COLUMN routing_public.site_metadata.description IS 'Meta description (max 120 characters)';

ALTER TABLE routing_public.site_metadata 
  ADD COLUMN og_image image;

COMMENT ON COLUMN routing_public.site_metadata.og_image IS 'Open Graph image used when sharing site links';

ALTER TABLE routing_public.site_metadata 
  ADD COLUMN canonical_url text;

COMMENT ON COLUMN routing_public.site_metadata.canonical_url IS 'Canonical URL emitted in <link rel="canonical"> for this site';

ALTER TABLE routing_public.site_metadata 
  ADD COLUMN robots text;

COMMENT ON COLUMN routing_public.site_metadata.robots IS 'robots meta directive (e.g. index,follow / noindex,nofollow)';

ALTER TABLE routing_public.site_metadata 
  ADD COLUMN logo image;

COMMENT ON COLUMN routing_public.site_metadata.logo IS 'Primary site logo image';

ALTER TABLE routing_public.site_metadata 
  ADD COLUMN favicon image;

COMMENT ON COLUMN routing_public.site_metadata.favicon IS 'Site favicon image';

ALTER TABLE routing_public.site_metadata 
  ADD COLUMN apple_touch_icon image;

COMMENT ON COLUMN routing_public.site_metadata.apple_touch_icon IS 'Apple touch icon image (home-screen bookmark)';

ALTER TABLE routing_public.site_metadata 
  ADD CONSTRAINT site_metadata_title_chk 
    CHECK (character_length(title) <= 120);

ALTER TABLE routing_public.site_metadata 
  ADD CONSTRAINT site_metadata_description_chk 
    CHECK (character_length(description) <= 120);

ALTER TABLE routing_public.site_metadata 
  ADD COLUMN database_id uuid;

ALTER TABLE routing_public.site_metadata 
  ALTER COLUMN database_id SET NOT NULL;

COMMENT ON COLUMN routing_public.site_metadata.database_id IS 'Database that owns this resource (database-scoped isolation)';

COMMENT ON TABLE routing_public.site_metadata IS '@scope database
@scopeKey database_id
@scopeTier database
SEO and social sharing metadata for a site surface';

CREATE INDEX site_metadata_database_id_idx ON routing_public.site_metadata (database_id);

ALTER TABLE routing_public.site_metadata 
  ADD CONSTRAINT site_metadata_site_id_fkey
    FOREIGN KEY(site_id)
    REFERENCES routing_public.sites (id)
    ON DELETE CASCADE;

ALTER TABLE routing_public.site_metadata 
  ADD CONSTRAINT site_metadata_site_id_key 
    UNIQUE (site_id);

CREATE TABLE routing_public.site_modules ();

ALTER TABLE routing_public.site_modules 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE routing_public.site_modules IS 'Frontend module configuration for a site surface; stores module name and JSON settings';

ALTER TABLE routing_public.site_modules 
  ADD COLUMN id uuid;

ALTER TABLE routing_public.site_modules 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE routing_public.site_modules 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE routing_public.site_modules 
  ADD CONSTRAINT site_modules_pkey PRIMARY KEY (id);

ALTER TABLE routing_public.site_modules 
  ADD COLUMN created_at timestamptz;

ALTER TABLE routing_public.site_modules 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE routing_public.site_modules 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE routing_public.site_modules 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE INDEX site_modules_created_at_idx ON routing_public.site_modules (created_at);

CREATE INDEX site_modules_updated_at_idx ON routing_public.site_modules (updated_at);

ALTER TABLE routing_public.site_modules 
  ADD COLUMN site_id uuid;

ALTER TABLE routing_public.site_modules 
  ALTER COLUMN site_id SET NOT NULL;

COMMENT ON COLUMN routing_public.site_modules.site_id IS 'Site surface this module configuration belongs to';

ALTER TABLE routing_public.site_modules 
  ADD COLUMN name text;

ALTER TABLE routing_public.site_modules 
  ALTER COLUMN name SET NOT NULL;

COMMENT ON COLUMN routing_public.site_modules.name IS 'Module name (e.g. navbar, footer, analytics)';

ALTER TABLE routing_public.site_modules 
  ADD COLUMN data pg_catalog.json;

ALTER TABLE routing_public.site_modules 
  ALTER COLUMN data SET NOT NULL;

COMMENT ON COLUMN routing_public.site_modules.data IS 'JSON configuration data for this module';

ALTER TABLE routing_public.site_modules 
  ADD COLUMN is_enabled boolean;

ALTER TABLE routing_public.site_modules 
  ALTER COLUMN is_enabled SET NOT NULL;

ALTER TABLE routing_public.site_modules 
  ALTER COLUMN is_enabled SET DEFAULT true;

COMMENT ON COLUMN routing_public.site_modules.is_enabled IS 'Whether this module is active on the site surface';

ALTER TABLE routing_public.site_modules 
  ADD COLUMN "position" int;

ALTER TABLE routing_public.site_modules 
  ALTER COLUMN "position" SET NOT NULL;

ALTER TABLE routing_public.site_modules 
  ALTER COLUMN "position" SET DEFAULT 0;

COMMENT ON COLUMN routing_public.site_modules."position" IS 'Render/order position of this module within the site';

ALTER TABLE routing_public.site_modules 
  ADD COLUMN database_id uuid;

ALTER TABLE routing_public.site_modules 
  ALTER COLUMN database_id SET NOT NULL;

COMMENT ON COLUMN routing_public.site_modules.database_id IS 'Database that owns this resource (database-scoped isolation)';

COMMENT ON TABLE routing_public.site_modules IS '@scope database
@scopeKey database_id
@scopeTier database
Frontend module configuration for a site surface; stores module name and JSON settings';

CREATE INDEX site_modules_database_id_idx ON routing_public.site_modules (database_id);

ALTER TABLE routing_public.site_modules 
  ADD CONSTRAINT site_modules_site_id_fkey
    FOREIGN KEY(site_id)
    REFERENCES routing_public.sites (id)
    ON DELETE CASCADE;

ALTER TABLE routing_public.site_modules 
  ADD CONSTRAINT site_modules_site_id_name_key 
    UNIQUE (site_id, name);

CREATE TABLE routing_public.site_themes ();

ALTER TABLE routing_public.site_themes 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE routing_public.site_themes IS 'Theme (colors, fonts, design tokens) for a site surface';

ALTER TABLE routing_public.site_themes 
  ADD COLUMN id uuid;

ALTER TABLE routing_public.site_themes 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE routing_public.site_themes 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE routing_public.site_themes 
  ADD CONSTRAINT site_themes_pkey PRIMARY KEY (id);

ALTER TABLE routing_public.site_themes 
  ADD COLUMN created_at timestamptz;

ALTER TABLE routing_public.site_themes 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE routing_public.site_themes 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE routing_public.site_themes 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE INDEX site_themes_created_at_idx ON routing_public.site_themes (created_at);

CREATE INDEX site_themes_updated_at_idx ON routing_public.site_themes (updated_at);

ALTER TABLE routing_public.site_themes 
  ADD COLUMN site_id uuid;

ALTER TABLE routing_public.site_themes 
  ALTER COLUMN site_id SET NOT NULL;

COMMENT ON COLUMN routing_public.site_themes.site_id IS 'Site surface this theme belongs to';

ALTER TABLE routing_public.site_themes 
  ADD COLUMN name text;

ALTER TABLE routing_public.site_themes 
  ALTER COLUMN name SET NOT NULL;

ALTER TABLE routing_public.site_themes 
  ALTER COLUMN name SET DEFAULT 'default';

COMMENT ON COLUMN routing_public.site_themes.name IS 'Owner-local theme name (a site may hold multiple named themes)';

ALTER TABLE routing_public.site_themes 
  ADD COLUMN theme jsonb;

ALTER TABLE routing_public.site_themes 
  ALTER COLUMN theme SET NOT NULL;

COMMENT ON COLUMN routing_public.site_themes.theme IS 'Theme document (colors, fonts, design tokens)';

ALTER TABLE routing_public.site_themes 
  ADD COLUMN is_active boolean;

ALTER TABLE routing_public.site_themes 
  ALTER COLUMN is_active SET NOT NULL;

ALTER TABLE routing_public.site_themes 
  ALTER COLUMN is_active SET DEFAULT false;

COMMENT ON COLUMN routing_public.site_themes.is_active IS 'Whether this is the active theme for the site surface';

ALTER TABLE routing_public.site_themes 
  ADD COLUMN database_id uuid;

ALTER TABLE routing_public.site_themes 
  ALTER COLUMN database_id SET NOT NULL;

COMMENT ON COLUMN routing_public.site_themes.database_id IS 'Database that owns this resource (database-scoped isolation)';

COMMENT ON TABLE routing_public.site_themes IS '@scope database
@scopeKey database_id
@scopeTier database
Theme (colors, fonts, design tokens) for a site surface';

CREATE INDEX site_themes_database_id_idx ON routing_public.site_themes (database_id);

ALTER TABLE routing_public.site_themes 
  ADD CONSTRAINT site_themes_site_id_fkey
    FOREIGN KEY(site_id)
    REFERENCES routing_public.sites (id)
    ON DELETE CASCADE;

ALTER TABLE routing_public.site_themes 
  ADD CONSTRAINT site_themes_site_id_name_key 
    UNIQUE (site_id, name);

CREATE TABLE routing_public.site_app_links ();

ALTER TABLE routing_public.site_app_links 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE routing_public.site_app_links IS 'Native-app deep-link association metadata for a site surface (feeds AASA / assetlinks.json generation)';

ALTER TABLE routing_public.site_app_links 
  ADD COLUMN id uuid;

ALTER TABLE routing_public.site_app_links 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE routing_public.site_app_links 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE routing_public.site_app_links 
  ADD CONSTRAINT site_app_links_pkey PRIMARY KEY (id);

ALTER TABLE routing_public.site_app_links 
  ADD COLUMN created_at timestamptz;

ALTER TABLE routing_public.site_app_links 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE routing_public.site_app_links 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE routing_public.site_app_links 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE INDEX site_app_links_created_at_idx ON routing_public.site_app_links (created_at);

CREATE INDEX site_app_links_updated_at_idx ON routing_public.site_app_links (updated_at);

ALTER TABLE routing_public.site_app_links 
  ADD COLUMN site_id uuid;

ALTER TABLE routing_public.site_app_links 
  ALTER COLUMN site_id SET NOT NULL;

COMMENT ON COLUMN routing_public.site_app_links.site_id IS 'Site surface this app-link association belongs to';

ALTER TABLE routing_public.site_app_links 
  ADD COLUMN platform text;

ALTER TABLE routing_public.site_app_links 
  ALTER COLUMN platform SET NOT NULL;

COMMENT ON COLUMN routing_public.site_app_links.platform IS 'Target platform for this association (ios, android)';

ALTER TABLE routing_public.site_app_links 
  ADD COLUMN app_identifier text;

ALTER TABLE routing_public.site_app_links 
  ALTER COLUMN app_identifier SET NOT NULL;

COMMENT ON COLUMN routing_public.site_app_links.app_identifier IS 'App identifier: iOS bundle id or Android package name';

ALTER TABLE routing_public.site_app_links 
  ADD COLUMN team_id text;

COMMENT ON COLUMN routing_public.site_app_links.team_id IS 'Apple Developer team id (iOS); combined with app_identifier to form the AASA appID';

ALTER TABLE routing_public.site_app_links 
  ADD COLUMN sha256_cert_fingerprints text[];

ALTER TABLE routing_public.site_app_links 
  ALTER COLUMN sha256_cert_fingerprints SET NOT NULL;

ALTER TABLE routing_public.site_app_links 
  ALTER COLUMN sha256_cert_fingerprints SET DEFAULT CAST(ARRAY[] AS text[]);

COMMENT ON COLUMN routing_public.site_app_links.sha256_cert_fingerprints IS 'Android signing certificate SHA-256 fingerprints for assetlinks.json';

ALTER TABLE routing_public.site_app_links 
  ADD COLUMN path_components text[];

ALTER TABLE routing_public.site_app_links 
  ALTER COLUMN path_components SET NOT NULL;

ALTER TABLE routing_public.site_app_links 
  ALTER COLUMN path_components SET DEFAULT CAST(ARRAY[] AS text[]);

COMMENT ON COLUMN routing_public.site_app_links.path_components IS 'Path patterns this association applies to (AASA paths / Android intent-filter paths)';

ALTER TABLE routing_public.site_app_links 
  ADD COLUMN webcredentials boolean;

ALTER TABLE routing_public.site_app_links 
  ALTER COLUMN webcredentials SET NOT NULL;

ALTER TABLE routing_public.site_app_links 
  ALTER COLUMN webcredentials SET DEFAULT false;

COMMENT ON COLUMN routing_public.site_app_links.webcredentials IS 'Whether to emit the webcredentials service (iOS shared-web-credentials / password autofill)';

ALTER TABLE routing_public.site_app_links 
  ADD COLUMN store_url text;

COMMENT ON COLUMN routing_public.site_app_links.store_url IS 'App/Play store URL for this app (used by install banners and fallbacks)';

ALTER TABLE routing_public.site_app_links 
  ADD COLUMN database_id uuid;

ALTER TABLE routing_public.site_app_links 
  ALTER COLUMN database_id SET NOT NULL;

COMMENT ON COLUMN routing_public.site_app_links.database_id IS 'Database that owns this resource (database-scoped isolation)';

COMMENT ON TABLE routing_public.site_app_links IS '@scope database
@scopeKey database_id
@scopeTier database
Native-app deep-link association metadata for a site surface (feeds AASA / assetlinks.json generation)';

CREATE INDEX site_app_links_database_id_idx ON routing_public.site_app_links (database_id);

ALTER TABLE routing_public.site_app_links 
  ADD CONSTRAINT site_app_links_site_id_fkey
    FOREIGN KEY(site_id)
    REFERENCES routing_public.sites (id)
    ON DELETE CASCADE;

ALTER TABLE routing_public.site_app_links 
  ADD CONSTRAINT site_app_links_site_id_platform_app_identifier_key 
    UNIQUE (site_id, platform, app_identifier);

CREATE TABLE routing_public.site_deep_links ();

ALTER TABLE routing_public.site_deep_links 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE routing_public.site_deep_links IS 'Named, retargetable deep links owned by a site surface (served at the deep-link path prefix; app interception via site_app_links)';

ALTER TABLE routing_public.site_deep_links 
  ADD COLUMN id uuid;

ALTER TABLE routing_public.site_deep_links 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE routing_public.site_deep_links 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE routing_public.site_deep_links 
  ADD CONSTRAINT site_deep_links_pkey PRIMARY KEY (id);

ALTER TABLE routing_public.site_deep_links 
  ADD COLUMN created_at timestamptz;

ALTER TABLE routing_public.site_deep_links 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE routing_public.site_deep_links 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE routing_public.site_deep_links 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE INDEX site_deep_links_created_at_idx ON routing_public.site_deep_links (created_at);

CREATE INDEX site_deep_links_updated_at_idx ON routing_public.site_deep_links (updated_at);

ALTER TABLE routing_public.site_deep_links 
  ADD COLUMN site_id uuid;

ALTER TABLE routing_public.site_deep_links 
  ALTER COLUMN site_id SET NOT NULL;

COMMENT ON COLUMN routing_public.site_deep_links.site_id IS 'Site surface this deep link belongs to (the hostname plane that serves it)';

ALTER TABLE routing_public.site_deep_links 
  ADD COLUMN slug text;

ALTER TABLE routing_public.site_deep_links 
  ALTER COLUMN slug SET NOT NULL;

COMMENT ON COLUMN routing_public.site_deep_links.slug IS 'Link name unique per site; addressed at the deep-link path prefix (e.g. /l/<slug>)';

ALTER TABLE routing_public.site_deep_links 
  ADD COLUMN app_path text;

ALTER TABLE routing_public.site_deep_links 
  ALTER COLUMN app_path SET NOT NULL;

COMMENT ON COLUMN routing_public.site_deep_links.app_path IS 'In-app route the installed app opens when it intercepts this link';

ALTER TABLE routing_public.site_deep_links 
  ADD COLUMN web_path text;

COMMENT ON COLUMN routing_public.site_deep_links.web_path IS 'Web fallback path on this site (e.g. /pricing) when no app intercepts';

ALTER TABLE routing_public.site_deep_links 
  ADD COLUMN fallback_url text;

COMMENT ON COLUMN routing_public.site_deep_links.fallback_url IS 'Absolute external fallback URL for app-only targets (no web equivalent on this site)';

ALTER TABLE routing_public.site_deep_links 
  ADD COLUMN metadata jsonb;

COMMENT ON COLUMN routing_public.site_deep_links.metadata IS 'Additional link metadata (campaign/UTM parameters, escape hatch)';

ALTER TABLE routing_public.site_deep_links 
  ADD COLUMN database_id uuid;

ALTER TABLE routing_public.site_deep_links 
  ALTER COLUMN database_id SET NOT NULL;

COMMENT ON COLUMN routing_public.site_deep_links.database_id IS 'Database that owns this resource (database-scoped isolation)';

COMMENT ON TABLE routing_public.site_deep_links IS '@scope database
@scopeKey database_id
@scopeTier database
Named, retargetable deep links owned by a site surface (served at the deep-link path prefix; app interception via site_app_links)';

CREATE INDEX site_deep_links_database_id_idx ON routing_public.site_deep_links (database_id);

ALTER TABLE routing_public.site_deep_links 
  ADD CONSTRAINT site_deep_links_site_id_fkey
    FOREIGN KEY(site_id)
    REFERENCES routing_public.sites (id)
    ON DELETE CASCADE;

ALTER TABLE routing_public.site_deep_links 
  ADD CONSTRAINT site_deep_links_site_id_slug_key 
    UNIQUE (site_id, slug);

ALTER TABLE routing_public.site_deep_links 
  ADD CONSTRAINT site_deep_links_web_path_fallback_url_chk 
    CHECK (num_nonnulls(web_path, fallback_url) = 1);

CREATE TABLE routing_public.site_web_configs ();

ALTER TABLE routing_public.site_web_configs 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE routing_public.site_web_configs IS 'Static-site serving configuration for a site surface (index document, clean URLs, SPA fallback)';

ALTER TABLE routing_public.site_web_configs 
  ADD COLUMN id uuid;

ALTER TABLE routing_public.site_web_configs 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE routing_public.site_web_configs 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE routing_public.site_web_configs 
  ADD CONSTRAINT site_web_configs_pkey PRIMARY KEY (id);

ALTER TABLE routing_public.site_web_configs 
  ADD COLUMN created_at timestamptz;

ALTER TABLE routing_public.site_web_configs 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE routing_public.site_web_configs 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE routing_public.site_web_configs 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE INDEX site_web_configs_created_at_idx ON routing_public.site_web_configs (created_at);

CREATE INDEX site_web_configs_updated_at_idx ON routing_public.site_web_configs (updated_at);

ALTER TABLE routing_public.site_web_configs 
  ADD COLUMN site_id uuid;

ALTER TABLE routing_public.site_web_configs 
  ALTER COLUMN site_id SET NOT NULL;

COMMENT ON COLUMN routing_public.site_web_configs.site_id IS 'Site surface this serving configuration belongs to';

ALTER TABLE routing_public.site_web_configs 
  ADD COLUMN index_document text;

COMMENT ON COLUMN routing_public.site_web_configs.index_document IS 'Default object served for directory-style requests (e.g. index.html; NULL = gateway default)';

ALTER TABLE routing_public.site_web_configs 
  ADD COLUMN clean_urls boolean;

COMMENT ON COLUMN routing_public.site_web_configs.clean_urls IS 'Resolve extensionless paths to .html / index.html objects (NULL = gateway default)';

ALTER TABLE routing_public.site_web_configs 
  ADD COLUMN spa_fallback boolean;

COMMENT ON COLUMN routing_public.site_web_configs.spa_fallback IS 'Serve the index document (HTTP 200) for unmatched application deep links (NULL = gateway default)';

ALTER TABLE routing_public.site_web_configs 
  ADD COLUMN metadata jsonb;

COMMENT ON COLUMN routing_public.site_web_configs.metadata IS 'Additional serving configuration (escape hatch)';

ALTER TABLE routing_public.site_web_configs 
  ADD COLUMN database_id uuid;

ALTER TABLE routing_public.site_web_configs 
  ALTER COLUMN database_id SET NOT NULL;

COMMENT ON COLUMN routing_public.site_web_configs.database_id IS 'Database that owns this resource (database-scoped isolation)';

COMMENT ON TABLE routing_public.site_web_configs IS '@scope database
@scopeKey database_id
@scopeTier database
Static-site serving configuration for a site surface (index document, clean URLs, SPA fallback)';

CREATE INDEX site_web_configs_database_id_idx ON routing_public.site_web_configs (database_id);

ALTER TABLE routing_public.site_web_configs 
  ADD CONSTRAINT site_web_configs_site_id_fkey
    FOREIGN KEY(site_id)
    REFERENCES routing_public.sites (id)
    ON DELETE CASCADE;

ALTER TABLE routing_public.site_web_configs 
  ADD CONSTRAINT site_web_configs_site_id_key 
    UNIQUE (site_id);

CREATE TABLE routing_public.site_error_pages ();

ALTER TABLE routing_public.site_error_pages 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE routing_public.site_error_pages IS 'Custom error pages for a site surface, keyed by HTTP status code';

ALTER TABLE routing_public.site_error_pages 
  ADD COLUMN id uuid;

ALTER TABLE routing_public.site_error_pages 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE routing_public.site_error_pages 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE routing_public.site_error_pages 
  ADD CONSTRAINT site_error_pages_pkey PRIMARY KEY (id);

ALTER TABLE routing_public.site_error_pages 
  ADD COLUMN created_at timestamptz;

ALTER TABLE routing_public.site_error_pages 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE routing_public.site_error_pages 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE routing_public.site_error_pages 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE INDEX site_error_pages_created_at_idx ON routing_public.site_error_pages (created_at);

CREATE INDEX site_error_pages_updated_at_idx ON routing_public.site_error_pages (updated_at);

ALTER TABLE routing_public.site_error_pages 
  ADD COLUMN site_id uuid;

ALTER TABLE routing_public.site_error_pages 
  ALTER COLUMN site_id SET NOT NULL;

COMMENT ON COLUMN routing_public.site_error_pages.site_id IS 'Site surface this error page belongs to';

ALTER TABLE routing_public.site_error_pages 
  ADD COLUMN status_code int;

ALTER TABLE routing_public.site_error_pages 
  ALTER COLUMN status_code SET NOT NULL;

COMMENT ON COLUMN routing_public.site_error_pages.status_code IS 'HTTP status code this custom page is served for (e.g. 404)';

ALTER TABLE routing_public.site_error_pages 
  ADD COLUMN object_path text;

ALTER TABLE routing_public.site_error_pages 
  ALTER COLUMN object_path SET NOT NULL;

COMMENT ON COLUMN routing_public.site_error_pages.object_path IS 'Bucket object served for this status code (original status is preserved)';

ALTER TABLE routing_public.site_error_pages 
  ADD COLUMN database_id uuid;

ALTER TABLE routing_public.site_error_pages 
  ALTER COLUMN database_id SET NOT NULL;

COMMENT ON COLUMN routing_public.site_error_pages.database_id IS 'Database that owns this resource (database-scoped isolation)';

COMMENT ON TABLE routing_public.site_error_pages IS '@scope database
@scopeKey database_id
@scopeTier database
Custom error pages for a site surface, keyed by HTTP status code';

CREATE INDEX site_error_pages_database_id_idx ON routing_public.site_error_pages (database_id);

ALTER TABLE routing_public.site_error_pages 
  ADD CONSTRAINT site_error_pages_site_id_fkey
    FOREIGN KEY(site_id)
    REFERENCES routing_public.sites (id)
    ON DELETE CASCADE;

ALTER TABLE routing_public.site_error_pages 
  ADD CONSTRAINT site_error_pages_site_id_status_code_key 
    UNIQUE (site_id, status_code);

CREATE TRIGGER catalog_sync
  AFTER INSERT OR UPDATE
  ON routing_public.sites
  FOR EACH ROW
  EXECUTE PROCEDURE catalog_private.tg_sites_catalog_sync();

CREATE TRIGGER catalog_del
  AFTER DELETE
  ON routing_public.sites
  FOR EACH ROW
  EXECUTE PROCEDURE catalog_private.tg_sites_catalog_del();

CREATE TRIGGER catalog_sync
  AFTER INSERT OR UPDATE
  ON routing_public.site_web_configs
  FOR EACH ROW
  EXECUTE PROCEDURE catalog_private.tg_site_web_configs_catalog_sync();

CREATE TRIGGER catalog_del
  AFTER DELETE
  ON routing_public.site_web_configs
  FOR EACH ROW
  EXECUTE PROCEDURE catalog_private.tg_site_web_configs_catalog_del();

CREATE TRIGGER catalog_sync
  AFTER INSERT OR UPDATE
  ON routing_public.site_error_pages
  FOR EACH ROW
  EXECUTE PROCEDURE catalog_private.tg_site_error_pages_catalog_sync();

CREATE TRIGGER catalog_del
  AFTER DELETE
  ON routing_public.site_error_pages
  FOR EACH ROW
  EXECUTE PROCEDURE catalog_private.tg_site_error_pages_catalog_del();

CREATE TRIGGER catalog_sync
  AFTER INSERT OR UPDATE
  ON routing_public.site_app_links
  FOR EACH ROW
  EXECUTE PROCEDURE catalog_private.tg_site_app_links_catalog_sync();

CREATE TRIGGER catalog_del
  AFTER DELETE
  ON routing_public.site_app_links
  FOR EACH ROW
  EXECUTE PROCEDURE catalog_private.tg_site_app_links_catalog_del();

CREATE TRIGGER catalog_sync
  AFTER INSERT OR UPDATE
  ON routing_public.site_deep_links
  FOR EACH ROW
  EXECUTE PROCEDURE catalog_private.tg_site_deep_links_catalog_sync();

CREATE TRIGGER catalog_del
  AFTER DELETE
  ON routing_public.site_deep_links
  FOR EACH ROW
  EXECUTE PROCEDURE catalog_private.tg_site_deep_links_catalog_del();

GRANT SELECT ON routing_public.sites TO authenticated;

GRANT INSERT ON routing_public.sites TO authenticated;

GRANT UPDATE ON routing_public.sites TO authenticated;

GRANT DELETE ON routing_public.sites TO authenticated;

GRANT SELECT ON routing_public.site_metadata TO authenticated;

GRANT INSERT ON routing_public.site_metadata TO authenticated;

GRANT UPDATE ON routing_public.site_metadata TO authenticated;

GRANT DELETE ON routing_public.site_metadata TO authenticated;

GRANT SELECT ON routing_public.site_modules TO authenticated;

GRANT INSERT ON routing_public.site_modules TO authenticated;

GRANT UPDATE ON routing_public.site_modules TO authenticated;

GRANT DELETE ON routing_public.site_modules TO authenticated;

GRANT SELECT ON routing_public.site_themes TO authenticated;

GRANT INSERT ON routing_public.site_themes TO authenticated;

GRANT UPDATE ON routing_public.site_themes TO authenticated;

GRANT DELETE ON routing_public.site_themes TO authenticated;

GRANT SELECT ON routing_public.site_app_links TO authenticated;

GRANT INSERT ON routing_public.site_app_links TO authenticated;

GRANT UPDATE ON routing_public.site_app_links TO authenticated;

GRANT DELETE ON routing_public.site_app_links TO authenticated;

GRANT SELECT ON routing_public.site_deep_links TO authenticated;

GRANT INSERT ON routing_public.site_deep_links TO authenticated;

GRANT UPDATE ON routing_public.site_deep_links TO authenticated;

GRANT DELETE ON routing_public.site_deep_links TO authenticated;

GRANT SELECT ON routing_public.site_web_configs TO authenticated;

GRANT INSERT ON routing_public.site_web_configs TO authenticated;

GRANT UPDATE ON routing_public.site_web_configs TO authenticated;

GRANT DELETE ON routing_public.site_web_configs TO authenticated;

GRANT SELECT ON routing_public.site_error_pages TO authenticated;

GRANT INSERT ON routing_public.site_error_pages TO authenticated;

GRANT UPDATE ON routing_public.site_error_pages TO authenticated;

GRANT DELETE ON routing_public.site_error_pages TO authenticated;

CREATE TABLE routing_public.database_settings ();

ALTER TABLE routing_public.database_settings 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE routing_public.database_settings IS 'Scope-wide feature flags and settings; controls which platform features are available to all APIs in this scope';

ALTER TABLE routing_public.database_settings 
  ADD COLUMN id uuid;

ALTER TABLE routing_public.database_settings 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE routing_public.database_settings 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE routing_public.database_settings 
  ADD CONSTRAINT database_settings_pkey PRIMARY KEY (id);

ALTER TABLE routing_public.database_settings 
  ADD COLUMN created_at timestamptz;

ALTER TABLE routing_public.database_settings 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE routing_public.database_settings 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE routing_public.database_settings 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE INDEX database_settings_created_at_idx ON routing_public.database_settings (created_at);

CREATE INDEX database_settings_updated_at_idx ON routing_public.database_settings (updated_at);

ALTER TABLE routing_public.database_settings 
  ADD COLUMN enable_aggregates boolean;

ALTER TABLE routing_public.database_settings 
  ALTER COLUMN enable_aggregates SET NOT NULL;

ALTER TABLE routing_public.database_settings 
  ALTER COLUMN enable_aggregates SET DEFAULT false;

COMMENT ON COLUMN routing_public.database_settings.enable_aggregates IS 'Enable aggregate queries (sum, avg, min, max, etc.) in the GraphQL API';

ALTER TABLE routing_public.database_settings 
  ADD COLUMN enable_postgis boolean;

ALTER TABLE routing_public.database_settings 
  ALTER COLUMN enable_postgis SET NOT NULL;

ALTER TABLE routing_public.database_settings 
  ALTER COLUMN enable_postgis SET DEFAULT true;

COMMENT ON COLUMN routing_public.database_settings.enable_postgis IS 'Enable PostGIS spatial types and operators in the GraphQL API';

ALTER TABLE routing_public.database_settings 
  ADD COLUMN enable_search boolean;

ALTER TABLE routing_public.database_settings 
  ALTER COLUMN enable_search SET NOT NULL;

ALTER TABLE routing_public.database_settings 
  ALTER COLUMN enable_search SET DEFAULT true;

COMMENT ON COLUMN routing_public.database_settings.enable_search IS 'Enable unified search (tsvector, BM25, pg_trgm, pgvector) in the GraphQL API';

ALTER TABLE routing_public.database_settings 
  ADD COLUMN enable_direct_uploads boolean;

ALTER TABLE routing_public.database_settings 
  ALTER COLUMN enable_direct_uploads SET NOT NULL;

ALTER TABLE routing_public.database_settings 
  ALTER COLUMN enable_direct_uploads SET DEFAULT true;

COMMENT ON COLUMN routing_public.database_settings.enable_direct_uploads IS 'Enable direct (multipart) file upload mutations in the GraphQL API';

ALTER TABLE routing_public.database_settings 
  ADD COLUMN enable_presigned_uploads boolean;

ALTER TABLE routing_public.database_settings 
  ALTER COLUMN enable_presigned_uploads SET NOT NULL;

ALTER TABLE routing_public.database_settings 
  ALTER COLUMN enable_presigned_uploads SET DEFAULT true;

COMMENT ON COLUMN routing_public.database_settings.enable_presigned_uploads IS 'Enable presigned URL upload flow for S3/MinIO storage';

ALTER TABLE routing_public.database_settings 
  ADD COLUMN enable_many_to_many boolean;

ALTER TABLE routing_public.database_settings 
  ALTER COLUMN enable_many_to_many SET NOT NULL;

ALTER TABLE routing_public.database_settings 
  ALTER COLUMN enable_many_to_many SET DEFAULT true;

COMMENT ON COLUMN routing_public.database_settings.enable_many_to_many IS 'Enable many-to-many relationship queries in the GraphQL API';

ALTER TABLE routing_public.database_settings 
  ADD COLUMN enable_connection_filter boolean;

ALTER TABLE routing_public.database_settings 
  ALTER COLUMN enable_connection_filter SET NOT NULL;

ALTER TABLE routing_public.database_settings 
  ALTER COLUMN enable_connection_filter SET DEFAULT true;

COMMENT ON COLUMN routing_public.database_settings.enable_connection_filter IS 'Enable connection filter (where argument) in the GraphQL API';

ALTER TABLE routing_public.database_settings 
  ADD COLUMN enable_ltree boolean;

ALTER TABLE routing_public.database_settings 
  ALTER COLUMN enable_ltree SET NOT NULL;

ALTER TABLE routing_public.database_settings 
  ALTER COLUMN enable_ltree SET DEFAULT true;

COMMENT ON COLUMN routing_public.database_settings.enable_ltree IS 'Enable ltree hierarchical data type support in the GraphQL API';

ALTER TABLE routing_public.database_settings 
  ADD COLUMN enable_llm boolean;

ALTER TABLE routing_public.database_settings 
  ALTER COLUMN enable_llm SET NOT NULL;

ALTER TABLE routing_public.database_settings 
  ALTER COLUMN enable_llm SET DEFAULT false;

COMMENT ON COLUMN routing_public.database_settings.enable_llm IS 'Enable LLM/AI integration features in the GraphQL API';

ALTER TABLE routing_public.database_settings 
  ADD COLUMN enable_realtime boolean;

ALTER TABLE routing_public.database_settings 
  ALTER COLUMN enable_realtime SET NOT NULL;

ALTER TABLE routing_public.database_settings 
  ALTER COLUMN enable_realtime SET DEFAULT false;

COMMENT ON COLUMN routing_public.database_settings.enable_realtime IS 'Enable realtime subscriptions (cursor-tracked change delivery) in the GraphQL API';

ALTER TABLE routing_public.database_settings 
  ADD COLUMN enable_bulk boolean;

ALTER TABLE routing_public.database_settings 
  ALTER COLUMN enable_bulk SET NOT NULL;

ALTER TABLE routing_public.database_settings 
  ALTER COLUMN enable_bulk SET DEFAULT false;

COMMENT ON COLUMN routing_public.database_settings.enable_bulk IS 'Enable bulk mutation operations (insert, upsert, update, delete) in the GraphQL API';

ALTER TABLE routing_public.database_settings 
  ADD COLUMN enable_i18n boolean;

ALTER TABLE routing_public.database_settings 
  ALTER COLUMN enable_i18n SET NOT NULL;

ALTER TABLE routing_public.database_settings 
  ALTER COLUMN enable_i18n SET DEFAULT false;

COMMENT ON COLUMN routing_public.database_settings.enable_i18n IS 'Enable internationalization plugin (localeStrings field, translation table discovery) in the GraphQL API';

ALTER TABLE routing_public.database_settings 
  ADD COLUMN statement_timeout_ms bigint;

COMMENT ON COLUMN routing_public.database_settings.statement_timeout_ms IS 'Scope-wide default GraphQL statement timeout in milliseconds; NULL inherits the platform default. Clamped by the plan cap at read time.';

ALTER TABLE routing_public.database_settings 
  ADD COLUMN options jsonb;

ALTER TABLE routing_public.database_settings 
  ALTER COLUMN options SET NOT NULL;

ALTER TABLE routing_public.database_settings 
  ALTER COLUMN options SET DEFAULT '{}'::jsonb;

COMMENT ON COLUMN routing_public.database_settings.options IS 'Extensible JSON for additional settings that do not have dedicated columns';

ALTER TABLE routing_public.database_settings 
  ADD COLUMN labels jsonb;

ALTER TABLE routing_public.database_settings 
  ALTER COLUMN labels SET NOT NULL;

ALTER TABLE routing_public.database_settings 
  ALTER COLUMN labels SET DEFAULT '{}'::jsonb;

COMMENT ON COLUMN routing_public.database_settings.labels IS 'Key/value pairs for selecting and filtering settings';

ALTER TABLE routing_public.database_settings 
  ADD COLUMN annotations jsonb;

ALTER TABLE routing_public.database_settings 
  ALTER COLUMN annotations SET NOT NULL;

ALTER TABLE routing_public.database_settings 
  ALTER COLUMN annotations SET DEFAULT '{}'::jsonb;

COMMENT ON COLUMN routing_public.database_settings.annotations IS 'Freeform metadata for tooling and operational notes';

ALTER TABLE routing_public.database_settings 
  ADD COLUMN database_id uuid;

ALTER TABLE routing_public.database_settings 
  ALTER COLUMN database_id SET NOT NULL;

COMMENT ON COLUMN routing_public.database_settings.database_id IS 'Database that owns this resource (database-scoped isolation)';

COMMENT ON TABLE routing_public.database_settings IS '@scope database
@scopeKey database_id
@scopeTier database
Scope-wide feature flags and settings; controls which platform features are available to all APIs in this scope';

ALTER TABLE routing_public.database_settings 
  ADD CONSTRAINT database_settings_database_id_key 
    UNIQUE (database_id);

CREATE TABLE routing_public.rls_settings ();

ALTER TABLE routing_public.rls_settings 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE routing_public.rls_settings IS 'RLS module runtime configuration; typed references to the authenticate/current_role function plumbing';

ALTER TABLE routing_public.rls_settings 
  ADD COLUMN id uuid;

ALTER TABLE routing_public.rls_settings 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE routing_public.rls_settings 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE routing_public.rls_settings 
  ADD CONSTRAINT rls_settings_pkey PRIMARY KEY (id);

ALTER TABLE routing_public.rls_settings 
  ADD COLUMN created_at timestamptz;

ALTER TABLE routing_public.rls_settings 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE routing_public.rls_settings 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE routing_public.rls_settings 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE INDEX rls_settings_created_at_idx ON routing_public.rls_settings (created_at);

CREATE INDEX rls_settings_updated_at_idx ON routing_public.rls_settings (updated_at);

ALTER TABLE routing_public.rls_settings 
  ADD COLUMN authenticate_schema_id uuid;

COMMENT ON COLUMN routing_public.rls_settings.authenticate_schema_id IS 'Schema containing authenticate/authenticate_strict functions (FK to metaschema_public.schema)';

ALTER TABLE routing_public.rls_settings 
  ADD COLUMN role_schema_id uuid;

COMMENT ON COLUMN routing_public.rls_settings.role_schema_id IS 'Schema containing current_role and related functions (FK to metaschema_public.schema)';

ALTER TABLE routing_public.rls_settings 
  ADD COLUMN authenticate_function_id uuid;

COMMENT ON COLUMN routing_public.rls_settings.authenticate_function_id IS 'Reference to the authenticate function (FK to metaschema_public.function)';

ALTER TABLE routing_public.rls_settings 
  ADD COLUMN authenticate_strict_function_id uuid;

COMMENT ON COLUMN routing_public.rls_settings.authenticate_strict_function_id IS 'Reference to the strict authenticate function (FK to metaschema_public.function)';

ALTER TABLE routing_public.rls_settings 
  ADD COLUMN current_role_function_id uuid;

COMMENT ON COLUMN routing_public.rls_settings.current_role_function_id IS 'Reference to the current_role function (FK to metaschema_public.function)';

ALTER TABLE routing_public.rls_settings 
  ADD COLUMN current_role_id_function_id uuid;

COMMENT ON COLUMN routing_public.rls_settings.current_role_id_function_id IS 'Reference to the current_role_id function (FK to metaschema_public.function)';

ALTER TABLE routing_public.rls_settings 
  ADD COLUMN current_user_agent_function_id uuid;

COMMENT ON COLUMN routing_public.rls_settings.current_user_agent_function_id IS 'Reference to the current_user_agent function (FK to metaschema_public.function)';

ALTER TABLE routing_public.rls_settings 
  ADD COLUMN current_ip_address_function_id uuid;

COMMENT ON COLUMN routing_public.rls_settings.current_ip_address_function_id IS 'Reference to the current_ip_address function (FK to metaschema_public.function)';

ALTER TABLE routing_public.rls_settings 
  ADD COLUMN database_id uuid;

ALTER TABLE routing_public.rls_settings 
  ALTER COLUMN database_id SET NOT NULL;

COMMENT ON COLUMN routing_public.rls_settings.database_id IS 'Database that owns this resource (database-scoped isolation)';

COMMENT ON TABLE routing_public.rls_settings IS '@scope database
@scopeKey database_id
@scopeTier database
RLS module runtime configuration; typed references to the authenticate/current_role function plumbing';

ALTER TABLE routing_public.rls_settings 
  ADD CONSTRAINT rls_settings_database_id_key 
    UNIQUE (database_id);

CREATE TABLE routing_public.pubkey_settings ();

ALTER TABLE routing_public.pubkey_settings 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE routing_public.pubkey_settings IS 'Public-key crypto auth runtime configuration; typed references to the crypto sign-up/sign-in function plumbing';

ALTER TABLE routing_public.pubkey_settings 
  ADD COLUMN id uuid;

ALTER TABLE routing_public.pubkey_settings 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE routing_public.pubkey_settings 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE routing_public.pubkey_settings 
  ADD CONSTRAINT pubkey_settings_pkey PRIMARY KEY (id);

ALTER TABLE routing_public.pubkey_settings 
  ADD COLUMN created_at timestamptz;

ALTER TABLE routing_public.pubkey_settings 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE routing_public.pubkey_settings 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE routing_public.pubkey_settings 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE INDEX pubkey_settings_created_at_idx ON routing_public.pubkey_settings (created_at);

CREATE INDEX pubkey_settings_updated_at_idx ON routing_public.pubkey_settings (updated_at);

ALTER TABLE routing_public.pubkey_settings 
  ADD COLUMN crypto_network text;

ALTER TABLE routing_public.pubkey_settings 
  ALTER COLUMN crypto_network SET NOT NULL;

ALTER TABLE routing_public.pubkey_settings 
  ALTER COLUMN crypto_network SET DEFAULT 'cosmos';

COMMENT ON COLUMN routing_public.pubkey_settings.crypto_network IS 'Crypto network for key derivation (e.g. cosmos, ethereum)';

ALTER TABLE routing_public.pubkey_settings 
  ADD COLUMN user_field text;

ALTER TABLE routing_public.pubkey_settings 
  ALTER COLUMN user_field SET NOT NULL;

ALTER TABLE routing_public.pubkey_settings 
  ALTER COLUMN user_field SET DEFAULT 'user_id';

COMMENT ON COLUMN routing_public.pubkey_settings.user_field IS 'Field name used to identify the user in crypto auth functions';

ALTER TABLE routing_public.pubkey_settings 
  ADD COLUMN schema_id uuid;

COMMENT ON COLUMN routing_public.pubkey_settings.schema_id IS 'Schema containing the crypto auth functions (FK to metaschema_public.schema)';

ALTER TABLE routing_public.pubkey_settings 
  ADD COLUMN sign_up_with_key_function_id uuid;

COMMENT ON COLUMN routing_public.pubkey_settings.sign_up_with_key_function_id IS 'Reference to the sign-up-with-key function (FK to metaschema_public.function)';

ALTER TABLE routing_public.pubkey_settings 
  ADD COLUMN sign_in_request_challenge_function_id uuid;

COMMENT ON COLUMN routing_public.pubkey_settings.sign_in_request_challenge_function_id IS 'Reference to the sign-in challenge request function (FK to metaschema_public.function)';

ALTER TABLE routing_public.pubkey_settings 
  ADD COLUMN sign_in_record_failure_function_id uuid;

COMMENT ON COLUMN routing_public.pubkey_settings.sign_in_record_failure_function_id IS 'Reference to the sign-in failure recording function (FK to metaschema_public.function)';

ALTER TABLE routing_public.pubkey_settings 
  ADD COLUMN sign_in_with_challenge_function_id uuid;

COMMENT ON COLUMN routing_public.pubkey_settings.sign_in_with_challenge_function_id IS 'Reference to the sign-in-with-challenge function (FK to metaschema_public.function)';

ALTER TABLE routing_public.pubkey_settings 
  ADD COLUMN database_id uuid;

ALTER TABLE routing_public.pubkey_settings 
  ALTER COLUMN database_id SET NOT NULL;

COMMENT ON COLUMN routing_public.pubkey_settings.database_id IS 'Database that owns this resource (database-scoped isolation)';

COMMENT ON TABLE routing_public.pubkey_settings IS '@scope database
@scopeKey database_id
@scopeTier database
Public-key crypto auth runtime configuration; typed references to the crypto sign-up/sign-in function plumbing';

ALTER TABLE routing_public.pubkey_settings 
  ADD CONSTRAINT pubkey_settings_database_id_key 
    UNIQUE (database_id);

CREATE TABLE routing_public.webauthn_settings ();

ALTER TABLE routing_public.webauthn_settings 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE routing_public.webauthn_settings IS 'WebAuthn/passkey runtime configuration; relying party options and typed references to the credential/session storage';

ALTER TABLE routing_public.webauthn_settings 
  ADD COLUMN id uuid;

ALTER TABLE routing_public.webauthn_settings 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE routing_public.webauthn_settings 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE routing_public.webauthn_settings 
  ADD CONSTRAINT webauthn_settings_pkey PRIMARY KEY (id);

ALTER TABLE routing_public.webauthn_settings 
  ADD COLUMN created_at timestamptz;

ALTER TABLE routing_public.webauthn_settings 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE routing_public.webauthn_settings 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE routing_public.webauthn_settings 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE INDEX webauthn_settings_created_at_idx ON routing_public.webauthn_settings (created_at);

CREATE INDEX webauthn_settings_updated_at_idx ON routing_public.webauthn_settings (updated_at);

ALTER TABLE routing_public.webauthn_settings 
  ADD COLUMN schema_id uuid;

COMMENT ON COLUMN routing_public.webauthn_settings.schema_id IS 'Schema containing WebAuthn auth procedures (FK to metaschema_public.schema)';

ALTER TABLE routing_public.webauthn_settings 
  ADD COLUMN credentials_schema_id uuid;

COMMENT ON COLUMN routing_public.webauthn_settings.credentials_schema_id IS 'Schema of the webauthn_credentials table (FK to metaschema_public.schema)';

ALTER TABLE routing_public.webauthn_settings 
  ADD COLUMN sessions_schema_id uuid;

COMMENT ON COLUMN routing_public.webauthn_settings.sessions_schema_id IS 'Schema of the sessions table (FK to metaschema_public.schema)';

ALTER TABLE routing_public.webauthn_settings 
  ADD COLUMN session_secrets_schema_id uuid;

COMMENT ON COLUMN routing_public.webauthn_settings.session_secrets_schema_id IS 'Schema of the session_secrets table (FK to metaschema_public.schema)';

ALTER TABLE routing_public.webauthn_settings 
  ADD COLUMN credentials_table_id uuid;

COMMENT ON COLUMN routing_public.webauthn_settings.credentials_table_id IS 'Reference to the webauthn_credentials table (FK to metaschema_public.table)';

ALTER TABLE routing_public.webauthn_settings 
  ADD COLUMN sessions_table_id uuid;

COMMENT ON COLUMN routing_public.webauthn_settings.sessions_table_id IS 'Reference to the sessions table (FK to metaschema_public.table)';

ALTER TABLE routing_public.webauthn_settings 
  ADD COLUMN session_credentials_table_id uuid;

COMMENT ON COLUMN routing_public.webauthn_settings.session_credentials_table_id IS 'Reference to the session_credentials table (FK to metaschema_public.table)';

ALTER TABLE routing_public.webauthn_settings 
  ADD COLUMN session_secrets_table_id uuid;

COMMENT ON COLUMN routing_public.webauthn_settings.session_secrets_table_id IS 'Reference to the session_secrets table (FK to metaschema_public.table)';

ALTER TABLE routing_public.webauthn_settings 
  ADD COLUMN user_field_id uuid;

COMMENT ON COLUMN routing_public.webauthn_settings.user_field_id IS 'Reference to the user field on webauthn_credentials (FK to metaschema_public.field)';

ALTER TABLE routing_public.webauthn_settings 
  ADD COLUMN rp_id text;

ALTER TABLE routing_public.webauthn_settings 
  ALTER COLUMN rp_id SET NOT NULL;

ALTER TABLE routing_public.webauthn_settings 
  ALTER COLUMN rp_id SET DEFAULT '';

COMMENT ON COLUMN routing_public.webauthn_settings.rp_id IS 'WebAuthn Relying Party ID (typically the domain name)';

ALTER TABLE routing_public.webauthn_settings 
  ADD COLUMN rp_name text;

ALTER TABLE routing_public.webauthn_settings 
  ALTER COLUMN rp_name SET NOT NULL;

ALTER TABLE routing_public.webauthn_settings 
  ALTER COLUMN rp_name SET DEFAULT '';

COMMENT ON COLUMN routing_public.webauthn_settings.rp_name IS 'WebAuthn Relying Party display name';

ALTER TABLE routing_public.webauthn_settings 
  ADD COLUMN origin_allowlist text[];

ALTER TABLE routing_public.webauthn_settings 
  ALTER COLUMN origin_allowlist SET NOT NULL;

ALTER TABLE routing_public.webauthn_settings 
  ALTER COLUMN origin_allowlist SET DEFAULT CAST(ARRAY[] AS text[]);

COMMENT ON COLUMN routing_public.webauthn_settings.origin_allowlist IS 'Allowed origins for WebAuthn registration and authentication';

ALTER TABLE routing_public.webauthn_settings 
  ADD COLUMN attestation_type text;

ALTER TABLE routing_public.webauthn_settings 
  ALTER COLUMN attestation_type SET NOT NULL;

ALTER TABLE routing_public.webauthn_settings 
  ALTER COLUMN attestation_type SET DEFAULT 'none';

COMMENT ON COLUMN routing_public.webauthn_settings.attestation_type IS 'Attestation conveyance preference (none, indirect, direct, enterprise)';

ALTER TABLE routing_public.webauthn_settings 
  ADD COLUMN require_user_verification boolean;

ALTER TABLE routing_public.webauthn_settings 
  ALTER COLUMN require_user_verification SET NOT NULL;

ALTER TABLE routing_public.webauthn_settings 
  ALTER COLUMN require_user_verification SET DEFAULT false;

COMMENT ON COLUMN routing_public.webauthn_settings.require_user_verification IS 'Whether to require user verification (biometric/PIN) during auth';

ALTER TABLE routing_public.webauthn_settings 
  ADD COLUMN resident_key text;

ALTER TABLE routing_public.webauthn_settings 
  ALTER COLUMN resident_key SET NOT NULL;

ALTER TABLE routing_public.webauthn_settings 
  ALTER COLUMN resident_key SET DEFAULT 'required';

COMMENT ON COLUMN routing_public.webauthn_settings.resident_key IS 'Resident key requirement (discouraged, preferred, required)';

ALTER TABLE routing_public.webauthn_settings 
  ADD COLUMN challenge_expiry_seconds bigint;

ALTER TABLE routing_public.webauthn_settings 
  ALTER COLUMN challenge_expiry_seconds SET NOT NULL;

ALTER TABLE routing_public.webauthn_settings 
  ALTER COLUMN challenge_expiry_seconds SET DEFAULT 300;

COMMENT ON COLUMN routing_public.webauthn_settings.challenge_expiry_seconds IS 'Challenge TTL in seconds (default 300 = 5 minutes)';

ALTER TABLE routing_public.webauthn_settings 
  ADD CONSTRAINT webauthn_settings_attestation_type_chk 
    CHECK (attestation_type IN ('none', 'indirect', 'direct', 'enterprise'));

ALTER TABLE routing_public.webauthn_settings 
  ADD CONSTRAINT webauthn_settings_resident_key_chk 
    CHECK (resident_key IN ('discouraged', 'preferred', 'required'));

ALTER TABLE routing_public.webauthn_settings 
  ADD COLUMN database_id uuid;

ALTER TABLE routing_public.webauthn_settings 
  ALTER COLUMN database_id SET NOT NULL;

COMMENT ON COLUMN routing_public.webauthn_settings.database_id IS 'Database that owns this resource (database-scoped isolation)';

COMMENT ON TABLE routing_public.webauthn_settings IS '@scope database
@scopeKey database_id
@scopeTier database
WebAuthn/passkey runtime configuration; relying party options and typed references to the credential/session storage';

ALTER TABLE routing_public.webauthn_settings 
  ADD CONSTRAINT webauthn_settings_database_id_key 
    UNIQUE (database_id);

GRANT SELECT ON routing_public.database_settings TO authenticated;

GRANT INSERT ON routing_public.database_settings TO authenticated;

GRANT UPDATE ON routing_public.database_settings TO authenticated;

GRANT DELETE ON routing_public.database_settings TO authenticated;

GRANT SELECT ON routing_public.rls_settings TO authenticated;

GRANT INSERT ON routing_public.rls_settings TO authenticated;

GRANT UPDATE ON routing_public.rls_settings TO authenticated;

GRANT DELETE ON routing_public.rls_settings TO authenticated;

GRANT SELECT ON routing_public.pubkey_settings TO authenticated;

GRANT INSERT ON routing_public.pubkey_settings TO authenticated;

GRANT UPDATE ON routing_public.pubkey_settings TO authenticated;

GRANT DELETE ON routing_public.pubkey_settings TO authenticated;

GRANT SELECT ON routing_public.webauthn_settings TO authenticated;

GRANT INSERT ON routing_public.webauthn_settings TO authenticated;

GRANT UPDATE ON routing_public.webauthn_settings TO authenticated;

GRANT DELETE ON routing_public.webauthn_settings TO authenticated;

COMMENT ON TABLE routing_public.api_settings IS '@scope database
@scopeKey database_id
@has_guard
@scopeTier database
Per-API feature flag overrides; NULL columns inherit from database_settings';

COMMENT ON TABLE routing_public.apis IS '@scope database
@scopeKey database_id
@has_guard
@scopeTier database
API surfaces exposed by this scope; publication makes a surface bindable from other scopes';

COMMENT ON COLUMN routing_public.apis.role_name IS '@has_guard
Authenticated role the API executes as';

COMMENT ON COLUMN routing_public.apis.anon_role IS '@has_guard
Anonymous role the API executes as';

COMMENT ON TABLE routing_public.cors_settings IS '@scope database
@scopeKey database_id
@has_guard
@scopeTier database
Scope-wide and per-API CORS origin configuration; NULL api_id means scope-wide default';

COMMENT ON TABLE routing_public.database_settings IS '@scope database
@scopeKey database_id
@has_guard
@scopeTier database
Scope-wide feature flags and settings; controls which platform features are available to all APIs in this scope';

COMMENT ON TABLE routing_public.domains IS '@scope database
@scopeKey database_id
@has_guard
@scopeTier database
Fully-qualified hostnames owned by this scope; each row claims its hostname globally through the catalog';

COMMENT ON COLUMN routing_public.domains.hostname IS '@has_guard
Lowercase fully-qualified hostname; wildcards use the *.parent form';

COMMENT ON COLUMN routing_public.domains.is_wildcard IS '@has_guard
Whether this hostname is a *.parent wildcard claim';

COMMENT ON COLUMN routing_public.domains.parent_hostname IS '@has_guard
Parent hostname a wildcard claim covers (example.com for *.example.com)';

COMMENT ON COLUMN routing_public.domains.managed IS '@has_guard
Whether the platform drives this hostname''s DNS verification and certificate lifecycle';

COMMENT ON TABLE routing_public.pubkey_settings IS '@scope database
@scopeKey database_id
@has_guard
@scopeTier database
Public-key crypto auth runtime configuration; typed references to the crypto sign-up/sign-in function plumbing';

COMMENT ON TABLE routing_public.rls_settings IS '@scope database
@scopeKey database_id
@has_guard
@scopeTier database
RLS module runtime configuration; typed references to the authenticate/current_role function plumbing';

COMMENT ON TABLE routing_public.webauthn_settings IS '@scope database
@scopeKey database_id
@has_guard
@scopeTier database
WebAuthn/passkey runtime configuration; relying party options and typed references to the credential/session storage';

CREATE TABLE routing_public.pages ();

ALTER TABLE routing_public.pages 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE routing_public.pages IS 'Site-owned page content — merkle-versioned head over the infra store; never a routing surface';

ALTER TABLE routing_public.pages 
  ADD COLUMN id uuid;

ALTER TABLE routing_public.pages 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE routing_public.pages 
  ALTER COLUMN id SET DEFAULT uuidv7();

COMMENT ON COLUMN routing_public.pages.id IS 'Unique page identifier';

ALTER TABLE routing_public.pages 
  ADD COLUMN database_id uuid;

ALTER TABLE routing_public.pages 
  ALTER COLUMN database_id SET NOT NULL;

COMMENT ON COLUMN routing_public.pages.database_id IS 'Database that owns this resource (database-scoped isolation)';

COMMENT ON TABLE routing_public.pages IS '@scope database
@scopeKey database_id
@scopeTier database
Site-owned page content — merkle-versioned head over the infra store; never a routing surface';

CREATE INDEX pages_database_id_idx ON routing_public.pages (database_id);

ALTER TABLE routing_public.pages 
  ADD COLUMN site_id uuid;

ALTER TABLE routing_public.pages 
  ALTER COLUMN site_id SET NOT NULL;

COMMENT ON COLUMN routing_public.pages.site_id IS 'Site surface this page belongs to; each site owns its own infra store and pages live at path [page, slug] within it';

ALTER TABLE routing_public.pages 
  ADD COLUMN slug text;

ALTER TABLE routing_public.pages 
  ALTER COLUMN slug SET NOT NULL;

COMMENT ON COLUMN routing_public.pages.slug IS 'Page slug (unique per site)';

ALTER TABLE routing_public.pages 
  ADD COLUMN content jsonb;

ALTER TABLE routing_public.pages 
  ALTER COLUMN content SET NOT NULL;

COMMENT ON COLUMN routing_public.pages.content IS 'Page content (blocks/markdown/whatever the build consumes) — the readily-cached head; history lives in the infra store';

ALTER TABLE routing_public.pages 
  ADD COLUMN created_at timestamptz;

ALTER TABLE routing_public.pages 
  ALTER COLUMN created_at SET NOT NULL;

ALTER TABLE routing_public.pages 
  ALTER COLUMN created_at SET DEFAULT CURRENT_TIMESTAMP;

COMMENT ON COLUMN routing_public.pages.created_at IS 'Timestamp of page creation';

ALTER TABLE routing_public.pages 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE routing_public.pages 
  ALTER COLUMN updated_at SET NOT NULL;

ALTER TABLE routing_public.pages 
  ALTER COLUMN updated_at SET DEFAULT CURRENT_TIMESTAMP;

COMMENT ON COLUMN routing_public.pages.updated_at IS 'Timestamp of last modification';

ALTER TABLE routing_public.pages 
  ADD CONSTRAINT pages_pkey PRIMARY KEY (id);

ALTER TABLE routing_public.pages 
  ADD CONSTRAINT pages_site_id_fkey
    FOREIGN KEY(site_id)
    REFERENCES routing_public.sites (id)
    ON DELETE CASCADE;

ALTER TABLE routing_public.pages 
  ADD CONSTRAINT pages_site_id_slug_key 
    UNIQUE (site_id, slug);

ALTER TABLE routing_public.pages 
  ADD COLUMN store_id uuid;

COMMENT ON COLUMN routing_public.pages.store_id IS 'Infra Merkle store holding this row''s history (stamped by the versioned trigger)';

ALTER TABLE routing_public.pages 
  ADD COLUMN commit_id uuid;

COMMENT ON COLUMN routing_public.pages.commit_id IS 'Infra store commit for the current content (stamped by the versioned trigger on every write)';

ALTER TABLE routing_public.site_metadata 
  ADD COLUMN store_id uuid;

COMMENT ON COLUMN routing_public.site_metadata.store_id IS 'Infra Merkle store holding this row''s history (stamped by the versioned trigger)';

ALTER TABLE routing_public.site_metadata 
  ADD COLUMN commit_id uuid;

COMMENT ON COLUMN routing_public.site_metadata.commit_id IS 'Infra store commit for the current content (stamped by the versioned trigger on every write)';

ALTER TABLE routing_public.site_themes 
  ADD COLUMN store_id uuid;

COMMENT ON COLUMN routing_public.site_themes.store_id IS 'Infra Merkle store holding this row''s history (stamped by the versioned trigger)';

ALTER TABLE routing_public.site_themes 
  ADD COLUMN commit_id uuid;

COMMENT ON COLUMN routing_public.site_themes.commit_id IS 'Infra store commit for the current content (stamped by the versioned trigger on every write)';

GRANT SELECT ON routing_public.pages TO authenticated;

GRANT INSERT ON routing_public.pages TO authenticated;

GRANT UPDATE ON routing_public.pages TO authenticated;

GRANT DELETE ON routing_public.pages TO authenticated;

CREATE TABLE routing_public.email_provider_accounts ();

ALTER TABLE routing_public.email_provider_accounts 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE routing_public.email_provider_accounts IS 'A tenant''s configured account at an email provider: provider slug, endpoint coordinates, and the NAME of the secret holding its credentials (never the credential itself)';

ALTER TABLE routing_public.email_provider_accounts 
  ADD COLUMN id uuid;

ALTER TABLE routing_public.email_provider_accounts 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE routing_public.email_provider_accounts 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE routing_public.email_provider_accounts 
  ADD CONSTRAINT email_provider_accounts_pkey PRIMARY KEY (id);

ALTER TABLE routing_public.email_provider_accounts 
  ADD COLUMN created_at timestamptz;

ALTER TABLE routing_public.email_provider_accounts 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE routing_public.email_provider_accounts 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE routing_public.email_provider_accounts 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE INDEX email_provider_accounts_created_at_idx ON routing_public.email_provider_accounts (created_at);

CREATE INDEX email_provider_accounts_updated_at_idx ON routing_public.email_provider_accounts (updated_at);

ALTER TABLE routing_public.email_provider_accounts 
  ADD COLUMN name text;

ALTER TABLE routing_public.email_provider_accounts 
  ALTER COLUMN name SET NOT NULL;

COMMENT ON COLUMN routing_public.email_provider_accounts.name IS 'Operator-facing name for this account (e.g. transactional, marketing)';

ALTER TABLE routing_public.email_provider_accounts 
  ADD COLUMN provider text;

ALTER TABLE routing_public.email_provider_accounts 
  ALTER COLUMN provider SET NOT NULL;

COMMENT ON COLUMN routing_public.email_provider_accounts.provider IS 'integration_providers.slug of the provider this account is at (mailgun, ses, postmark, smtp), matched by string not by FK';

ALTER TABLE routing_public.email_provider_accounts 
  ADD COLUMN provider_account_name text;

COMMENT ON COLUMN routing_public.email_provider_accounts.provider_account_name IS 'Account identifier at the provider — the Mailgun sending domain, the SES verified identity, the Postmark server name';

ALTER TABLE routing_public.email_provider_accounts 
  ADD COLUMN api_base_url text;

COMMENT ON COLUMN routing_public.email_provider_accounts.api_base_url IS 'Provider API base URL when it is not the provider default (e.g. Mailgun EU)';

ALTER TABLE routing_public.email_provider_accounts 
  ADD COLUMN region text;

COMMENT ON COLUMN routing_public.email_provider_accounts.region IS 'Provider region for region-addressed providers (e.g. SES us-east-1)';

ALTER TABLE routing_public.email_provider_accounts 
  ADD COLUMN smtp_host text;

COMMENT ON COLUMN routing_public.email_provider_accounts.smtp_host IS 'SMTP host (provider = smtp, or a provider addressed over SMTP)';

ALTER TABLE routing_public.email_provider_accounts 
  ADD COLUMN smtp_port int;

COMMENT ON COLUMN routing_public.email_provider_accounts.smtp_port IS 'SMTP port';

ALTER TABLE routing_public.email_provider_accounts 
  ADD COLUMN smtp_secure boolean;

COMMENT ON COLUMN routing_public.email_provider_accounts.smtp_secure IS 'Whether the SMTP connection uses implicit TLS';

ALTER TABLE routing_public.email_provider_accounts 
  ADD COLUMN smtp_user text;

COMMENT ON COLUMN routing_public.email_provider_accounts.smtp_user IS 'SMTP username; the password is a secret, addressed by credentials_secret_name';

ALTER TABLE routing_public.email_provider_accounts 
  ADD COLUMN credentials_secret_name text;

ALTER TABLE routing_public.email_provider_accounts 
  ALTER COLUMN credentials_secret_name SET NOT NULL;

COMMENT ON COLUMN routing_public.email_provider_accounts.credentials_secret_name IS 'Name of the secret holding this account''s API key or SMTP password. The value is resolved from the secret store at send time (realm = this row''s id) and is never stored here.';

ALTER TABLE routing_public.email_provider_accounts 
  ADD COLUMN webhook_signing_secret_name text;

COMMENT ON COLUMN routing_public.email_provider_accounts.webhook_signing_secret_name IS 'Name of the secret used to verify this provider''s delivery/bounce webhooks. Name only; the value stays in the secret store.';

ALTER TABLE routing_public.email_provider_accounts 
  ADD COLUMN is_active boolean;

ALTER TABLE routing_public.email_provider_accounts 
  ALTER COLUMN is_active SET NOT NULL;

ALTER TABLE routing_public.email_provider_accounts 
  ALTER COLUMN is_active SET DEFAULT true;

COMMENT ON COLUMN routing_public.email_provider_accounts.is_active IS 'Whether identities may send through this account. Disabling one row stops every identity that references it.';

ALTER TABLE routing_public.email_provider_accounts 
  ADD COLUMN database_id uuid;

ALTER TABLE routing_public.email_provider_accounts 
  ALTER COLUMN database_id SET NOT NULL;

COMMENT ON COLUMN routing_public.email_provider_accounts.database_id IS 'Database that owns this resource (database-scoped isolation)';

COMMENT ON TABLE routing_public.email_provider_accounts IS '@scope database
@scopeKey database_id
@scopeTier database
A tenant''s configured account at an email provider: provider slug, endpoint coordinates, and the NAME of the secret holding its credentials (never the credential itself)';

ALTER TABLE routing_public.email_provider_accounts 
  ADD CONSTRAINT email_provider_accounts_database_id_name_key 
    UNIQUE (database_id, name);

CREATE TABLE routing_public.email_identities ();

ALTER TABLE routing_public.email_identities 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE routing_public.email_identities IS 'Outbound sender identity: the from/reply-to/support addresses a tenant sends as, and the provider account the mail leaves through';

ALTER TABLE routing_public.email_identities 
  ADD COLUMN id uuid;

ALTER TABLE routing_public.email_identities 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE routing_public.email_identities 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE routing_public.email_identities 
  ADD CONSTRAINT email_identities_pkey PRIMARY KEY (id);

ALTER TABLE routing_public.email_identities 
  ADD COLUMN created_at timestamptz;

ALTER TABLE routing_public.email_identities 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE routing_public.email_identities 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE routing_public.email_identities 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE INDEX email_identities_created_at_idx ON routing_public.email_identities (created_at);

CREATE INDEX email_identities_updated_at_idx ON routing_public.email_identities (updated_at);

ALTER TABLE routing_public.email_identities 
  ADD COLUMN name text;

ALTER TABLE routing_public.email_identities 
  ALTER COLUMN name SET NOT NULL;

COMMENT ON COLUMN routing_public.email_identities.name IS 'Operator-facing name for this identity (e.g. transactional, support)';

ALTER TABLE routing_public.email_identities 
  ADD COLUMN provider_account_id uuid;

COMMENT ON COLUMN routing_public.email_identities.provider_account_id IS 'Same-scope provider account this identity sends through. Required for transport_mode = own, NULL for platform_shared.';

ALTER TABLE routing_public.email_identities 
  ADD COLUMN transport_mode text;

ALTER TABLE routing_public.email_identities 
  ALTER COLUMN transport_mode SET NOT NULL;

ALTER TABLE routing_public.email_identities 
  ALTER COLUMN transport_mode SET DEFAULT 'own';

COMMENT ON COLUMN routing_public.email_identities.transport_mode IS 'own = send through provider_account_id in this scope; platform_shared = send through the platform installation''s shared account, an explicit recorded choice and never an implicit fallback';

ALTER TABLE routing_public.email_identities 
  ADD COLUMN from_address text;

ALTER TABLE routing_public.email_identities 
  ALTER COLUMN from_address SET NOT NULL;

COMMENT ON COLUMN routing_public.email_identities.from_address IS 'Envelope/header From address, lower-case. Must be accepted by the sending account at the provider.';

ALTER TABLE routing_public.email_identities 
  ADD COLUMN from_name text;

COMMENT ON COLUMN routing_public.email_identities.from_name IS 'Display name shown beside the from address';

ALTER TABLE routing_public.email_identities 
  ADD COLUMN reply_to_address text;

COMMENT ON COLUMN routing_public.email_identities.reply_to_address IS 'Reply-To address when replies should not go to the from address';

ALTER TABLE routing_public.email_identities 
  ADD COLUMN support_address text;

COMMENT ON COLUMN routing_public.email_identities.support_address IS 'Support address rendered in message bodies and footers';

ALTER TABLE routing_public.email_identities 
  ADD COLUMN is_default boolean;

ALTER TABLE routing_public.email_identities 
  ALTER COLUMN is_default SET NOT NULL;

ALTER TABLE routing_public.email_identities 
  ALTER COLUMN is_default SET DEFAULT false;

COMMENT ON COLUMN routing_public.email_identities.is_default IS 'The scope default identity, used when no site binding resolves. At most one per scope key.';

ALTER TABLE routing_public.email_identities 
  ADD COLUMN is_active boolean;

ALTER TABLE routing_public.email_identities 
  ALTER COLUMN is_active SET NOT NULL;

ALTER TABLE routing_public.email_identities 
  ALTER COLUMN is_active SET DEFAULT true;

COMMENT ON COLUMN routing_public.email_identities.is_active IS 'Whether this identity may be resolved for a send';

ALTER TABLE routing_public.email_identities 
  ADD COLUMN database_id uuid;

ALTER TABLE routing_public.email_identities 
  ALTER COLUMN database_id SET NOT NULL;

COMMENT ON COLUMN routing_public.email_identities.database_id IS 'Database that owns this resource (database-scoped isolation)';

COMMENT ON TABLE routing_public.email_identities IS '@scope database
@scopeKey database_id
@scopeTier database
Outbound sender identity: the from/reply-to/support addresses a tenant sends as, and the provider account the mail leaves through';

ALTER TABLE routing_public.email_identities 
  ADD CONSTRAINT email_identities_provider_account_id_fkey
    FOREIGN KEY(provider_account_id)
    REFERENCES routing_public.email_provider_accounts (id)
    ON DELETE RESTRICT;

CREATE INDEX email_identities_provider_account_id_idx ON routing_public.email_identities (provider_account_id);

ALTER TABLE routing_public.email_identities 
  ADD CONSTRAINT email_identities_database_id_name_key 
    UNIQUE (database_id, name);

CREATE UNIQUE INDEX email_identities_database_id_is_default_idx ON routing_public.email_identities (database_id, is_default) WHERE email_identities.is_default = CAST('true' AS boolean);

ALTER TABLE routing_public.email_identities 
  ADD CONSTRAINT email_identities_transport_mode_provider_account_id_chk 
    CHECK (
    (transport_mode = 'own'
      AND provider_account_id IS NOT NULL)
      OR (transport_mode = 'platform_shared'
      AND provider_account_id IS NULL)
  );

ALTER TABLE routing_public.email_identities 
  ADD CONSTRAINT email_identities_from_address_chk 
    CHECK (
    from_address = lower(from_address)
      AND from_address ~* E'^[^@[:space:]]+@[^@[:space:]]+\\.[^@[:space:]]+$'
  );

CREATE TABLE routing_public.email_site_identities ();

ALTER TABLE routing_public.email_site_identities 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE routing_public.email_site_identities IS 'Binds a site to the identity it sends as. Unique on site_id: one identity per site, but many sites may share an identity.';

ALTER TABLE routing_public.email_site_identities 
  ADD COLUMN id uuid;

ALTER TABLE routing_public.email_site_identities 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE routing_public.email_site_identities 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE routing_public.email_site_identities 
  ADD CONSTRAINT email_site_identities_pkey PRIMARY KEY (id);

ALTER TABLE routing_public.email_site_identities 
  ADD COLUMN created_at timestamptz;

ALTER TABLE routing_public.email_site_identities 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE routing_public.email_site_identities 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE routing_public.email_site_identities 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE INDEX email_site_identities_created_at_idx ON routing_public.email_site_identities (created_at);

CREATE INDEX email_site_identities_updated_at_idx ON routing_public.email_site_identities (updated_at);

ALTER TABLE routing_public.email_site_identities 
  ADD COLUMN site_id uuid;

ALTER TABLE routing_public.email_site_identities 
  ALTER COLUMN site_id SET NOT NULL;

COMMENT ON COLUMN routing_public.email_site_identities.site_id IS 'Site whose mail is sent as the bound identity';

ALTER TABLE routing_public.email_site_identities 
  ADD COLUMN email_identity_id uuid;

ALTER TABLE routing_public.email_site_identities 
  ALTER COLUMN email_identity_id SET NOT NULL;

COMMENT ON COLUMN routing_public.email_site_identities.email_identity_id IS 'Identity this site sends as';

ALTER TABLE routing_public.email_site_identities 
  ADD COLUMN database_id uuid;

ALTER TABLE routing_public.email_site_identities 
  ALTER COLUMN database_id SET NOT NULL;

COMMENT ON COLUMN routing_public.email_site_identities.database_id IS 'Database that owns this resource (database-scoped isolation)';

COMMENT ON TABLE routing_public.email_site_identities IS '@scope database
@scopeKey database_id
@scopeTier database
Binds a site to the identity it sends as. Unique on site_id: one identity per site, but many sites may share an identity.';

ALTER TABLE routing_public.email_site_identities 
  ADD CONSTRAINT email_site_identities_site_id_fkey
    FOREIGN KEY(site_id)
    REFERENCES routing_public.sites (id)
    ON DELETE CASCADE;

ALTER TABLE routing_public.email_site_identities 
  ADD CONSTRAINT email_site_identities_email_identity_id_fkey
    FOREIGN KEY(email_identity_id)
    REFERENCES routing_public.email_identities (id)
    ON DELETE RESTRICT;

ALTER TABLE routing_public.email_site_identities 
  ADD CONSTRAINT email_site_identities_site_id_key 
    UNIQUE (site_id);

CREATE INDEX email_site_identities_email_identity_id_idx ON routing_public.email_site_identities (email_identity_id);

CREATE INDEX email_site_identities_database_id_idx ON routing_public.email_site_identities (database_id);

GRANT SELECT ON routing_public.email_provider_accounts TO authenticated;

GRANT INSERT ON routing_public.email_provider_accounts TO authenticated;

GRANT UPDATE ON routing_public.email_provider_accounts TO authenticated;

GRANT DELETE ON routing_public.email_provider_accounts TO authenticated;

GRANT SELECT ON routing_public.email_identities TO authenticated;

GRANT INSERT ON routing_public.email_identities TO authenticated;

GRANT UPDATE ON routing_public.email_identities TO authenticated;

GRANT DELETE ON routing_public.email_identities TO authenticated;

GRANT SELECT ON routing_public.email_site_identities TO authenticated;

GRANT INSERT ON routing_public.email_site_identities TO authenticated;

GRANT UPDATE ON routing_public.email_site_identities TO authenticated;

GRANT DELETE ON routing_public.email_site_identities TO authenticated;

CREATE TABLE routing_public.http_routes ();

ALTER TABLE routing_public.http_routes 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE routing_public.http_routes IS 'Request-time HTTP routing authority: registered domain plus path prefix and optional method to a typed target';

ALTER TABLE routing_public.http_routes 
  ADD COLUMN id uuid;

ALTER TABLE routing_public.http_routes 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE routing_public.http_routes 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE routing_public.http_routes 
  ADD CONSTRAINT http_routes_pkey PRIMARY KEY (id);

ALTER TABLE routing_public.http_routes 
  ADD COLUMN created_at timestamptz;

ALTER TABLE routing_public.http_routes 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE routing_public.http_routes 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE routing_public.http_routes 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE INDEX http_routes_created_at_idx ON routing_public.http_routes (created_at);

CREATE INDEX http_routes_updated_at_idx ON routing_public.http_routes (updated_at);

ALTER TABLE routing_public.http_routes 
  ADD COLUMN created_by uuid;

ALTER TABLE routing_public.http_routes 
  ADD COLUMN updated_by uuid;

CREATE INDEX http_routes_created_by_idx ON routing_public.http_routes (created_by);

CREATE INDEX http_routes_updated_by_idx ON routing_public.http_routes (updated_by);

ALTER TABLE routing_public.http_routes 
  ADD COLUMN domain_id uuid;

ALTER TABLE routing_public.http_routes 
  ALTER COLUMN domain_id SET NOT NULL;

COMMENT ON COLUMN routing_public.http_routes.domain_id IS 'Registered host in the scoped routing domains table';

ALTER TABLE routing_public.http_routes 
  ADD COLUMN path text;

ALTER TABLE routing_public.http_routes 
  ALTER COLUMN path SET NOT NULL;

ALTER TABLE routing_public.http_routes 
  ALTER COLUMN path SET DEFAULT '/';

COMMENT ON COLUMN routing_public.http_routes.path IS 'Normalized request path prefix; longest matching prefix wins';

ALTER TABLE routing_public.http_routes 
  ADD COLUMN method text;

COMMENT ON COLUMN routing_public.http_routes.method IS 'Optional uppercase HTTP method; NULL matches every method';

ALTER TABLE routing_public.http_routes 
  ADD COLUMN priority int;

ALTER TABLE routing_public.http_routes 
  ALTER COLUMN priority SET NOT NULL;

ALTER TABLE routing_public.http_routes 
  ALTER COLUMN priority SET DEFAULT 0;

COMMENT ON COLUMN routing_public.http_routes.priority IS 'Tie-break precedence after path length and method specificity';

ALTER TABLE routing_public.http_routes 
  ADD COLUMN is_active boolean;

ALTER TABLE routing_public.http_routes 
  ALTER COLUMN is_active SET NOT NULL;

ALTER TABLE routing_public.http_routes 
  ALTER COLUMN is_active SET DEFAULT true;

COMMENT ON COLUMN routing_public.http_routes.is_active IS 'Whether the resolver may select this route';

ALTER TABLE routing_public.http_routes 
  ADD COLUMN target_kind text;

ALTER TABLE routing_public.http_routes 
  ALTER COLUMN target_kind SET NOT NULL;

COMMENT ON COLUMN routing_public.http_routes.target_kind IS 'Discriminator selecting the type of target_id';

ALTER TABLE routing_public.http_routes 
  ADD COLUMN target_id uuid;

ALTER TABLE routing_public.http_routes 
  ALTER COLUMN target_id SET NOT NULL;

COMMENT ON COLUMN routing_public.http_routes.target_id IS 'Target row of the type named by target_kind; existence enforced by trigger';

ALTER TABLE routing_public.http_routes 
  ADD COLUMN database_id uuid;

ALTER TABLE routing_public.http_routes 
  ALTER COLUMN database_id SET NOT NULL;

COMMENT ON COLUMN routing_public.http_routes.database_id IS 'Database that owns this resource (database-scoped isolation)';

COMMENT ON TABLE routing_public.http_routes IS '@scope database
@scopeKey database_id
@scopeTier database
Request-time HTTP routing authority: registered domain plus path prefix and optional method to a typed target';

CREATE INDEX http_routes_database_id_idx ON routing_public.http_routes (database_id);

ALTER TABLE routing_public.http_routes 
  ADD CONSTRAINT http_routes_domain_id_fkey
    FOREIGN KEY(domain_id)
    REFERENCES routing_public.domains (id)
    ON DELETE CASCADE;

CREATE INDEX http_routes_domain_id_path_method_is_active_idx ON routing_public.http_routes (domain_id, path, method, is_active);

ALTER TABLE routing_public.http_routes 
  ADD CONSTRAINT http_routes_path_chk 
    CHECK (
    "left"(path, 1) = '/'
      AND (path = '/'
      OR "right"(path, 1) <> '/')
  );

ALTER TABLE routing_public.http_routes 
  ADD CONSTRAINT http_routes_method_chk 
    CHECK (
    method IS NULL
      OR method = upper(method)
  );

ALTER TABLE routing_public.http_routes 
  ADD CONSTRAINT http_routes_target_kind_chk 
    CHECK (target_kind IN ('api', 'site', 'function', 'bucket', 'service'));

GRANT SELECT ON routing_public.http_routes TO authenticated;

GRANT INSERT ON routing_public.http_routes TO authenticated;

GRANT UPDATE ON routing_public.http_routes TO authenticated;

GRANT DELETE ON routing_public.http_routes TO authenticated;

CREATE TABLE routing_public.routes ();

ALTER TABLE routing_public.routes 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE routing_public.routes IS 'Routes binding a domain hostname and path to a typed catalog target';

ALTER TABLE routing_public.routes 
  ADD COLUMN id uuid;

ALTER TABLE routing_public.routes 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE routing_public.routes 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE routing_public.routes 
  ADD CONSTRAINT routes_pkey PRIMARY KEY (id);

ALTER TABLE routing_public.routes 
  ADD COLUMN created_at timestamptz;

ALTER TABLE routing_public.routes 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE routing_public.routes 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE routing_public.routes 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE INDEX routes_created_at_idx ON routing_public.routes (created_at);

CREATE INDEX routes_updated_at_idx ON routing_public.routes (updated_at);

ALTER TABLE routing_public.routes 
  ADD COLUMN domain_id uuid;

ALTER TABLE routing_public.routes 
  ALTER COLUMN domain_id SET NOT NULL;

COMMENT ON COLUMN routing_public.routes.domain_id IS 'Domain whose hostname this route serves';

ALTER TABLE routing_public.routes 
  ADD COLUMN target_api_id uuid;

COMMENT ON COLUMN routing_public.routes.target_api_id IS 'Api catalog row this route targets; must be owner-matched or visible cross-scope';

ALTER TABLE routing_public.routes 
  ADD COLUMN target_site_id uuid;

COMMENT ON COLUMN routing_public.routes.target_site_id IS 'Site catalog row this route targets; must be owner-matched or visible cross-scope';

ALTER TABLE routing_public.routes 
  ADD COLUMN target_function_id uuid;

COMMENT ON COLUMN routing_public.routes.target_function_id IS 'Function catalog row this route targets; must be owner-matched or visible cross-scope';

ALTER TABLE routing_public.routes 
  ADD COLUMN target_service_id uuid;

COMMENT ON COLUMN routing_public.routes.target_service_id IS 'Resource catalog row (a Service resource) this route targets; must be owner-matched or visible cross-scope';

ALTER TABLE routing_public.routes 
  ADD COLUMN target_bucket_id uuid;

COMMENT ON COLUMN routing_public.routes.target_bucket_id IS 'Bucket catalog row this route targets; must be a public bucket that is owner-matched or visible cross-scope';

ALTER TABLE routing_public.routes 
  ADD COLUMN path text;

ALTER TABLE routing_public.routes 
  ALTER COLUMN path SET NOT NULL;

ALTER TABLE routing_public.routes 
  ALTER COLUMN path SET DEFAULT '/';

COMMENT ON COLUMN routing_public.routes.path IS 'Path prefix this route matches; must begin with / and carry no trailing slash';

ALTER TABLE routing_public.routes 
  ADD COLUMN method text;

COMMENT ON COLUMN routing_public.routes.method IS 'Uppercase HTTP method this route matches; NULL matches any method';

ALTER TABLE routing_public.routes 
  ADD COLUMN priority int;

ALTER TABLE routing_public.routes 
  ALTER COLUMN priority SET NOT NULL;

ALTER TABLE routing_public.routes 
  ALTER COLUMN priority SET DEFAULT 0;

COMMENT ON COLUMN routing_public.routes.priority IS 'Higher priority wins between otherwise-equal matches';

ALTER TABLE routing_public.routes 
  ADD COLUMN is_active boolean;

ALTER TABLE routing_public.routes 
  ALTER COLUMN is_active SET NOT NULL;

ALTER TABLE routing_public.routes 
  ALTER COLUMN is_active SET DEFAULT true;

COMMENT ON COLUMN routing_public.routes.is_active IS 'Inactive routes are excluded from resolution';

ALTER TABLE routing_public.routes 
  ADD COLUMN config jsonb;

COMMENT ON COLUMN routing_public.routes.config IS 'Route metadata; target configuration is read live from the typed catalog, never copied here';

ALTER TABLE routing_public.routes 
  ADD COLUMN database_id uuid;

ALTER TABLE routing_public.routes 
  ALTER COLUMN database_id SET NOT NULL;

COMMENT ON COLUMN routing_public.routes.database_id IS 'Database that owns this resource (database-scoped isolation)';

COMMENT ON TABLE routing_public.routes IS '@scope database
@scopeKey database_id
@scopeTier database
Routes binding a domain hostname and path to a typed catalog target';

CREATE INDEX routes_database_id_idx ON routing_public.routes (database_id);

ALTER TABLE routing_public.routes 
  ADD CONSTRAINT routes_domain_id_fkey
    FOREIGN KEY(domain_id)
    REFERENCES routing_public.domains (id)
    ON DELETE CASCADE;

ALTER TABLE routing_public.routes 
  ADD CONSTRAINT routes_target_api_id_fkey
    FOREIGN KEY(target_api_id)
    REFERENCES catalog_private.apis (id)
    ON DELETE CASCADE;

ALTER TABLE routing_public.routes 
  ADD CONSTRAINT routes_target_site_id_fkey
    FOREIGN KEY(target_site_id)
    REFERENCES catalog_private.sites (id)
    ON DELETE CASCADE;

ALTER TABLE routing_public.routes 
  ADD CONSTRAINT routes_target_service_id_fkey
    FOREIGN KEY(target_service_id)
    REFERENCES catalog_private.resources (id)
    ON DELETE CASCADE;

ALTER TABLE routing_public.routes 
  ADD CONSTRAINT routes_target_bucket_id_fkey
    FOREIGN KEY(target_bucket_id)
    REFERENCES catalog_private.buckets (id)
    ON DELETE CASCADE;

ALTER TABLE routing_public.routes 
  ADD CONSTRAINT routes_target_api_id_target_site_id_target_function_id_target_s 
    CHECK (num_nonnulls(target_api_id, target_site_id, target_function_id, target_service_id, target_bucket_id) = 1);

ALTER TABLE routing_public.routes 
  ADD CONSTRAINT routes_domain_id_path_method_key 
    UNIQUE (domain_id, path, method);

CREATE INDEX routes_domain_id_path_method_is_active_idx ON routing_public.routes (domain_id, path, method, is_active);

ALTER TABLE routing_public.routes 
  ADD CONSTRAINT routes_path_chk 
    CHECK (
    "left"(path, 1) = '/'
      AND (path = '/'
      OR "right"(path, 1) <> '/')
  );

ALTER TABLE routing_public.routes 
  ADD CONSTRAINT routes_method_chk 
    CHECK (
    method IS NULL
      OR method = upper(method)
  );

CREATE TABLE routing_public.hostname_bindings ();

ALTER TABLE routing_public.hostname_bindings 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE routing_public.hostname_bindings IS 'Compiled hostname index maintained by domain sync triggers; read only through the resolver';

ALTER TABLE routing_public.hostname_bindings 
  ADD COLUMN id uuid;

ALTER TABLE routing_public.hostname_bindings 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE routing_public.hostname_bindings 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE routing_public.hostname_bindings 
  ADD CONSTRAINT hostname_bindings_pkey PRIMARY KEY (id);

ALTER TABLE routing_public.hostname_bindings 
  ADD COLUMN hostname text;

ALTER TABLE routing_public.hostname_bindings 
  ALTER COLUMN hostname SET NOT NULL;

COMMENT ON COLUMN routing_public.hostname_bindings.hostname IS 'Lowercase hostname (exact or *.parent wildcard)';

ALTER TABLE routing_public.hostname_bindings 
  ADD COLUMN domain_id uuid;

ALTER TABLE routing_public.hostname_bindings 
  ALTER COLUMN domain_id SET NOT NULL;

COMMENT ON COLUMN routing_public.hostname_bindings.domain_id IS 'Domain row this binding was compiled from';

ALTER TABLE routing_public.hostname_bindings 
  ADD COLUMN is_wildcard boolean;

ALTER TABLE routing_public.hostname_bindings 
  ALTER COLUMN is_wildcard SET NOT NULL;

ALTER TABLE routing_public.hostname_bindings 
  ALTER COLUMN is_wildcard SET DEFAULT false;

COMMENT ON COLUMN routing_public.hostname_bindings.is_wildcard IS 'Whether this binding is a wildcard claim';

ALTER TABLE routing_public.hostname_bindings 
  ADD COLUMN parent_hostname text;

COMMENT ON COLUMN routing_public.hostname_bindings.parent_hostname IS 'Parent hostname a wildcard binding covers';

ALTER TABLE routing_public.hostname_bindings 
  ADD COLUMN managed boolean;

ALTER TABLE routing_public.hostname_bindings 
  ALTER COLUMN managed SET NOT NULL;

ALTER TABLE routing_public.hostname_bindings 
  ALTER COLUMN managed SET DEFAULT false;

COMMENT ON COLUMN routing_public.hostname_bindings.managed IS 'Whether the platform drives this hostname''s lifecycle';

ALTER TABLE routing_public.hostname_bindings 
  ADD COLUMN verification_status text;

COMMENT ON COLUMN routing_public.hostname_bindings.verification_status IS 'Ownership verification state compiled from the domain row';

ALTER TABLE routing_public.hostname_bindings 
  ADD COLUMN tls_status text;

COMMENT ON COLUMN routing_public.hostname_bindings.tls_status IS 'Certificate lifecycle state compiled from the domain row';

ALTER TABLE routing_public.hostname_bindings 
  ADD COLUMN tls_secret_name text;

COMMENT ON COLUMN routing_public.hostname_bindings.tls_secret_name IS 'TLS secret name compiled from the domain row';

ALTER TABLE routing_public.hostname_bindings 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE routing_public.hostname_bindings 
  ALTER COLUMN updated_at SET NOT NULL;

ALTER TABLE routing_public.hostname_bindings 
  ALTER COLUMN updated_at SET DEFAULT now();

COMMENT ON COLUMN routing_public.hostname_bindings.updated_at IS 'When this binding was last recompiled';

ALTER TABLE routing_public.hostname_bindings 
  ADD CONSTRAINT hostname_bindings_hostname_key 
    UNIQUE (hostname);

CREATE INDEX hostname_bindings_domain_id_idx ON routing_public.hostname_bindings (domain_id);

CREATE INDEX hostname_bindings_parent_hostname_is_wildcard_idx ON routing_public.hostname_bindings (parent_hostname, is_wildcard);

CREATE TABLE routing_public.route_bindings ();

ALTER TABLE routing_public.route_bindings 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE routing_public.route_bindings IS 'Compiled route precedence index maintained by route sync triggers; carries typed target ids only, read through the resolver';

ALTER TABLE routing_public.route_bindings 
  ADD COLUMN id uuid;

ALTER TABLE routing_public.route_bindings 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE routing_public.route_bindings 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE routing_public.route_bindings 
  ADD CONSTRAINT route_bindings_pkey PRIMARY KEY (id);

ALTER TABLE routing_public.route_bindings 
  ADD COLUMN domain_id uuid;

ALTER TABLE routing_public.route_bindings 
  ALTER COLUMN domain_id SET NOT NULL;

COMMENT ON COLUMN routing_public.route_bindings.domain_id IS 'Domain row the source route binds';

ALTER TABLE routing_public.route_bindings 
  ADD COLUMN target_api_id uuid;

COMMENT ON COLUMN routing_public.route_bindings.target_api_id IS 'Api catalog row the source route targets';

ALTER TABLE routing_public.route_bindings 
  ADD COLUMN target_site_id uuid;

COMMENT ON COLUMN routing_public.route_bindings.target_site_id IS 'Site catalog row the source route targets';

ALTER TABLE routing_public.route_bindings 
  ADD COLUMN target_function_id uuid;

COMMENT ON COLUMN routing_public.route_bindings.target_function_id IS 'Function catalog row the source route targets';

ALTER TABLE routing_public.route_bindings 
  ADD COLUMN target_service_id uuid;

COMMENT ON COLUMN routing_public.route_bindings.target_service_id IS 'Resource catalog row (a Service resource) the source route targets';

ALTER TABLE routing_public.route_bindings 
  ADD COLUMN target_bucket_id uuid;

COMMENT ON COLUMN routing_public.route_bindings.target_bucket_id IS 'Bucket catalog row the source route targets';

ALTER TABLE routing_public.route_bindings 
  ADD COLUMN path text;

ALTER TABLE routing_public.route_bindings 
  ALTER COLUMN path SET NOT NULL;

COMMENT ON COLUMN routing_public.route_bindings.path IS 'Path prefix this binding matches';

ALTER TABLE routing_public.route_bindings 
  ADD COLUMN method text;

COMMENT ON COLUMN routing_public.route_bindings.method IS 'HTTP method this binding matches; NULL matches any method';

ALTER TABLE routing_public.route_bindings 
  ADD COLUMN priority int;

ALTER TABLE routing_public.route_bindings 
  ALTER COLUMN priority SET NOT NULL;

ALTER TABLE routing_public.route_bindings 
  ALTER COLUMN priority SET DEFAULT 0;

COMMENT ON COLUMN routing_public.route_bindings.priority IS 'Priority compiled from the source route';

ALTER TABLE routing_public.route_bindings 
  ADD COLUMN is_active boolean;

ALTER TABLE routing_public.route_bindings 
  ALTER COLUMN is_active SET NOT NULL;

ALTER TABLE routing_public.route_bindings 
  ALTER COLUMN is_active SET DEFAULT true;

COMMENT ON COLUMN routing_public.route_bindings.is_active IS 'Active flag compiled from the source route';

ALTER TABLE routing_public.route_bindings 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE routing_public.route_bindings 
  ALTER COLUMN updated_at SET NOT NULL;

ALTER TABLE routing_public.route_bindings 
  ALTER COLUMN updated_at SET DEFAULT now();

COMMENT ON COLUMN routing_public.route_bindings.updated_at IS 'When this binding was last recompiled';

CREATE INDEX route_bindings_domain_id_is_active_idx ON routing_public.route_bindings (domain_id, is_active);

CREATE FUNCTION routing_public.api_schema_names(
  target_api_id uuid
) RETURNS jsonb AS $EOFCODE$BEGIN
  RETURN COALESCE((SELECT jsonb_agg(sc.schema_name)
    FROM routing_public.api_schemas AS aps, metaschema_public.schema AS sc
    WHERE
      sc.id = aps.schema_id
      AND aps.api_id = target_api_id
      AND sc.schema_name IS NOT NULL), '[]'::jsonb);
END$EOFCODE$ LANGUAGE plpgsql STABLE SECURITY DEFINER;

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
  OUT serving_lane text,
  OUT target_source_id uuid,
  OUT target_owner_scope text,
  OUT target_owner_key uuid,
  OUT resolved_config jsonb,
  OUT verification_status text,
  OUT tls_status text,
  OUT tls_secret_name text
) RETURNS record AS $EOFCODE$
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
CASE 
    WHEN rb.target_bucket_id IS NOT NULL THEN 'static' 
    WHEN rb.target_site_id IS NOT NULL AND s.bucket_id IS NOT NULL THEN 'static' 
    WHEN rb.target_site_id IS NOT NULL AND s.resource_id IS NOT NULL THEN 'service' 
    WHEN rb.target_api_id IS NOT NULL THEN 'service' 
    WHEN rb.target_function_id IS NOT NULL THEN 'service' 
    WHEN rb.target_service_id IS NOT NULL THEN 'service' 
  END AS serving_lane,
  COALESCE(a.id, s.id, f.id, res.id, b.id) AS target_source_id,
  COALESCE(a.owner_scope, s.owner_scope, f.owner_scope, res.owner_scope, b.owner_scope) AS target_owner_scope,
  COALESCE(a.owner_key, s.owner_key, f.owner_key, res.owner_key, b.owner_key) AS target_owner_key,
CASE 
    WHEN rb.target_api_id IS NOT NULL THEN ((COALESCE(a.config, '{}'::jsonb)) || jsonb_strip_nulls(jsonb_build_object('name', a.name, 'dbname', a.dbname, 'role_name', a.role_name, 'anon_role', a.anon_role, 'api_id', a.id, 'database_id', a.database_id))) || jsonb_build_object('schemas', "routing_public".api_schema_names(a.id)) 
    WHEN rb.target_site_id IS NOT NULL THEN CASE 
      WHEN s.bucket_id IS NOT NULL THEN jsonb_strip_nulls(jsonb_build_object('site_id', s.id, 'name', s.name, 'backing', 'bucket', 'bucket_id', sb.id, 'bucket_key', sb.key, 'bucket_type', sb.type, 'physical_name', sb.physical_name, 'database_id', sb.database_id, 'index_document', swc.index_document, 'clean_urls', swc.clean_urls, 'spa_fallback', swc.spa_fallback, 'not_found_path', sep.object_path)) 
      WHEN s.resource_id IS NOT NULL THEN jsonb_strip_nulls(jsonb_build_object('site_id', s.id, 'name', s.name, 'backing', 'resource', 'resource_id', sres.id, 'namespace_id', sres.namespace_id, 'kind', sres.kind, 'slug', sres.slug)) 
      WHEN s.installation_id IS NOT NULL THEN jsonb_strip_nulls(jsonb_build_object('site_id', s.id, 'name', s.name, 'backing', 'installation', 'installation_id', s.installation_id, 'installation_member_slug', s.installation_member_slug)) 
    END 
    WHEN rb.target_function_id IS NOT NULL THEN jsonb_strip_nulls(jsonb_build_object('task_identifier', f.task_identifier)) 
    WHEN rb.target_service_id IS NOT NULL THEN jsonb_strip_nulls(jsonb_build_object('namespace_id', res.namespace_id, 'kind', res.kind, 'slug', res.slug)) 
    WHEN rb.target_bucket_id IS NOT NULL THEN jsonb_strip_nulls(jsonb_build_object('bucket_id', b.id, 'bucket_key', b.key, 'bucket_type', b.type, 'physical_name', b.physical_name, 'database_id', b.database_id)) 
  END AS resolved_config,
  hb.verification_status AS verification_status,
  hb.tls_status AS tls_status,
  hb.tls_secret_name AS tls_secret_name
FROM "routing_public".hostname_bindings AS hb INNER JOIN "routing_public".route_bindings AS rb ON rb.domain_id = hb.domain_id LEFT OUTER JOIN "catalog_private".apis AS a ON a.id = rb.target_api_id LEFT OUTER JOIN "catalog_private".sites AS s ON s.id = rb.target_site_id LEFT OUTER JOIN "catalog_private".functions AS f ON f.id = rb.target_function_id LEFT OUTER JOIN "catalog_private".resources AS res ON res.id = rb.target_service_id LEFT OUTER JOIN "catalog_private".buckets AS b ON b.id = rb.target_bucket_id LEFT OUTER JOIN "routing_public".routes AS r ON r.id = rb.id LEFT OUTER JOIN "catalog_private".buckets AS sb ON sb.id = s.bucket_id LEFT OUTER JOIN "catalog_private".resources AS sres ON sres.id = s.resource_id LEFT OUTER JOIN "catalog_private".sites_web_config AS swc ON swc.site_id = s.id LEFT OUTER JOIN "catalog_private".sites_error_pages AS sep ON sep.site_id = s.id AND sep.status_code = 404
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
$EOFCODE$ LANGUAGE sql STABLE SECURITY DEFINER;

GRANT SELECT ON routing_public.routes TO authenticated;

GRANT INSERT ON routing_public.routes TO authenticated;

GRANT UPDATE ON routing_public.routes TO authenticated;

GRANT DELETE ON routing_public.routes TO authenticated;

COMMENT ON TABLE routing_public.routes IS '@scope database
@scopeKey database_id
@has_guard
@scopeTier database
Routes binding a domain hostname and path to a typed catalog target';

COMMENT ON COLUMN routing_public.routes.domain_id IS '@has_guard
Domain whose hostname this route serves';

COMMENT ON COLUMN routing_public.routes.target_api_id IS '@has_guard
Api catalog row this route targets; must be owner-matched or visible cross-scope';

COMMENT ON COLUMN routing_public.routes.target_site_id IS '@has_guard
Site catalog row this route targets; must be owner-matched or visible cross-scope';

COMMENT ON COLUMN routing_public.routes.target_function_id IS '@has_guard
Function catalog row this route targets; must be owner-matched or visible cross-scope';

COMMENT ON COLUMN routing_public.routes.path IS '@has_guard
Path prefix this route matches; must begin with / and carry no trailing slash';

COMMENT ON COLUMN routing_public.routes.method IS '@has_guard
Uppercase HTTP method this route matches; NULL matches any method';