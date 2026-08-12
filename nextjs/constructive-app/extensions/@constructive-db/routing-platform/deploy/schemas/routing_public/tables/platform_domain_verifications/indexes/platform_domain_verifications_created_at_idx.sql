-- Deploy: schemas/routing_public/tables/platform_domain_verifications/indexes/platform_domain_verifications_created_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_domain_verifications/table
-- requires: schemas/routing_public/tables/platform_domain_verifications/columns/created_at/column


CREATE INDEX platform_domain_verifications_created_at_idx ON routing_public.platform_domain_verifications (created_at);