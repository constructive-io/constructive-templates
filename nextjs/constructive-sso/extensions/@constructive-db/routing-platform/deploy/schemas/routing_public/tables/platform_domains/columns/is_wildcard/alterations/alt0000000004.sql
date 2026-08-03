-- Deploy: schemas/routing_public/tables/platform_domains/columns/is_wildcard/alterations/alt0000000004
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_domains/table
-- requires: schemas/routing_public/tables/platform_domains/columns/hostname/column
-- requires: schemas/routing_public/tables/platform_domains/columns/is_wildcard/column
-- requires: schemas/routing_public/tables/platform_domains/columns/parent_hostname/column


ALTER TABLE routing_public.platform_domains 
  ADD CONSTRAINT platform_domains_is_wildcard_hostname_parent_hostname_chk 
    CHECK (
    is_wildcard = ("left"(hostname, 2) = '*.')
      AND is_wildcard = (parent_hostname IS NOT NULL)
  );