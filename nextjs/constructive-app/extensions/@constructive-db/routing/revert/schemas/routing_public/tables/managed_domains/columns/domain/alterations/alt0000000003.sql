-- Revert: schemas/routing_public/tables/managed_domains/columns/domain/alterations/alt0000000003


ALTER TABLE routing_public.managed_domains 
  DROP CONSTRAINT managed_domains_domain_chk RESTRICT;