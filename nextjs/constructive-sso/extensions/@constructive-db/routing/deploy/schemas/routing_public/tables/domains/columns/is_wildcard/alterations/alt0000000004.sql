-- Deploy: schemas/routing_public/tables/domains/columns/is_wildcard/alterations/alt0000000004
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/domains/table
-- requires: schemas/routing_public/tables/domains/columns/hostname/column
-- requires: schemas/routing_public/tables/domains/columns/is_wildcard/column
-- requires: schemas/routing_public/tables/domains/columns/parent_hostname/column


ALTER TABLE routing_public.domains 
  ADD CONSTRAINT domains_is_wildcard_hostname_parent_hostname_chk 
    CHECK (
    is_wildcard = ("left"(hostname, 2) = '*.')
      AND is_wildcard = (parent_hostname IS NOT NULL)
  );