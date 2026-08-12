-- Deploy: schemas/routing_public/tables/domain_verifications/columns/record_type/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/domain_verifications/table


ALTER TABLE routing_public.domain_verifications 
  ADD COLUMN record_type text;