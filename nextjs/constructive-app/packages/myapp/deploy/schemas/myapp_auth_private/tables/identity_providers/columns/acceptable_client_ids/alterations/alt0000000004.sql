-- Deploy: schemas/myapp_auth_private/tables/identity_providers/columns/acceptable_client_ids/alterations/alt0000000004
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/identity_providers/columns/acceptable_client_ids/column


COMMENT ON COLUMN myapp_auth_private.identity_providers.acceptable_client_ids IS E'@has_guard
Multi-platform audience allow-list. When non-empty, id_token ''aud'' is validated against client_id OR any value here. Used when one IdP project issues tokens with platform-specific audiences (web vs iOS vs Android).';

