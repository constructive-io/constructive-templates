-- Deploy: schemas/routing_public/tables/site_error_pages/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_error_pages/table


COMMENT ON TABLE routing_public.site_error_pages IS 'Custom error pages for a site surface, keyed by HTTP status code';