-- Deploy: schemas/routing_public/tables/domain_verifications/indexes/domain_verifications_managed_domain_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/domain_verifications/table
-- requires: schemas/routing_public/tables/domain_verifications/columns/managed_domain_id/column


CREATE INDEX domain_verifications_managed_domain_id_idx ON routing_public.domain_verifications (managed_domain_id);