-- Revert: schemas/routing_public/tables/email_identities/grants/authenticated/select/grant


REVOKE SELECT ON routing_public.email_identities FROM authenticated RESTRICT;