-- Deploy: schemas/routing_public/tables/domains/columns/managed/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/domains/columns/managed/column


COMMENT ON COLUMN routing_public.domains.managed IS 'Whether the platform drives this hostname''s DNS verification and certificate lifecycle';