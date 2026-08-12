-- Deploy: schemas/routing_public/tables/platform_email_identities/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_email_identities/table


COMMENT ON TABLE routing_public.platform_email_identities IS '@scope platform
@scopeTier global
Outbound sender identity: the from/reply-to/support addresses a tenant sends as, and the provider account the mail leaves through';