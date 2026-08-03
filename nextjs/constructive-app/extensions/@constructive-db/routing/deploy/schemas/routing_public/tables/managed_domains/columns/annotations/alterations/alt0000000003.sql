-- Deploy: schemas/routing_public/tables/managed_domains/columns/annotations/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/managed_domains/columns/annotations/column


COMMENT ON COLUMN routing_public.managed_domains.annotations IS 'Free-form operator annotations for this managed hostname';