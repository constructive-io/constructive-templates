# React Query Hooks

<p align="center" width="100%">
  <img height="120" src="https://raw.githubusercontent.com/constructive-io/constructive/refs/heads/main/assets/outline-logo.svg" />
</p>

<!-- @constructive-io/graphql-codegen - DO NOT EDIT -->

## Setup

```typescript
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { configure } from './hooks';

configure({
  endpoint: 'https://api.example.com/graphql',
  headers: { Authorization: 'Bearer <token>' },
});

const queryClient = new QueryClient();

function App() {
  return (
    <QueryClientProvider client={queryClient}>
      <YourApp />
    </QueryClientProvider>
  );
}
```

## Hooks

| Hook | Type | Description |
|------|------|-------------|
| `useOrgGetManagersQuery` | Query | List all orgGetManagers |
| `useCreateOrgGetManagersRecordMutation` | Mutation | Create a orgGetManagersRecord |
| `useOrgGetSubordinatesQuery` | Query | List all orgGetSubordinates |
| `useCreateOrgGetSubordinatesRecordMutation` | Mutation | Create a orgGetSubordinatesRecord |
| `useAppPermissionsQuery` | Query | Defines available permissions as named bits within a bitmask, used by the RBAC system for access control |
| `useAppPermissionQuery` | Query | Defines available permissions as named bits within a bitmask, used by the RBAC system for access control |
| `useCreateAppPermissionMutation` | Mutation | Defines available permissions as named bits within a bitmask, used by the RBAC system for access control |
| `useUpdateAppPermissionMutation` | Mutation | Defines available permissions as named bits within a bitmask, used by the RBAC system for access control |
| `useDeleteAppPermissionMutation` | Mutation | Defines available permissions as named bits within a bitmask, used by the RBAC system for access control |
| `useAppPermissionDefaultGrantsQuery` | Query | Audit log of permission additions and removals from the defaults bitmask |
| `useAppPermissionDefaultGrantQuery` | Query | Audit log of permission additions and removals from the defaults bitmask |
| `useCreateAppPermissionDefaultGrantMutation` | Mutation | Audit log of permission additions and removals from the defaults bitmask |
| `useUpdateAppPermissionDefaultGrantMutation` | Mutation | Audit log of permission additions and removals from the defaults bitmask |
| `useDeleteAppPermissionDefaultGrantMutation` | Mutation | Audit log of permission additions and removals from the defaults bitmask |
| `useAppMembershipsQuery` | Query | Tracks membership records linking actors to entities with permission bitmasks, ownership, and admin status |
| `useAppMembershipQuery` | Query | Tracks membership records linking actors to entities with permission bitmasks, ownership, and admin status |
| `useCreateAppMembershipMutation` | Mutation | Tracks membership records linking actors to entities with permission bitmasks, ownership, and admin status |
| `useUpdateAppMembershipMutation` | Mutation | Tracks membership records linking actors to entities with permission bitmasks, ownership, and admin status |
| `useDeleteAppMembershipMutation` | Mutation | Tracks membership records linking actors to entities with permission bitmasks, ownership, and admin status |
| `useAppProfilePermissionsQuery` | Query | Join table linking profiles to individual permissions they include |
| `useAppProfilePermissionQuery` | Query | Join table linking profiles to individual permissions they include |
| `useCreateAppProfilePermissionMutation` | Mutation | Join table linking profiles to individual permissions they include |
| `useUpdateAppProfilePermissionMutation` | Mutation | Join table linking profiles to individual permissions they include |
| `useDeleteAppProfilePermissionMutation` | Mutation | Join table linking profiles to individual permissions they include |
| `useAppProfileGrantsQuery` | Query | Audit log of profile assignments and revocations for members |
| `useAppProfileGrantQuery` | Query | Audit log of profile assignments and revocations for members |
| `useCreateAppProfileGrantMutation` | Mutation | Audit log of profile assignments and revocations for members |
| `useUpdateAppProfileGrantMutation` | Mutation | Audit log of profile assignments and revocations for members |
| `useDeleteAppProfileGrantMutation` | Mutation | Audit log of profile assignments and revocations for members |
| `useAppProfileDefinitionGrantsQuery` | Query | Audit log of permission additions and removals from profile definitions |
| `useAppProfileDefinitionGrantQuery` | Query | Audit log of permission additions and removals from profile definitions |
| `useCreateAppProfileDefinitionGrantMutation` | Mutation | Audit log of permission additions and removals from profile definitions |
| `useUpdateAppProfileDefinitionGrantMutation` | Mutation | Audit log of permission additions and removals from profile definitions |
| `useDeleteAppProfileDefinitionGrantMutation` | Mutation | Audit log of permission additions and removals from profile definitions |
| `useAppInvitesQuery` | Query | Invitation records sent to prospective members via email, with token-based redemption and expiration |
| `useAppInviteQuery` | Query | Invitation records sent to prospective members via email, with token-based redemption and expiration |
| `useCreateAppInviteMutation` | Mutation | Invitation records sent to prospective members via email, with token-based redemption and expiration |
| `useUpdateAppInviteMutation` | Mutation | Invitation records sent to prospective members via email, with token-based redemption and expiration |
| `useDeleteAppInviteMutation` | Mutation | Invitation records sent to prospective members via email, with token-based redemption and expiration |
| `useAppAdminGrantsQuery` | Query | Records of admin role grants and revocations between members |
| `useAppAdminGrantQuery` | Query | Records of admin role grants and revocations between members |
| `useCreateAppAdminGrantMutation` | Mutation | Records of admin role grants and revocations between members |
| `useUpdateAppAdminGrantMutation` | Mutation | Records of admin role grants and revocations between members |
| `useDeleteAppAdminGrantMutation` | Mutation | Records of admin role grants and revocations between members |
| `useAppOwnerGrantsQuery` | Query | Records of ownership transfers and grants between members |
| `useAppOwnerGrantQuery` | Query | Records of ownership transfers and grants between members |
| `useCreateAppOwnerGrantMutation` | Mutation | Records of ownership transfers and grants between members |
| `useUpdateAppOwnerGrantMutation` | Mutation | Records of ownership transfers and grants between members |
| `useDeleteAppOwnerGrantMutation` | Mutation | Records of ownership transfers and grants between members |
| `useAppGrantsQuery` | Query | Records of individual permission grants and revocations for members via bitmask |
| `useAppGrantQuery` | Query | Records of individual permission grants and revocations for members via bitmask |
| `useCreateAppGrantMutation` | Mutation | Records of individual permission grants and revocations for members via bitmask |
| `useUpdateAppGrantMutation` | Mutation | Records of individual permission grants and revocations for members via bitmask |
| `useDeleteAppGrantMutation` | Mutation | Records of individual permission grants and revocations for members via bitmask |
| `useOrgMembershipsQuery` | Query | Tracks membership records linking actors to entities with permission bitmasks, ownership, and admin status |
| `useOrgMembershipQuery` | Query | Tracks membership records linking actors to entities with permission bitmasks, ownership, and admin status |
| `useCreateOrgMembershipMutation` | Mutation | Tracks membership records linking actors to entities with permission bitmasks, ownership, and admin status |
| `useUpdateOrgMembershipMutation` | Mutation | Tracks membership records linking actors to entities with permission bitmasks, ownership, and admin status |
| `useDeleteOrgMembershipMutation` | Mutation | Tracks membership records linking actors to entities with permission bitmasks, ownership, and admin status |
| `useOrgProfilePermissionsQuery` | Query | Join table linking profiles to individual permissions they include |
| `useOrgProfilePermissionQuery` | Query | Join table linking profiles to individual permissions they include |
| `useCreateOrgProfilePermissionMutation` | Mutation | Join table linking profiles to individual permissions they include |
| `useUpdateOrgProfilePermissionMutation` | Mutation | Join table linking profiles to individual permissions they include |
| `useDeleteOrgProfilePermissionMutation` | Mutation | Join table linking profiles to individual permissions they include |
| `useOrgPermissionDefaultPermissionsQuery` | Query | Join table linking permission defaults to individual permissions; recompute trigger rebuilds the defaults bitmask |
| `useOrgPermissionDefaultPermissionQuery` | Query | Join table linking permission defaults to individual permissions; recompute trigger rebuilds the defaults bitmask |
| `useCreateOrgPermissionDefaultPermissionMutation` | Mutation | Join table linking permission defaults to individual permissions; recompute trigger rebuilds the defaults bitmask |
| `useUpdateOrgPermissionDefaultPermissionMutation` | Mutation | Join table linking permission defaults to individual permissions; recompute trigger rebuilds the defaults bitmask |
| `useDeleteOrgPermissionDefaultPermissionMutation` | Mutation | Join table linking permission defaults to individual permissions; recompute trigger rebuilds the defaults bitmask |
| `useOrgPermissionDefaultGrantsQuery` | Query | Audit log of permission additions and removals from the defaults bitmask |
| `useOrgPermissionDefaultGrantQuery` | Query | Audit log of permission additions and removals from the defaults bitmask |
| `useCreateOrgPermissionDefaultGrantMutation` | Mutation | Audit log of permission additions and removals from the defaults bitmask |
| `useUpdateOrgPermissionDefaultGrantMutation` | Mutation | Audit log of permission additions and removals from the defaults bitmask |
| `useDeleteOrgPermissionDefaultGrantMutation` | Mutation | Audit log of permission additions and removals from the defaults bitmask |
| `useOrgProfileDefinitionGrantsQuery` | Query | Audit log of permission additions and removals from profile definitions |
| `useOrgProfileDefinitionGrantQuery` | Query | Audit log of permission additions and removals from profile definitions |
| `useCreateOrgProfileDefinitionGrantMutation` | Mutation | Audit log of permission additions and removals from profile definitions |
| `useUpdateOrgProfileDefinitionGrantMutation` | Mutation | Audit log of permission additions and removals from profile definitions |
| `useDeleteOrgProfileDefinitionGrantMutation` | Mutation | Audit log of permission additions and removals from profile definitions |
| `useOrgProfileGrantsQuery` | Query | Audit log of profile assignments and revocations for members |
| `useOrgProfileGrantQuery` | Query | Audit log of profile assignments and revocations for members |
| `useCreateOrgProfileGrantMutation` | Mutation | Audit log of profile assignments and revocations for members |
| `useUpdateOrgProfileGrantMutation` | Mutation | Audit log of profile assignments and revocations for members |
| `useDeleteOrgProfileGrantMutation` | Mutation | Audit log of profile assignments and revocations for members |
| `useOrgInvitesQuery` | Query | Invitation records sent to prospective members via email, with token-based redemption and expiration |
| `useOrgInviteQuery` | Query | Invitation records sent to prospective members via email, with token-based redemption and expiration |
| `useCreateOrgInviteMutation` | Mutation | Invitation records sent to prospective members via email, with token-based redemption and expiration |
| `useUpdateOrgInviteMutation` | Mutation | Invitation records sent to prospective members via email, with token-based redemption and expiration |
| `useDeleteOrgInviteMutation` | Mutation | Invitation records sent to prospective members via email, with token-based redemption and expiration |
| `useOrgMembersQuery` | Query | Simplified view of active members in an entity, used for listing who belongs to an org or group |
| `useOrgMemberQuery` | Query | Simplified view of active members in an entity, used for listing who belongs to an org or group |
| `useCreateOrgMemberMutation` | Mutation | Simplified view of active members in an entity, used for listing who belongs to an org or group |
| `useUpdateOrgMemberMutation` | Mutation | Simplified view of active members in an entity, used for listing who belongs to an org or group |
| `useDeleteOrgMemberMutation` | Mutation | Simplified view of active members in an entity, used for listing who belongs to an org or group |
| `useOrgAdminGrantsQuery` | Query | Records of admin role grants and revocations between members |
| `useOrgAdminGrantQuery` | Query | Records of admin role grants and revocations between members |
| `useCreateOrgAdminGrantMutation` | Mutation | Records of admin role grants and revocations between members |
| `useUpdateOrgAdminGrantMutation` | Mutation | Records of admin role grants and revocations between members |
| `useDeleteOrgAdminGrantMutation` | Mutation | Records of admin role grants and revocations between members |
| `useOrgOwnerGrantsQuery` | Query | Records of ownership transfers and grants between members |
| `useOrgOwnerGrantQuery` | Query | Records of ownership transfers and grants between members |
| `useCreateOrgOwnerGrantMutation` | Mutation | Records of ownership transfers and grants between members |
| `useUpdateOrgOwnerGrantMutation` | Mutation | Records of ownership transfers and grants between members |
| `useDeleteOrgOwnerGrantMutation` | Mutation | Records of ownership transfers and grants between members |
| `useOrgMemberProfilesQuery` | Query | Per-membership profile information visible to other entity members (display name, email, title, bio, avatar) |
| `useOrgMemberProfileQuery` | Query | Per-membership profile information visible to other entity members (display name, email, title, bio, avatar) |
| `useCreateOrgMemberProfileMutation` | Mutation | Per-membership profile information visible to other entity members (display name, email, title, bio, avatar) |
| `useUpdateOrgMemberProfileMutation` | Mutation | Per-membership profile information visible to other entity members (display name, email, title, bio, avatar) |
| `useDeleteOrgMemberProfileMutation` | Mutation | Per-membership profile information visible to other entity members (display name, email, title, bio, avatar) |
| `useOrgGrantsQuery` | Query | Records of individual permission grants and revocations for members via bitmask |
| `useOrgGrantQuery` | Query | Records of individual permission grants and revocations for members via bitmask |
| `useCreateOrgGrantMutation` | Mutation | Records of individual permission grants and revocations for members via bitmask |
| `useUpdateOrgGrantMutation` | Mutation | Records of individual permission grants and revocations for members via bitmask |
| `useDeleteOrgGrantMutation` | Mutation | Records of individual permission grants and revocations for members via bitmask |
| `useOrgChartEdgesQuery` | Query | Organizational chart edges defining parent-child reporting relationships between members within an entity |
| `useOrgChartEdgeQuery` | Query | Organizational chart edges defining parent-child reporting relationships between members within an entity |
| `useCreateOrgChartEdgeMutation` | Mutation | Organizational chart edges defining parent-child reporting relationships between members within an entity |
| `useUpdateOrgChartEdgeMutation` | Mutation | Organizational chart edges defining parent-child reporting relationships between members within an entity |
| `useDeleteOrgChartEdgeMutation` | Mutation | Organizational chart edges defining parent-child reporting relationships between members within an entity |
| `useOrgChartEdgeGrantsQuery` | Query | Append-only log of hierarchy edge grants and revocations; triggers apply changes to the edges table |
| `useOrgChartEdgeGrantQuery` | Query | Append-only log of hierarchy edge grants and revocations; triggers apply changes to the edges table |
| `useCreateOrgChartEdgeGrantMutation` | Mutation | Append-only log of hierarchy edge grants and revocations; triggers apply changes to the edges table |
| `useUpdateOrgChartEdgeGrantMutation` | Mutation | Append-only log of hierarchy edge grants and revocations; triggers apply changes to the edges table |
| `useDeleteOrgChartEdgeGrantMutation` | Mutation | Append-only log of hierarchy edge grants and revocations; triggers apply changes to the edges table |
| `useOrgPermissionDefaultsQuery` | Query | Stores the default permission bitmask assigned to new members upon joining |
| `useOrgPermissionDefaultQuery` | Query | Stores the default permission bitmask assigned to new members upon joining |
| `useCreateOrgPermissionDefaultMutation` | Mutation | Stores the default permission bitmask assigned to new members upon joining |
| `useUpdateOrgPermissionDefaultMutation` | Mutation | Stores the default permission bitmask assigned to new members upon joining |
| `useDeleteOrgPermissionDefaultMutation` | Mutation | Stores the default permission bitmask assigned to new members upon joining |
| `useAppLimitsQuery` | Query | Tracks per-actor usage counts against configurable maximum limits |
| `useAppLimitQuery` | Query | Tracks per-actor usage counts against configurable maximum limits |
| `useCreateAppLimitMutation` | Mutation | Tracks per-actor usage counts against configurable maximum limits |
| `useUpdateAppLimitMutation` | Mutation | Tracks per-actor usage counts against configurable maximum limits |
| `useDeleteAppLimitMutation` | Mutation | Tracks per-actor usage counts against configurable maximum limits |
| `useAppLimitCreditsQuery` | Query | Append-only ledger of credit grants that automatically update limit ceilings |
| `useAppLimitCreditQuery` | Query | Append-only ledger of credit grants that automatically update limit ceilings |
| `useCreateAppLimitCreditMutation` | Mutation | Append-only ledger of credit grants that automatically update limit ceilings |
| `useUpdateAppLimitCreditMutation` | Mutation | Append-only ledger of credit grants that automatically update limit ceilings |
| `useDeleteAppLimitCreditMutation` | Mutation | Append-only ledger of credit grants that automatically update limit ceilings |
| `useAppLimitCreditCodeItemsQuery` | Query | Items within a credit code — each row grants credits for a specific limit definition |
| `useAppLimitCreditCodeItemQuery` | Query | Items within a credit code — each row grants credits for a specific limit definition |
| `useCreateAppLimitCreditCodeItemMutation` | Mutation | Items within a credit code — each row grants credits for a specific limit definition |
| `useUpdateAppLimitCreditCodeItemMutation` | Mutation | Items within a credit code — each row grants credits for a specific limit definition |
| `useDeleteAppLimitCreditCodeItemMutation` | Mutation | Items within a credit code — each row grants credits for a specific limit definition |
| `useAppLimitCreditRedemptionsQuery` | Query | Append-only ledger of code redemptions; AFTER INSERT trigger validates and cascades to limit_credits |
| `useAppLimitCreditRedemptionQuery` | Query | Append-only ledger of code redemptions; AFTER INSERT trigger validates and cascades to limit_credits |
| `useCreateAppLimitCreditRedemptionMutation` | Mutation | Append-only ledger of code redemptions; AFTER INSERT trigger validates and cascades to limit_credits |
| `useUpdateAppLimitCreditRedemptionMutation` | Mutation | Append-only ledger of code redemptions; AFTER INSERT trigger validates and cascades to limit_credits |
| `useDeleteAppLimitCreditRedemptionMutation` | Mutation | Append-only ledger of code redemptions; AFTER INSERT trigger validates and cascades to limit_credits |
| `useOrgLimitsQuery` | Query | Tracks per-actor usage counts against configurable maximum limits |
| `useOrgLimitQuery` | Query | Tracks per-actor usage counts against configurable maximum limits |
| `useCreateOrgLimitMutation` | Mutation | Tracks per-actor usage counts against configurable maximum limits |
| `useUpdateOrgLimitMutation` | Mutation | Tracks per-actor usage counts against configurable maximum limits |
| `useDeleteOrgLimitMutation` | Mutation | Tracks per-actor usage counts against configurable maximum limits |
| `useOrgLimitCreditsQuery` | Query | Append-only ledger of credit grants that automatically update limit ceilings |
| `useOrgLimitCreditQuery` | Query | Append-only ledger of credit grants that automatically update limit ceilings |
| `useCreateOrgLimitCreditMutation` | Mutation | Append-only ledger of credit grants that automatically update limit ceilings |
| `useUpdateOrgLimitCreditMutation` | Mutation | Append-only ledger of credit grants that automatically update limit ceilings |
| `useDeleteOrgLimitCreditMutation` | Mutation | Append-only ledger of credit grants that automatically update limit ceilings |
| `useOrgLimitAggregatesQuery` | Query | Tracks aggregate entity-level usage counts (org-wide caps, no per-user breakdown) |
| `useOrgLimitAggregateQuery` | Query | Tracks aggregate entity-level usage counts (org-wide caps, no per-user breakdown) |
| `useCreateOrgLimitAggregateMutation` | Mutation | Tracks aggregate entity-level usage counts (org-wide caps, no per-user breakdown) |
| `useUpdateOrgLimitAggregateMutation` | Mutation | Tracks aggregate entity-level usage counts (org-wide caps, no per-user breakdown) |
| `useDeleteOrgLimitAggregateMutation` | Mutation | Tracks aggregate entity-level usage counts (org-wide caps, no per-user breakdown) |
| `useOrgLimitWarningsQuery` | Query | Warning configuration for soft limits. Each row defines a warning threshold and the job task to enqueue when usage approaches it. |
| `useOrgLimitWarningQuery` | Query | Warning configuration for soft limits. Each row defines a warning threshold and the job task to enqueue when usage approaches it. |
| `useCreateOrgLimitWarningMutation` | Mutation | Warning configuration for soft limits. Each row defines a warning threshold and the job task to enqueue when usage approaches it. |
| `useUpdateOrgLimitWarningMutation` | Mutation | Warning configuration for soft limits. Each row defines a warning threshold and the job task to enqueue when usage approaches it. |
| `useDeleteOrgLimitWarningMutation` | Mutation | Warning configuration for soft limits. Each row defines a warning threshold and the job task to enqueue when usage approaches it. |
| `useOrgProfilesQuery` | Query | Named permission bundles (roles) that group multiple permissions into reusable profiles |
| `useOrgProfileQuery` | Query | Named permission bundles (roles) that group multiple permissions into reusable profiles |
| `useCreateOrgProfileMutation` | Mutation | Named permission bundles (roles) that group multiple permissions into reusable profiles |
| `useUpdateOrgProfileMutation` | Mutation | Named permission bundles (roles) that group multiple permissions into reusable profiles |
| `useDeleteOrgProfileMutation` | Mutation | Named permission bundles (roles) that group multiple permissions into reusable profiles |
| `usePrincipalsQuery` | Query | Scoped sub-identities (API keys and agents) with precomputed SPRT |
| `usePrincipalQuery` | Query | Scoped sub-identities (API keys and agents) with precomputed SPRT |
| `useCreatePrincipalMutation` | Mutation | Scoped sub-identities (API keys and agents) with precomputed SPRT |
| `useUpdatePrincipalMutation` | Mutation | Scoped sub-identities (API keys and agents) with precomputed SPRT |
| `useDeletePrincipalMutation` | Mutation | Scoped sub-identities (API keys and agents) with precomputed SPRT |
| `usePrincipalEntitiesQuery` | Query | Association table scoping principals to specific organizations |
| `usePrincipalEntityQuery` | Query | Association table scoping principals to specific organizations |
| `useCreatePrincipalEntityMutation` | Mutation | Association table scoping principals to specific organizations |
| `useUpdatePrincipalEntityMutation` | Mutation | Association table scoping principals to specific organizations |
| `useDeletePrincipalEntityMutation` | Mutation | Association table scoping principals to specific organizations |
| `usePrincipalScopeOverridesQuery` | Query | Per-scope permission overrides for principals. No row = full access; row exists = apply restrictions. |
| `usePrincipalScopeOverrideQuery` | Query | Per-scope permission overrides for principals. No row = full access; row exists = apply restrictions. |
| `useCreatePrincipalScopeOverrideMutation` | Mutation | Per-scope permission overrides for principals. No row = full access; row exists = apply restrictions. |
| `useUpdatePrincipalScopeOverrideMutation` | Mutation | Per-scope permission overrides for principals. No row = full access; row exists = apply restrictions. |
| `useDeletePrincipalScopeOverrideMutation` | Mutation | Per-scope permission overrides for principals. No row = full access; row exists = apply restrictions. |
| `useEmailsQuery` | Query | User email addresses with verification and primary-email management |
| `useEmailQuery` | Query | User email addresses with verification and primary-email management |
| `useCreateEmailMutation` | Mutation | User email addresses with verification and primary-email management |
| `useUpdateEmailMutation` | Mutation | User email addresses with verification and primary-email management |
| `useDeleteEmailMutation` | Mutation | User email addresses with verification and primary-email management |
| `usePhoneNumbersQuery` | Query | User phone numbers with country code, verification, and primary-number management |
| `usePhoneNumberQuery` | Query | User phone numbers with country code, verification, and primary-number management |
| `useCreatePhoneNumberMutation` | Mutation | User phone numbers with country code, verification, and primary-number management |
| `useUpdatePhoneNumberMutation` | Mutation | User phone numbers with country code, verification, and primary-number management |
| `useDeletePhoneNumberMutation` | Mutation | User phone numbers with country code, verification, and primary-number management |
| `useWebauthnCredentialsQuery` | Query | WebAuthn/passkey credentials owned by users. One row per registered authenticator (security key, device biometric, synced passkey). Schema mirrors SimpleWebAuthn's canonical Passkey object. |
| `useWebauthnCredentialQuery` | Query | WebAuthn/passkey credentials owned by users. One row per registered authenticator (security key, device biometric, synced passkey). Schema mirrors SimpleWebAuthn's canonical Passkey object. |
| `useCreateWebauthnCredentialMutation` | Mutation | WebAuthn/passkey credentials owned by users. One row per registered authenticator (security key, device biometric, synced passkey). Schema mirrors SimpleWebAuthn's canonical Passkey object. |
| `useUpdateWebauthnCredentialMutation` | Mutation | WebAuthn/passkey credentials owned by users. One row per registered authenticator (security key, device biometric, synced passkey). Schema mirrors SimpleWebAuthn's canonical Passkey object. |
| `useDeleteWebauthnCredentialMutation` | Mutation | WebAuthn/passkey credentials owned by users. One row per registered authenticator (security key, device biometric, synced passkey). Schema mirrors SimpleWebAuthn's canonical Passkey object. |
| `useAppClaimedInvitesQuery` | Query | Records of successfully claimed invitations, linking senders to receivers |
| `useAppClaimedInviteQuery` | Query | Records of successfully claimed invitations, linking senders to receivers |
| `useCreateAppClaimedInviteMutation` | Mutation | Records of successfully claimed invitations, linking senders to receivers |
| `useUpdateAppClaimedInviteMutation` | Mutation | Records of successfully claimed invitations, linking senders to receivers |
| `useDeleteAppClaimedInviteMutation` | Mutation | Records of successfully claimed invitations, linking senders to receivers |
| `useOrgClaimedInvitesQuery` | Query | Records of successfully claimed invitations, linking senders to receivers |
| `useOrgClaimedInviteQuery` | Query | Records of successfully claimed invitations, linking senders to receivers |
| `useCreateOrgClaimedInviteMutation` | Mutation | Records of successfully claimed invitations, linking senders to receivers |
| `useUpdateOrgClaimedInviteMutation` | Mutation | Records of successfully claimed invitations, linking senders to receivers |
| `useDeleteOrgClaimedInviteMutation` | Mutation | Records of successfully claimed invitations, linking senders to receivers |
| `useAuditLogAuthsQuery` | Query | Partitioned append-only audit log of authentication events (sign-in, sign-up, password changes, etc.) |
| `useAuditLogAuthQuery` | Query | Partitioned append-only audit log of authentication events (sign-in, sign-up, password changes, etc.) |
| `useCreateAuditLogAuthMutation` | Mutation | Partitioned append-only audit log of authentication events (sign-in, sign-up, password changes, etc.) |
| `useUpdateAuditLogAuthMutation` | Mutation | Partitioned append-only audit log of authentication events (sign-in, sign-up, password changes, etc.) |
| `useDeleteAuditLogAuthMutation` | Mutation | Partitioned append-only audit log of authentication events (sign-in, sign-up, password changes, etc.) |
| `useOrgPermissionsQuery` | Query | Defines available permissions as named bits within a bitmask, used by the RBAC system for access control |
| `useOrgPermissionQuery` | Query | Defines available permissions as named bits within a bitmask, used by the RBAC system for access control |
| `useCreateOrgPermissionMutation` | Mutation | Defines available permissions as named bits within a bitmask, used by the RBAC system for access control |
| `useUpdateOrgPermissionMutation` | Mutation | Defines available permissions as named bits within a bitmask, used by the RBAC system for access control |
| `useDeleteOrgPermissionMutation` | Mutation | Defines available permissions as named bits within a bitmask, used by the RBAC system for access control |
| `useIdentityProvidersQuery` | Query | List all identityProviders |
| `useCreateIdentityProviderMutation` | Mutation | Create a identityProvider |
| `useAppPermissionDefaultPermissionsQuery` | Query | Join table linking permission defaults to individual permissions; recompute trigger rebuilds the defaults bitmask |
| `useAppPermissionDefaultPermissionQuery` | Query | Join table linking permission defaults to individual permissions; recompute trigger rebuilds the defaults bitmask |
| `useCreateAppPermissionDefaultPermissionMutation` | Mutation | Join table linking permission defaults to individual permissions; recompute trigger rebuilds the defaults bitmask |
| `useUpdateAppPermissionDefaultPermissionMutation` | Mutation | Join table linking permission defaults to individual permissions; recompute trigger rebuilds the defaults bitmask |
| `useDeleteAppPermissionDefaultPermissionMutation` | Mutation | Join table linking permission defaults to individual permissions; recompute trigger rebuilds the defaults bitmask |
| `useAppPermissionDefaultsQuery` | Query | Stores the default permission bitmask assigned to new members upon joining |
| `useAppPermissionDefaultQuery` | Query | Stores the default permission bitmask assigned to new members upon joining |
| `useCreateAppPermissionDefaultMutation` | Mutation | Stores the default permission bitmask assigned to new members upon joining |
| `useUpdateAppPermissionDefaultMutation` | Mutation | Stores the default permission bitmask assigned to new members upon joining |
| `useDeleteAppPermissionDefaultMutation` | Mutation | Stores the default permission bitmask assigned to new members upon joining |
| `useRoleTypesQuery` | Query | List all roleTypes |
| `useRoleTypeQuery` | Query | Get one roleType |
| `useCreateRoleTypeMutation` | Mutation | Create a roleType |
| `useUpdateRoleTypeMutation` | Mutation | Update a roleType |
| `useDeleteRoleTypeMutation` | Mutation | Delete a roleType |
| `useAppMembershipDefaultsQuery` | Query | Default membership settings per entity, controlling initial approval and verification state for new members |
| `useAppMembershipDefaultQuery` | Query | Default membership settings per entity, controlling initial approval and verification state for new members |
| `useCreateAppMembershipDefaultMutation` | Mutation | Default membership settings per entity, controlling initial approval and verification state for new members |
| `useUpdateAppMembershipDefaultMutation` | Mutation | Default membership settings per entity, controlling initial approval and verification state for new members |
| `useDeleteAppMembershipDefaultMutation` | Mutation | Default membership settings per entity, controlling initial approval and verification state for new members |
| `useOrgMembershipDefaultsQuery` | Query | Default membership settings per entity, controlling initial approval and verification state for new members |
| `useOrgMembershipDefaultQuery` | Query | Default membership settings per entity, controlling initial approval and verification state for new members |
| `useCreateOrgMembershipDefaultMutation` | Mutation | Default membership settings per entity, controlling initial approval and verification state for new members |
| `useUpdateOrgMembershipDefaultMutation` | Mutation | Default membership settings per entity, controlling initial approval and verification state for new members |
| `useDeleteOrgMembershipDefaultMutation` | Mutation | Default membership settings per entity, controlling initial approval and verification state for new members |
| `useAppLimitCapsDefaultsQuery` | Query | Default cap values for static configuration limits (max file size, feature flags, etc.). Not metered — just read by consumers. |
| `useAppLimitCapsDefaultQuery` | Query | Default cap values for static configuration limits (max file size, feature flags, etc.). Not metered — just read by consumers. |
| `useCreateAppLimitCapsDefaultMutation` | Mutation | Default cap values for static configuration limits (max file size, feature flags, etc.). Not metered — just read by consumers. |
| `useUpdateAppLimitCapsDefaultMutation` | Mutation | Default cap values for static configuration limits (max file size, feature flags, etc.). Not metered — just read by consumers. |
| `useDeleteAppLimitCapsDefaultMutation` | Mutation | Default cap values for static configuration limits (max file size, feature flags, etc.). Not metered — just read by consumers. |
| `useOrgLimitCapsDefaultsQuery` | Query | Default cap values for static configuration limits (max file size, feature flags, etc.). Not metered — just read by consumers. |
| `useOrgLimitCapsDefaultQuery` | Query | Default cap values for static configuration limits (max file size, feature flags, etc.). Not metered — just read by consumers. |
| `useCreateOrgLimitCapsDefaultMutation` | Mutation | Default cap values for static configuration limits (max file size, feature flags, etc.). Not metered — just read by consumers. |
| `useUpdateOrgLimitCapsDefaultMutation` | Mutation | Default cap values for static configuration limits (max file size, feature flags, etc.). Not metered — just read by consumers. |
| `useDeleteOrgLimitCapsDefaultMutation` | Mutation | Default cap values for static configuration limits (max file size, feature flags, etc.). Not metered — just read by consumers. |
| `useAppLimitCapsQuery` | Query | Per-entity cap overrides. Allows specific orgs/entities to have different cap values than the scope default. |
| `useAppLimitCapQuery` | Query | Per-entity cap overrides. Allows specific orgs/entities to have different cap values than the scope default. |
| `useCreateAppLimitCapMutation` | Mutation | Per-entity cap overrides. Allows specific orgs/entities to have different cap values than the scope default. |
| `useUpdateAppLimitCapMutation` | Mutation | Per-entity cap overrides. Allows specific orgs/entities to have different cap values than the scope default. |
| `useDeleteAppLimitCapMutation` | Mutation | Per-entity cap overrides. Allows specific orgs/entities to have different cap values than the scope default. |
| `useOrgLimitCapsQuery` | Query | Per-entity cap overrides. Allows specific orgs/entities to have different cap values than the scope default. |
| `useOrgLimitCapQuery` | Query | Per-entity cap overrides. Allows specific orgs/entities to have different cap values than the scope default. |
| `useCreateOrgLimitCapMutation` | Mutation | Per-entity cap overrides. Allows specific orgs/entities to have different cap values than the scope default. |
| `useUpdateOrgLimitCapMutation` | Mutation | Per-entity cap overrides. Allows specific orgs/entities to have different cap values than the scope default. |
| `useDeleteOrgLimitCapMutation` | Mutation | Per-entity cap overrides. Allows specific orgs/entities to have different cap values than the scope default. |
| `useUserConnectedAccountsQuery` | Query | List all userConnectedAccounts |
| `useUserConnectedAccountQuery` | Query | Get one userConnectedAccount |
| `useCreateUserConnectedAccountMutation` | Mutation | Create a userConnectedAccount |
| `useUpdateUserConnectedAccountMutation` | Mutation | Update a userConnectedAccount |
| `useDeleteUserConnectedAccountMutation` | Mutation | Delete a userConnectedAccount |
| `useAppLimitDefaultsQuery` | Query | Default maximum values for each named limit, applied when no per-actor override exists |
| `useAppLimitDefaultQuery` | Query | Default maximum values for each named limit, applied when no per-actor override exists |
| `useCreateAppLimitDefaultMutation` | Mutation | Default maximum values for each named limit, applied when no per-actor override exists |
| `useUpdateAppLimitDefaultMutation` | Mutation | Default maximum values for each named limit, applied when no per-actor override exists |
| `useDeleteAppLimitDefaultMutation` | Mutation | Default maximum values for each named limit, applied when no per-actor override exists |
| `useOrgLimitDefaultsQuery` | Query | Default maximum values for each named limit, applied when no per-actor override exists |
| `useOrgLimitDefaultQuery` | Query | Default maximum values for each named limit, applied when no per-actor override exists |
| `useCreateOrgLimitDefaultMutation` | Mutation | Default maximum values for each named limit, applied when no per-actor override exists |
| `useUpdateOrgLimitDefaultMutation` | Mutation | Default maximum values for each named limit, applied when no per-actor override exists |
| `useDeleteOrgLimitDefaultMutation` | Mutation | Default maximum values for each named limit, applied when no per-actor override exists |
| `useAppLimitCreditCodesQuery` | Query | Redeemable credit codes managed by admins with the add_credits permission |
| `useAppLimitCreditCodeQuery` | Query | Redeemable credit codes managed by admins with the add_credits permission |
| `useCreateAppLimitCreditCodeMutation` | Mutation | Redeemable credit codes managed by admins with the add_credits permission |
| `useUpdateAppLimitCreditCodeMutation` | Mutation | Redeemable credit codes managed by admins with the add_credits permission |
| `useDeleteAppLimitCreditCodeMutation` | Mutation | Redeemable credit codes managed by admins with the add_credits permission |
| `useAppLimitWarningsQuery` | Query | Warning configuration for soft limits. Each row defines a warning threshold and the job task to enqueue when usage approaches it. |
| `useAppLimitWarningQuery` | Query | Warning configuration for soft limits. Each row defines a warning threshold and the job task to enqueue when usage approaches it. |
| `useCreateAppLimitWarningMutation` | Mutation | Warning configuration for soft limits. Each row defines a warning threshold and the job task to enqueue when usage approaches it. |
| `useUpdateAppLimitWarningMutation` | Mutation | Warning configuration for soft limits. Each row defines a warning threshold and the job task to enqueue when usage approaches it. |
| `useDeleteAppLimitWarningMutation` | Mutation | Warning configuration for soft limits. Each row defines a warning threshold and the job task to enqueue when usage approaches it. |
| `useMembershipTypesQuery` | Query | Defines the different scopes of membership (e.g. App Member, Organization Member, Group Member) |
| `useMembershipTypeQuery` | Query | Defines the different scopes of membership (e.g. App Member, Organization Member, Group Member) |
| `useCreateMembershipTypeMutation` | Mutation | Defines the different scopes of membership (e.g. App Member, Organization Member, Group Member) |
| `useUpdateMembershipTypeMutation` | Mutation | Defines the different scopes of membership (e.g. App Member, Organization Member, Group Member) |
| `useDeleteMembershipTypeMutation` | Mutation | Defines the different scopes of membership (e.g. App Member, Organization Member, Group Member) |
| `useAppInternalSecretsQuery` | Query | List all appInternalSecrets |
| `useAppInternalSecretQuery` | Query | Get one appInternalSecret |
| `useCreateAppInternalSecretMutation` | Mutation | Create a appInternalSecret |
| `useUpdateAppInternalSecretMutation` | Mutation | Update a appInternalSecret |
| `useDeleteAppInternalSecretMutation` | Mutation | Delete a appInternalSecret |
| `useAppProfileTemplatesQuery` | Query | Template profiles that are automatically seeded into new entities when created |
| `useAppProfileTemplateQuery` | Query | Template profiles that are automatically seeded into new entities when created |
| `useCreateAppProfileTemplateMutation` | Mutation | Template profiles that are automatically seeded into new entities when created |
| `useUpdateAppProfileTemplateMutation` | Mutation | Template profiles that are automatically seeded into new entities when created |
| `useDeleteAppProfileTemplateMutation` | Mutation | Template profiles that are automatically seeded into new entities when created |
| `useOrgProfileTemplatesQuery` | Query | Template profiles that are automatically seeded into new entities when created |
| `useOrgProfileTemplateQuery` | Query | Template profiles that are automatically seeded into new entities when created |
| `useCreateOrgProfileTemplateMutation` | Mutation | Template profiles that are automatically seeded into new entities when created |
| `useUpdateOrgProfileTemplateMutation` | Mutation | Template profiles that are automatically seeded into new entities when created |
| `useDeleteOrgProfileTemplateMutation` | Mutation | Template profiles that are automatically seeded into new entities when created |
| `useOrgApiKeyListsQuery` | Query | List all orgApiKeyLists |
| `useOrgApiKeyListQuery` | Query | Get one orgApiKeyList |
| `useCreateOrgApiKeyListMutation` | Mutation | Create a orgApiKeyList |
| `useUpdateOrgApiKeyListMutation` | Mutation | Update a orgApiKeyList |
| `useDeleteOrgApiKeyListMutation` | Mutation | Delete a orgApiKeyList |
| `useAppProfilesQuery` | Query | Named permission bundles (roles) that group multiple permissions into reusable profiles |
| `useAppProfileQuery` | Query | Named permission bundles (roles) that group multiple permissions into reusable profiles |
| `useCreateAppProfileMutation` | Mutation | Named permission bundles (roles) that group multiple permissions into reusable profiles |
| `useUpdateAppProfileMutation` | Mutation | Named permission bundles (roles) that group multiple permissions into reusable profiles |
| `useDeleteAppProfileMutation` | Mutation | Named permission bundles (roles) that group multiple permissions into reusable profiles |
| `useAppBucketsQuery` | Query | Logical storage containers that group files with shared access policies and CDN behavior |
| `useAppBucketQuery` | Query | Logical storage containers that group files with shared access policies and CDN behavior |
| `useCreateAppBucketMutation` | Mutation | Logical storage containers that group files with shared access policies and CDN behavior |
| `useUpdateAppBucketMutation` | Mutation | Logical storage containers that group files with shared access policies and CDN behavior |
| `useDeleteAppBucketMutation` | Mutation | Logical storage containers that group files with shared access policies and CDN behavior |
| `useAppFilesQuery` | Query | Individual file records within buckets, with immutable identity fields and mutable metadata |
| `useAppFileQuery` | Query | Individual file records within buckets, with immutable identity fields and mutable metadata |
| `useCreateAppFileMutation` | Mutation | Individual file records within buckets, with immutable identity fields and mutable metadata |
| `useUpdateAppFileMutation` | Mutation | Individual file records within buckets, with immutable identity fields and mutable metadata |
| `useDeleteAppFileMutation` | Mutation | Individual file records within buckets, with immutable identity fields and mutable metadata |
| `useOrgMembershipSettingsQuery` | Query | Per-entity settings for the memberships module |
| `useOrgMembershipSettingQuery` | Query | Per-entity settings for the memberships module |
| `useCreateOrgMembershipSettingMutation` | Mutation | Per-entity settings for the memberships module |
| `useUpdateOrgMembershipSettingMutation` | Mutation | Per-entity settings for the memberships module |
| `useDeleteOrgMembershipSettingMutation` | Mutation | Per-entity settings for the memberships module |
| `useAppLimitEventsQuery` | Query | Append-only log of limit events for historical reporting and audit |
| `useAppLimitEventQuery` | Query | Append-only log of limit events for historical reporting and audit |
| `useCreateAppLimitEventMutation` | Mutation | Append-only log of limit events for historical reporting and audit |
| `useUpdateAppLimitEventMutation` | Mutation | Append-only log of limit events for historical reporting and audit |
| `useDeleteAppLimitEventMutation` | Mutation | Append-only log of limit events for historical reporting and audit |
| `useOrgLimitEventsQuery` | Query | Append-only log of limit events for historical reporting and audit |
| `useOrgLimitEventQuery` | Query | Append-only log of limit events for historical reporting and audit |
| `useCreateOrgLimitEventMutation` | Mutation | Append-only log of limit events for historical reporting and audit |
| `useUpdateOrgLimitEventMutation` | Mutation | Append-only log of limit events for historical reporting and audit |
| `useDeleteOrgLimitEventMutation` | Mutation | Append-only log of limit events for historical reporting and audit |
| `useUsersQuery` | Query | List all users |
| `useUserQuery` | Query | Get one user |
| `useCreateUserMutation` | Mutation | Create a user |
| `useUpdateUserMutation` | Mutation | Update a user |
| `useDeleteUserMutation` | Mutation | Delete a user |
| `useCurrentUserIdQuery` | Query | currentUserId |
| `useCurrentUserAgentQuery` | Query | currentUserAgent |
| `useCurrentIpAddressQuery` | Query | currentIpAddress |
| `useRequireStepUpQuery` | Query | requireStepUp |
| `useAppPermissionsGetPaddedMaskQuery` | Query | appPermissionsGetPaddedMask |
| `useOrgPermissionsGetPaddedMaskQuery` | Query | orgPermissionsGetPaddedMask |
| `useOrgIsManagerOfQuery` | Query | orgIsManagerOf |
| `useAppPermissionsGetMaskQuery` | Query | appPermissionsGetMask |
| `useOrgPermissionsGetMaskQuery` | Query | orgPermissionsGetMask |
| `useAppPermissionsGetMaskByNamesQuery` | Query | appPermissionsGetMaskByNames |
| `useOrgPermissionsGetMaskByNamesQuery` | Query | orgPermissionsGetMaskByNames |
| `useAppPermissionsGetByMaskQuery` | Query | Reads and enables pagination through a set of `AppPermission`. |
| `useOrgPermissionsGetByMaskQuery` | Query | Reads and enables pagination through a set of `OrgPermission`. |
| `useCurrentUserQuery` | Query | currentUser |
| `useSendAccountDeletionEmailMutation` | Mutation | sendAccountDeletionEmail |
| `useSignOutMutation` | Mutation | signOut |
| `useApproveDeviceMutation` | Mutation | approveDevice |
| `useDeleteOrgPrincipalMutation` | Mutation | deleteOrgPrincipal |
| `useDisconnectAccountMutation` | Mutation | disconnectAccount |
| `useRevokeApiKeyMutation` | Mutation | revokeApiKey |
| `useRevokeSessionMutation` | Mutation | revokeSession |
| `useVerifyPasswordMutation` | Mutation | verifyPassword |
| `useVerifyTotpMutation` | Mutation | verifyTotp |
| `useSubmitAppInviteCodeMutation` | Mutation | submitAppInviteCode |
| `useSubmitOrgInviteCodeMutation` | Mutation | submitOrgInviteCode |
| `useCheckPasswordMutation` | Mutation | checkPassword |
| `useProvisionNewUserMutation` | Mutation | provisionNewUser |
| `useConfirmDeleteAccountMutation` | Mutation | confirmDeleteAccount |
| `useRevokeOrgApiKeyMutation` | Mutation | revokeOrgApiKey |
| `useSetPasswordMutation` | Mutation | setPassword |
| `useVerifyEmailMutation` | Mutation | verifyEmail |
| `useAppInternalSecretsDelMutation` | Mutation | appInternalSecretsDel |
| `useResetPasswordMutation` | Mutation | resetPassword |
| `useAppInternalSecretsRotateMutation` | Mutation | appInternalSecretsRotate |
| `useAppInternalSecretsSetMutation` | Mutation | appInternalSecretsSet |
| `useCreateOrgPrincipalMutation` | Mutation | createOrgPrincipal |
| `useSignInCrossOriginMutation` | Mutation | signInCrossOrigin |
| `useSignUpSmsMutation` | Mutation | signUpSms |
| `useSignInSmsOtpMutation` | Mutation | signInSmsOtp |
| `useSignUpMutation` | Mutation | signUp |
| `useSignInMutation` | Mutation | signIn |
| `useSeedAppLimitCapsDefaultsMutation` | Mutation | seedAppLimitCapsDefaults |
| `useSeedAppLimitDefaultsMutation` | Mutation | seedAppLimitDefaults |
| `useSeedOrgLimitCapsDefaultsMutation` | Mutation | seedOrgLimitCapsDefaults |
| `useSeedOrgLimitDefaultsMutation` | Mutation | seedOrgLimitDefaults |
| `useLinkIdentityMutation` | Mutation | linkIdentity |
| `useAppInternalSecretsRemoveArrayMutation` | Mutation | appInternalSecretsRemoveArray |
| `useExtendTokenExpiresMutation` | Mutation | extendTokenExpires |
| `useCreateOrgApiKeyMutation` | Mutation | createOrgApiKey |
| `useCreateApiKeyMutation` | Mutation | createApiKey |
| `useRequestCrossOriginTokenMutation` | Mutation | requestCrossOriginToken |
| `useSendVerificationEmailMutation` | Mutation | sendVerificationEmail |
| `useForgotPasswordMutation` | Mutation | forgotPassword |
| `useAppFilesRenameMutation` | Mutation | appFilesRename |
| `useUploadAppFileMutation` | Mutation | Upload a file: resolves the bucket by key, creates the file row, and returns a presigned PUT URL. |
| `useUploadAppFilesMutation` | Mutation | Upload multiple files: resolves the bucket by key, creates file rows, and returns presigned PUT URLs for each. |
| `useProvisionBucketMutation` | Mutation | Provision an S3 bucket for a logical bucket in the database.
Reads the bucket config via RLS, then creates and configures
the S3 bucket with the appropriate privacy policies, CORS rules,
and lifecycle settings. |

## Table Hooks

### OrgGetManagersRecord

```typescript
// List all orgGetManagers
const { data, isLoading } = useOrgGetManagersQuery({
  selection: { fields: { userId: true, depth: true } },
});

// Create a orgGetManagersRecord
const { mutate: create } = useCreateOrgGetManagersRecordMutation({
  selection: { fields: { id: true } },
});
create({ userId: '<UUID>', depth: '<Int>' });
```

### OrgGetSubordinatesRecord

```typescript
// List all orgGetSubordinates
const { data, isLoading } = useOrgGetSubordinatesQuery({
  selection: { fields: { userId: true, depth: true } },
});

// Create a orgGetSubordinatesRecord
const { mutate: create } = useCreateOrgGetSubordinatesRecordMutation({
  selection: { fields: { id: true } },
});
create({ userId: '<UUID>', depth: '<Int>' });
```

### AppPermission

```typescript
// List all appPermissions
const { data, isLoading } = useAppPermissionsQuery({
  selection: { fields: { id: true, name: true, bitnum: true, bitstr: true, description: true } },
});

// Get one appPermission
const { data: item } = useAppPermissionQuery({
  id: '<UUID>',
  selection: { fields: { id: true, name: true, bitnum: true, bitstr: true, description: true } },
});

// Create a appPermission
const { mutate: create } = useCreateAppPermissionMutation({
  selection: { fields: { id: true } },
});
create({ name: '<String>', bitnum: '<Int>', bitstr: '<BitString>', description: '<String>' });
```

### AppPermissionDefaultGrant

```typescript
// List all appPermissionDefaultGrants
const { data, isLoading } = useAppPermissionDefaultGrantsQuery({
  selection: { fields: { id: true, permissionId: true, isGrant: true, grantorId: true, createdAt: true, updatedAt: true } },
});

// Get one appPermissionDefaultGrant
const { data: item } = useAppPermissionDefaultGrantQuery({
  id: '<UUID>',
  selection: { fields: { id: true, permissionId: true, isGrant: true, grantorId: true, createdAt: true, updatedAt: true } },
});

// Create a appPermissionDefaultGrant
const { mutate: create } = useCreateAppPermissionDefaultGrantMutation({
  selection: { fields: { id: true } },
});
create({ permissionId: '<UUID>', isGrant: '<Boolean>', grantorId: '<UUID>' });
```

### AppMembership

```typescript
// List all appMemberships
const { data, isLoading } = useAppMembershipsQuery({
  selection: { fields: { id: true, createdAt: true, updatedAt: true, createdBy: true, updatedBy: true, isApproved: true, isBanned: true, isDisabled: true, isVerified: true, isActive: true, isOwner: true, isAdmin: true, permissions: true, granted: true, actorId: true, profileId: true } },
});

// Get one appMembership
const { data: item } = useAppMembershipQuery({
  id: '<UUID>',
  selection: { fields: { id: true, createdAt: true, updatedAt: true, createdBy: true, updatedBy: true, isApproved: true, isBanned: true, isDisabled: true, isVerified: true, isActive: true, isOwner: true, isAdmin: true, permissions: true, granted: true, actorId: true, profileId: true } },
});

// Create a appMembership
const { mutate: create } = useCreateAppMembershipMutation({
  selection: { fields: { id: true } },
});
create({ createdBy: '<UUID>', updatedBy: '<UUID>', isApproved: '<Boolean>', isBanned: '<Boolean>', isDisabled: '<Boolean>', isVerified: '<Boolean>', isActive: '<Boolean>', isOwner: '<Boolean>', isAdmin: '<Boolean>', permissions: '<BitString>', granted: '<BitString>', actorId: '<UUID>', profileId: '<UUID>' });
```

### AppProfilePermission

```typescript
// List all appProfilePermissions
const { data, isLoading } = useAppProfilePermissionsQuery({
  selection: { fields: { id: true, profileId: true, permissionId: true, createdAt: true, updatedAt: true } },
});

// Get one appProfilePermission
const { data: item } = useAppProfilePermissionQuery({
  id: '<UUID>',
  selection: { fields: { id: true, profileId: true, permissionId: true, createdAt: true, updatedAt: true } },
});

// Create a appProfilePermission
const { mutate: create } = useCreateAppProfilePermissionMutation({
  selection: { fields: { id: true } },
});
create({ profileId: '<UUID>', permissionId: '<UUID>' });
```

### AppProfileGrant

```typescript
// List all appProfileGrants
const { data, isLoading } = useAppProfileGrantsQuery({
  selection: { fields: { id: true, membershipId: true, profileId: true, grantorId: true, isGrant: true, createdAt: true, updatedAt: true } },
});

// Get one appProfileGrant
const { data: item } = useAppProfileGrantQuery({
  id: '<UUID>',
  selection: { fields: { id: true, membershipId: true, profileId: true, grantorId: true, isGrant: true, createdAt: true, updatedAt: true } },
});

// Create a appProfileGrant
const { mutate: create } = useCreateAppProfileGrantMutation({
  selection: { fields: { id: true } },
});
create({ membershipId: '<UUID>', profileId: '<UUID>', grantorId: '<UUID>', isGrant: '<Boolean>' });
```

### AppProfileDefinitionGrant

```typescript
// List all appProfileDefinitionGrants
const { data, isLoading } = useAppProfileDefinitionGrantsQuery({
  selection: { fields: { id: true, profileId: true, permissionId: true, grantorId: true, isGrant: true, createdAt: true, updatedAt: true } },
});

// Get one appProfileDefinitionGrant
const { data: item } = useAppProfileDefinitionGrantQuery({
  id: '<UUID>',
  selection: { fields: { id: true, profileId: true, permissionId: true, grantorId: true, isGrant: true, createdAt: true, updatedAt: true } },
});

// Create a appProfileDefinitionGrant
const { mutate: create } = useCreateAppProfileDefinitionGrantMutation({
  selection: { fields: { id: true } },
});
create({ profileId: '<UUID>', permissionId: '<UUID>', grantorId: '<UUID>', isGrant: '<Boolean>' });
```

### AppInvite

```typescript
// List all appInvites
const { data, isLoading } = useAppInvitesQuery({
  selection: { fields: { id: true, channel: true, email: true, phone: true, senderId: true, inviteToken: true, inviteValid: true, inviteLimit: true, inviteCount: true, multiple: true, data: true, profileId: true, expiresAt: true, createdAt: true, updatedAt: true } },
});

// Get one appInvite
const { data: item } = useAppInviteQuery({
  id: '<UUID>',
  selection: { fields: { id: true, channel: true, email: true, phone: true, senderId: true, inviteToken: true, inviteValid: true, inviteLimit: true, inviteCount: true, multiple: true, data: true, profileId: true, expiresAt: true, createdAt: true, updatedAt: true } },
});

// Create a appInvite
const { mutate: create } = useCreateAppInviteMutation({
  selection: { fields: { id: true } },
});
create({ channel: '<String>', email: '<Email>', phone: '<String>', senderId: '<UUID>', inviteToken: '<String>', inviteValid: '<Boolean>', inviteLimit: '<Int>', inviteCount: '<Int>', multiple: '<Boolean>', data: '<JSON>', profileId: '<UUID>', expiresAt: '<Datetime>' });
```

### AppAdminGrant

```typescript
// List all appAdminGrants
const { data, isLoading } = useAppAdminGrantsQuery({
  selection: { fields: { id: true, isGrant: true, actorId: true, grantorId: true, createdAt: true, updatedAt: true } },
});

// Get one appAdminGrant
const { data: item } = useAppAdminGrantQuery({
  id: '<UUID>',
  selection: { fields: { id: true, isGrant: true, actorId: true, grantorId: true, createdAt: true, updatedAt: true } },
});

// Create a appAdminGrant
const { mutate: create } = useCreateAppAdminGrantMutation({
  selection: { fields: { id: true } },
});
create({ isGrant: '<Boolean>', actorId: '<UUID>', grantorId: '<UUID>' });
```

### AppOwnerGrant

```typescript
// List all appOwnerGrants
const { data, isLoading } = useAppOwnerGrantsQuery({
  selection: { fields: { id: true, isGrant: true, actorId: true, grantorId: true, createdAt: true, updatedAt: true } },
});

// Get one appOwnerGrant
const { data: item } = useAppOwnerGrantQuery({
  id: '<UUID>',
  selection: { fields: { id: true, isGrant: true, actorId: true, grantorId: true, createdAt: true, updatedAt: true } },
});

// Create a appOwnerGrant
const { mutate: create } = useCreateAppOwnerGrantMutation({
  selection: { fields: { id: true } },
});
create({ isGrant: '<Boolean>', actorId: '<UUID>', grantorId: '<UUID>' });
```

### AppGrant

```typescript
// List all appGrants
const { data, isLoading } = useAppGrantsQuery({
  selection: { fields: { id: true, permissions: true, isGrant: true, actorId: true, grantorId: true, createdAt: true, updatedAt: true } },
});

// Get one appGrant
const { data: item } = useAppGrantQuery({
  id: '<UUID>',
  selection: { fields: { id: true, permissions: true, isGrant: true, actorId: true, grantorId: true, createdAt: true, updatedAt: true } },
});

// Create a appGrant
const { mutate: create } = useCreateAppGrantMutation({
  selection: { fields: { id: true } },
});
create({ permissions: '<BitString>', isGrant: '<Boolean>', actorId: '<UUID>', grantorId: '<UUID>' });
```

### OrgMembership

```typescript
// List all orgMemberships
const { data, isLoading } = useOrgMembershipsQuery({
  selection: { fields: { id: true, createdAt: true, updatedAt: true, createdBy: true, updatedBy: true, isApproved: true, isBanned: true, isDisabled: true, isActive: true, isExternal: true, isOwner: true, isAdmin: true, permissions: true, granted: true, actorId: true, entityId: true, isReadOnly: true, profileId: true } },
});

// Get one orgMembership
const { data: item } = useOrgMembershipQuery({
  id: '<UUID>',
  selection: { fields: { id: true, createdAt: true, updatedAt: true, createdBy: true, updatedBy: true, isApproved: true, isBanned: true, isDisabled: true, isActive: true, isExternal: true, isOwner: true, isAdmin: true, permissions: true, granted: true, actorId: true, entityId: true, isReadOnly: true, profileId: true } },
});

// Create a orgMembership
const { mutate: create } = useCreateOrgMembershipMutation({
  selection: { fields: { id: true } },
});
create({ createdBy: '<UUID>', updatedBy: '<UUID>', isApproved: '<Boolean>', isBanned: '<Boolean>', isDisabled: '<Boolean>', isActive: '<Boolean>', isExternal: '<Boolean>', isOwner: '<Boolean>', isAdmin: '<Boolean>', permissions: '<BitString>', granted: '<BitString>', actorId: '<UUID>', entityId: '<UUID>', isReadOnly: '<Boolean>', profileId: '<UUID>' });
```

### OrgProfilePermission

```typescript
// List all orgProfilePermissions
const { data, isLoading } = useOrgProfilePermissionsQuery({
  selection: { fields: { id: true, profileId: true, permissionId: true, createdAt: true, updatedAt: true } },
});

// Get one orgProfilePermission
const { data: item } = useOrgProfilePermissionQuery({
  id: '<UUID>',
  selection: { fields: { id: true, profileId: true, permissionId: true, createdAt: true, updatedAt: true } },
});

// Create a orgProfilePermission
const { mutate: create } = useCreateOrgProfilePermissionMutation({
  selection: { fields: { id: true } },
});
create({ profileId: '<UUID>', permissionId: '<UUID>' });
```

### OrgPermissionDefaultPermission

```typescript
// List all orgPermissionDefaultPermissions
const { data, isLoading } = useOrgPermissionDefaultPermissionsQuery({
  selection: { fields: { id: true, permissionId: true, entityId: true, createdAt: true, updatedAt: true } },
});

// Get one orgPermissionDefaultPermission
const { data: item } = useOrgPermissionDefaultPermissionQuery({
  id: '<UUID>',
  selection: { fields: { id: true, permissionId: true, entityId: true, createdAt: true, updatedAt: true } },
});

// Create a orgPermissionDefaultPermission
const { mutate: create } = useCreateOrgPermissionDefaultPermissionMutation({
  selection: { fields: { id: true } },
});
create({ permissionId: '<UUID>', entityId: '<UUID>' });
```

### OrgPermissionDefaultGrant

```typescript
// List all orgPermissionDefaultGrants
const { data, isLoading } = useOrgPermissionDefaultGrantsQuery({
  selection: { fields: { id: true, permissionId: true, isGrant: true, grantorId: true, entityId: true, createdAt: true, updatedAt: true } },
});

// Get one orgPermissionDefaultGrant
const { data: item } = useOrgPermissionDefaultGrantQuery({
  id: '<UUID>',
  selection: { fields: { id: true, permissionId: true, isGrant: true, grantorId: true, entityId: true, createdAt: true, updatedAt: true } },
});

// Create a orgPermissionDefaultGrant
const { mutate: create } = useCreateOrgPermissionDefaultGrantMutation({
  selection: { fields: { id: true } },
});
create({ permissionId: '<UUID>', isGrant: '<Boolean>', grantorId: '<UUID>', entityId: '<UUID>' });
```

### OrgProfileDefinitionGrant

```typescript
// List all orgProfileDefinitionGrants
const { data, isLoading } = useOrgProfileDefinitionGrantsQuery({
  selection: { fields: { id: true, profileId: true, permissionId: true, grantorId: true, isGrant: true, createdAt: true, updatedAt: true } },
});

// Get one orgProfileDefinitionGrant
const { data: item } = useOrgProfileDefinitionGrantQuery({
  id: '<UUID>',
  selection: { fields: { id: true, profileId: true, permissionId: true, grantorId: true, isGrant: true, createdAt: true, updatedAt: true } },
});

// Create a orgProfileDefinitionGrant
const { mutate: create } = useCreateOrgProfileDefinitionGrantMutation({
  selection: { fields: { id: true } },
});
create({ profileId: '<UUID>', permissionId: '<UUID>', grantorId: '<UUID>', isGrant: '<Boolean>' });
```

### OrgProfileGrant

```typescript
// List all orgProfileGrants
const { data, isLoading } = useOrgProfileGrantsQuery({
  selection: { fields: { id: true, membershipId: true, profileId: true, entityId: true, grantorId: true, isGrant: true, createdAt: true, updatedAt: true } },
});

// Get one orgProfileGrant
const { data: item } = useOrgProfileGrantQuery({
  id: '<UUID>',
  selection: { fields: { id: true, membershipId: true, profileId: true, entityId: true, grantorId: true, isGrant: true, createdAt: true, updatedAt: true } },
});

// Create a orgProfileGrant
const { mutate: create } = useCreateOrgProfileGrantMutation({
  selection: { fields: { id: true } },
});
create({ membershipId: '<UUID>', profileId: '<UUID>', entityId: '<UUID>', grantorId: '<UUID>', isGrant: '<Boolean>' });
```

### OrgInvite

```typescript
// List all orgInvites
const { data, isLoading } = useOrgInvitesQuery({
  selection: { fields: { id: true, channel: true, email: true, phone: true, senderId: true, receiverId: true, inviteToken: true, inviteValid: true, inviteLimit: true, inviteCount: true, multiple: true, data: true, profileId: true, isReadOnly: true, expiresAt: true, createdAt: true, updatedAt: true, entityId: true } },
});

// Get one orgInvite
const { data: item } = useOrgInviteQuery({
  id: '<UUID>',
  selection: { fields: { id: true, channel: true, email: true, phone: true, senderId: true, receiverId: true, inviteToken: true, inviteValid: true, inviteLimit: true, inviteCount: true, multiple: true, data: true, profileId: true, isReadOnly: true, expiresAt: true, createdAt: true, updatedAt: true, entityId: true } },
});

// Create a orgInvite
const { mutate: create } = useCreateOrgInviteMutation({
  selection: { fields: { id: true } },
});
create({ channel: '<String>', email: '<Email>', phone: '<String>', senderId: '<UUID>', receiverId: '<UUID>', inviteToken: '<String>', inviteValid: '<Boolean>', inviteLimit: '<Int>', inviteCount: '<Int>', multiple: '<Boolean>', data: '<JSON>', profileId: '<UUID>', isReadOnly: '<Boolean>', expiresAt: '<Datetime>', entityId: '<UUID>' });
```

### OrgMember

```typescript
// List all orgMembers
const { data, isLoading } = useOrgMembersQuery({
  selection: { fields: { id: true, isAdmin: true, actorId: true, entityId: true } },
});

// Get one orgMember
const { data: item } = useOrgMemberQuery({
  id: '<UUID>',
  selection: { fields: { id: true, isAdmin: true, actorId: true, entityId: true } },
});

// Create a orgMember
const { mutate: create } = useCreateOrgMemberMutation({
  selection: { fields: { id: true } },
});
create({ isAdmin: '<Boolean>', actorId: '<UUID>', entityId: '<UUID>' });
```

### OrgAdminGrant

```typescript
// List all orgAdminGrants
const { data, isLoading } = useOrgAdminGrantsQuery({
  selection: { fields: { id: true, isGrant: true, actorId: true, entityId: true, grantorId: true, createdAt: true, updatedAt: true } },
});

// Get one orgAdminGrant
const { data: item } = useOrgAdminGrantQuery({
  id: '<UUID>',
  selection: { fields: { id: true, isGrant: true, actorId: true, entityId: true, grantorId: true, createdAt: true, updatedAt: true } },
});

// Create a orgAdminGrant
const { mutate: create } = useCreateOrgAdminGrantMutation({
  selection: { fields: { id: true } },
});
create({ isGrant: '<Boolean>', actorId: '<UUID>', entityId: '<UUID>', grantorId: '<UUID>' });
```

### OrgOwnerGrant

```typescript
// List all orgOwnerGrants
const { data, isLoading } = useOrgOwnerGrantsQuery({
  selection: { fields: { id: true, isGrant: true, actorId: true, entityId: true, grantorId: true, createdAt: true, updatedAt: true } },
});

// Get one orgOwnerGrant
const { data: item } = useOrgOwnerGrantQuery({
  id: '<UUID>',
  selection: { fields: { id: true, isGrant: true, actorId: true, entityId: true, grantorId: true, createdAt: true, updatedAt: true } },
});

// Create a orgOwnerGrant
const { mutate: create } = useCreateOrgOwnerGrantMutation({
  selection: { fields: { id: true } },
});
create({ isGrant: '<Boolean>', actorId: '<UUID>', entityId: '<UUID>', grantorId: '<UUID>' });
```

### OrgMemberProfile

```typescript
// List all orgMemberProfiles
const { data, isLoading } = useOrgMemberProfilesQuery({
  selection: { fields: { id: true, createdAt: true, updatedAt: true, membershipId: true, entityId: true, actorId: true, displayName: true, email: true, title: true, bio: true, profilePicture: true } },
});

// Get one orgMemberProfile
const { data: item } = useOrgMemberProfileQuery({
  id: '<UUID>',
  selection: { fields: { id: true, createdAt: true, updatedAt: true, membershipId: true, entityId: true, actorId: true, displayName: true, email: true, title: true, bio: true, profilePicture: true } },
});

// Create a orgMemberProfile
const { mutate: create } = useCreateOrgMemberProfileMutation({
  selection: { fields: { id: true } },
});
create({ membershipId: '<UUID>', entityId: '<UUID>', actorId: '<UUID>', displayName: '<String>', email: '<String>', title: '<String>', bio: '<String>', profilePicture: '<Image>' });
```

### OrgGrant

```typescript
// List all orgGrants
const { data, isLoading } = useOrgGrantsQuery({
  selection: { fields: { id: true, permissions: true, isGrant: true, actorId: true, entityId: true, grantorId: true, createdAt: true, updatedAt: true } },
});

// Get one orgGrant
const { data: item } = useOrgGrantQuery({
  id: '<UUID>',
  selection: { fields: { id: true, permissions: true, isGrant: true, actorId: true, entityId: true, grantorId: true, createdAt: true, updatedAt: true } },
});

// Create a orgGrant
const { mutate: create } = useCreateOrgGrantMutation({
  selection: { fields: { id: true } },
});
create({ permissions: '<BitString>', isGrant: '<Boolean>', actorId: '<UUID>', entityId: '<UUID>', grantorId: '<UUID>' });
```

### OrgChartEdge

```typescript
// List all orgChartEdges
const { data, isLoading } = useOrgChartEdgesQuery({
  selection: { fields: { id: true, createdAt: true, updatedAt: true, entityId: true, childId: true, parentId: true, positionTitle: true, positionLevel: true } },
});

// Get one orgChartEdge
const { data: item } = useOrgChartEdgeQuery({
  id: '<UUID>',
  selection: { fields: { id: true, createdAt: true, updatedAt: true, entityId: true, childId: true, parentId: true, positionTitle: true, positionLevel: true } },
});

// Create a orgChartEdge
const { mutate: create } = useCreateOrgChartEdgeMutation({
  selection: { fields: { id: true } },
});
create({ entityId: '<UUID>', childId: '<UUID>', parentId: '<UUID>', positionTitle: '<String>', positionLevel: '<Int>' });
```

### OrgChartEdgeGrant

```typescript
// List all orgChartEdgeGrants
const { data, isLoading } = useOrgChartEdgeGrantsQuery({
  selection: { fields: { id: true, entityId: true, childId: true, parentId: true, grantorId: true, isGrant: true, positionTitle: true, positionLevel: true, createdAt: true } },
});

// Get one orgChartEdgeGrant
const { data: item } = useOrgChartEdgeGrantQuery({
  id: '<UUID>',
  selection: { fields: { id: true, entityId: true, childId: true, parentId: true, grantorId: true, isGrant: true, positionTitle: true, positionLevel: true, createdAt: true } },
});

// Create a orgChartEdgeGrant
const { mutate: create } = useCreateOrgChartEdgeGrantMutation({
  selection: { fields: { id: true } },
});
create({ entityId: '<UUID>', childId: '<UUID>', parentId: '<UUID>', grantorId: '<UUID>', isGrant: '<Boolean>', positionTitle: '<String>', positionLevel: '<Int>' });
```

### OrgPermissionDefault

```typescript
// List all orgPermissionDefaults
const { data, isLoading } = useOrgPermissionDefaultsQuery({
  selection: { fields: { id: true, permissions: true, entityId: true } },
});

// Get one orgPermissionDefault
const { data: item } = useOrgPermissionDefaultQuery({
  id: '<UUID>',
  selection: { fields: { id: true, permissions: true, entityId: true } },
});

// Create a orgPermissionDefault
const { mutate: create } = useCreateOrgPermissionDefaultMutation({
  selection: { fields: { id: true } },
});
create({ permissions: '<BitString>', entityId: '<UUID>' });
```

### AppLimit

```typescript
// List all appLimits
const { data, isLoading } = useAppLimitsQuery({
  selection: { fields: { id: true, name: true, actorId: true, num: true, max: true, softMax: true, windowStart: true, windowDuration: true, planMax: true, purchasedCredits: true, periodCredits: true, organizationId: true, entityType: true } },
});

// Get one appLimit
const { data: item } = useAppLimitQuery({
  id: '<UUID>',
  selection: { fields: { id: true, name: true, actorId: true, num: true, max: true, softMax: true, windowStart: true, windowDuration: true, planMax: true, purchasedCredits: true, periodCredits: true, organizationId: true, entityType: true } },
});

// Create a appLimit
const { mutate: create } = useCreateAppLimitMutation({
  selection: { fields: { id: true } },
});
create({ name: '<String>', actorId: '<UUID>', num: '<BigInt>', max: '<BigInt>', softMax: '<BigInt>', windowStart: '<Datetime>', windowDuration: '<Interval>', planMax: '<BigInt>', purchasedCredits: '<BigInt>', periodCredits: '<BigInt>', organizationId: '<UUID>', entityType: '<String>' });
```

### AppLimitCredit

```typescript
// List all appLimitCredits
const { data, isLoading } = useAppLimitCreditsQuery({
  selection: { fields: { id: true, defaultLimitId: true, actorId: true, amount: true, creditType: true, reason: true } },
});

// Get one appLimitCredit
const { data: item } = useAppLimitCreditQuery({
  id: '<UUID>',
  selection: { fields: { id: true, defaultLimitId: true, actorId: true, amount: true, creditType: true, reason: true } },
});

// Create a appLimitCredit
const { mutate: create } = useCreateAppLimitCreditMutation({
  selection: { fields: { id: true } },
});
create({ defaultLimitId: '<UUID>', actorId: '<UUID>', amount: '<BigInt>', creditType: '<String>', reason: '<String>' });
```

### AppLimitCreditCodeItem

```typescript
// List all appLimitCreditCodeItems
const { data, isLoading } = useAppLimitCreditCodeItemsQuery({
  selection: { fields: { id: true, creditCodeId: true, defaultLimitId: true, amount: true, creditType: true } },
});

// Get one appLimitCreditCodeItem
const { data: item } = useAppLimitCreditCodeItemQuery({
  id: '<UUID>',
  selection: { fields: { id: true, creditCodeId: true, defaultLimitId: true, amount: true, creditType: true } },
});

// Create a appLimitCreditCodeItem
const { mutate: create } = useCreateAppLimitCreditCodeItemMutation({
  selection: { fields: { id: true } },
});
create({ creditCodeId: '<UUID>', defaultLimitId: '<UUID>', amount: '<BigInt>', creditType: '<String>' });
```

### AppLimitCreditRedemption

```typescript
// List all appLimitCreditRedemptions
const { data, isLoading } = useAppLimitCreditRedemptionsQuery({
  selection: { fields: { id: true, creditCodeId: true, entityId: true, organizationId: true, entityType: true } },
});

// Get one appLimitCreditRedemption
const { data: item } = useAppLimitCreditRedemptionQuery({
  id: '<UUID>',
  selection: { fields: { id: true, creditCodeId: true, entityId: true, organizationId: true, entityType: true } },
});

// Create a appLimitCreditRedemption
const { mutate: create } = useCreateAppLimitCreditRedemptionMutation({
  selection: { fields: { id: true } },
});
create({ creditCodeId: '<UUID>', entityId: '<UUID>', organizationId: '<UUID>', entityType: '<String>' });
```

### OrgLimit

```typescript
// List all orgLimits
const { data, isLoading } = useOrgLimitsQuery({
  selection: { fields: { id: true, name: true, actorId: true, num: true, max: true, softMax: true, windowStart: true, windowDuration: true, planMax: true, purchasedCredits: true, periodCredits: true, entityId: true, organizationId: true, entityType: true } },
});

// Get one orgLimit
const { data: item } = useOrgLimitQuery({
  id: '<UUID>',
  selection: { fields: { id: true, name: true, actorId: true, num: true, max: true, softMax: true, windowStart: true, windowDuration: true, planMax: true, purchasedCredits: true, periodCredits: true, entityId: true, organizationId: true, entityType: true } },
});

// Create a orgLimit
const { mutate: create } = useCreateOrgLimitMutation({
  selection: { fields: { id: true } },
});
create({ name: '<String>', actorId: '<UUID>', num: '<BigInt>', max: '<BigInt>', softMax: '<BigInt>', windowStart: '<Datetime>', windowDuration: '<Interval>', planMax: '<BigInt>', purchasedCredits: '<BigInt>', periodCredits: '<BigInt>', entityId: '<UUID>', organizationId: '<UUID>', entityType: '<String>' });
```

### OrgLimitCredit

```typescript
// List all orgLimitCredits
const { data, isLoading } = useOrgLimitCreditsQuery({
  selection: { fields: { id: true, defaultLimitId: true, actorId: true, entityId: true, organizationId: true, entityType: true, amount: true, creditType: true, reason: true } },
});

// Get one orgLimitCredit
const { data: item } = useOrgLimitCreditQuery({
  id: '<UUID>',
  selection: { fields: { id: true, defaultLimitId: true, actorId: true, entityId: true, organizationId: true, entityType: true, amount: true, creditType: true, reason: true } },
});

// Create a orgLimitCredit
const { mutate: create } = useCreateOrgLimitCreditMutation({
  selection: { fields: { id: true } },
});
create({ defaultLimitId: '<UUID>', actorId: '<UUID>', entityId: '<UUID>', organizationId: '<UUID>', entityType: '<String>', amount: '<BigInt>', creditType: '<String>', reason: '<String>' });
```

### OrgLimitAggregate

```typescript
// List all orgLimitAggregates
const { data, isLoading } = useOrgLimitAggregatesQuery({
  selection: { fields: { id: true, name: true, entityId: true, num: true, max: true, softMax: true, windowStart: true, windowDuration: true, planMax: true, purchasedCredits: true, periodCredits: true, reserved: true, organizationId: true, entityType: true } },
});

// Get one orgLimitAggregate
const { data: item } = useOrgLimitAggregateQuery({
  id: '<UUID>',
  selection: { fields: { id: true, name: true, entityId: true, num: true, max: true, softMax: true, windowStart: true, windowDuration: true, planMax: true, purchasedCredits: true, periodCredits: true, reserved: true, organizationId: true, entityType: true } },
});

// Create a orgLimitAggregate
const { mutate: create } = useCreateOrgLimitAggregateMutation({
  selection: { fields: { id: true } },
});
create({ name: '<String>', entityId: '<UUID>', num: '<BigInt>', max: '<BigInt>', softMax: '<BigInt>', windowStart: '<Datetime>', windowDuration: '<Interval>', planMax: '<BigInt>', purchasedCredits: '<BigInt>', periodCredits: '<BigInt>', reserved: '<BigInt>', organizationId: '<UUID>', entityType: '<String>' });
```

### OrgLimitWarning

```typescript
// List all orgLimitWarnings
const { data, isLoading } = useOrgLimitWarningsQuery({
  selection: { fields: { id: true, name: true, warningType: true, thresholdValue: true, taskIdentifier: true, entityId: true } },
});

// Get one orgLimitWarning
const { data: item } = useOrgLimitWarningQuery({
  id: '<UUID>',
  selection: { fields: { id: true, name: true, warningType: true, thresholdValue: true, taskIdentifier: true, entityId: true } },
});

// Create a orgLimitWarning
const { mutate: create } = useCreateOrgLimitWarningMutation({
  selection: { fields: { id: true } },
});
create({ name: '<String>', warningType: '<String>', thresholdValue: '<BigInt>', taskIdentifier: '<String>', entityId: '<UUID>' });
```

### OrgProfile

```typescript
// List all orgProfiles
const { data, isLoading } = useOrgProfilesQuery({
  selection: { fields: { id: true, name: true, slug: true, description: true, permissions: true, isSystem: true, isDefault: true, createdAt: true, updatedAt: true, entityId: true } },
});

// Get one orgProfile
const { data: item } = useOrgProfileQuery({
  id: '<UUID>',
  selection: { fields: { id: true, name: true, slug: true, description: true, permissions: true, isSystem: true, isDefault: true, createdAt: true, updatedAt: true, entityId: true } },
});

// Create a orgProfile
const { mutate: create } = useCreateOrgProfileMutation({
  selection: { fields: { id: true } },
});
create({ name: '<String>', slug: '<String>', description: '<String>', permissions: '<BitString>', isSystem: '<Boolean>', isDefault: '<Boolean>', entityId: '<UUID>' });
```

### Principal

```typescript
// List all principals
const { data, isLoading } = usePrincipalsQuery({
  selection: { fields: { id: true, createdAt: true, updatedAt: true, ownerId: true, userId: true, name: true, useAdminOwner: true, isReadOnly: true, bypassStepUp: true } },
});

// Get one principal
const { data: item } = usePrincipalQuery({
  principalId: '<UUID>',
  selection: { fields: { id: true, createdAt: true, updatedAt: true, ownerId: true, userId: true, name: true, useAdminOwner: true, isReadOnly: true, bypassStepUp: true } },
});

// Create a principal
const { mutate: create } = useCreatePrincipalMutation({
  selection: { fields: { principalId: true } },
});
create({ id: '<UUID>', ownerId: '<UUID>', userId: '<UUID>', name: '<String>', useAdminOwner: '<Boolean>', isReadOnly: '<Boolean>', bypassStepUp: '<Boolean>' });
```

### PrincipalEntity

```typescript
// List all principalEntities
const { data, isLoading } = usePrincipalEntitiesQuery({
  selection: { fields: { id: true, createdAt: true, updatedAt: true, principalId: true, entityId: true, ownerId: true } },
});

// Get one principalEntity
const { data: item } = usePrincipalEntityQuery({
  id: '<UUID>',
  selection: { fields: { id: true, createdAt: true, updatedAt: true, principalId: true, entityId: true, ownerId: true } },
});

// Create a principalEntity
const { mutate: create } = useCreatePrincipalEntityMutation({
  selection: { fields: { id: true } },
});
create({ principalId: '<UUID>', entityId: '<UUID>', ownerId: '<UUID>' });
```

### PrincipalScopeOverride

```typescript
// List all principalScopeOverrides
const { data, isLoading } = usePrincipalScopeOverridesQuery({
  selection: { fields: { id: true, createdAt: true, updatedAt: true, principalId: true, membershipType: true, allowedMask: true, useAdminOwner: true, isActive: true, isReadOnly: true } },
});

// Get one principalScopeOverride
const { data: item } = usePrincipalScopeOverrideQuery({
  id: '<UUID>',
  selection: { fields: { id: true, createdAt: true, updatedAt: true, principalId: true, membershipType: true, allowedMask: true, useAdminOwner: true, isActive: true, isReadOnly: true } },
});

// Create a principalScopeOverride
const { mutate: create } = useCreatePrincipalScopeOverrideMutation({
  selection: { fields: { id: true } },
});
create({ principalId: '<UUID>', membershipType: '<Int>', allowedMask: '<BitString>', useAdminOwner: '<Boolean>', isActive: '<Boolean>', isReadOnly: '<Boolean>' });
```

### Email

```typescript
// List all emails
const { data, isLoading } = useEmailsQuery({
  selection: { fields: { id: true, ownerId: true, email: true, isVerified: true, isPrimary: true, name: true, createdAt: true, updatedAt: true } },
});

// Get one email
const { data: item } = useEmailQuery({
  id: '<UUID>',
  selection: { fields: { id: true, ownerId: true, email: true, isVerified: true, isPrimary: true, name: true, createdAt: true, updatedAt: true } },
});

// Create a email
const { mutate: create } = useCreateEmailMutation({
  selection: { fields: { id: true } },
});
create({ ownerId: '<UUID>', email: '<Email>', isVerified: '<Boolean>', isPrimary: '<Boolean>', name: '<String>' });
```

### PhoneNumber

```typescript
// List all phoneNumbers
const { data, isLoading } = usePhoneNumbersQuery({
  selection: { fields: { id: true, ownerId: true, cc: true, number: true, isVerified: true, isPrimary: true, name: true, createdAt: true, updatedAt: true } },
});

// Get one phoneNumber
const { data: item } = usePhoneNumberQuery({
  id: '<UUID>',
  selection: { fields: { id: true, ownerId: true, cc: true, number: true, isVerified: true, isPrimary: true, name: true, createdAt: true, updatedAt: true } },
});

// Create a phoneNumber
const { mutate: create } = useCreatePhoneNumberMutation({
  selection: { fields: { id: true } },
});
create({ ownerId: '<UUID>', cc: '<String>', number: '<String>', isVerified: '<Boolean>', isPrimary: '<Boolean>', name: '<String>' });
```

### WebauthnCredential

```typescript
// List all webauthnCredentials
const { data, isLoading } = useWebauthnCredentialsQuery({
  selection: { fields: { id: true, ownerId: true, credentialId: true, publicKey: true, signCount: true, webauthnUserId: true, transports: true, credentialDeviceType: true, backupEligible: true, backupState: true, name: true, lastUsedAt: true, createdAt: true, updatedAt: true } },
});

// Get one webauthnCredential
const { data: item } = useWebauthnCredentialQuery({
  id: '<UUID>',
  selection: { fields: { id: true, ownerId: true, credentialId: true, publicKey: true, signCount: true, webauthnUserId: true, transports: true, credentialDeviceType: true, backupEligible: true, backupState: true, name: true, lastUsedAt: true, createdAt: true, updatedAt: true } },
});

// Create a webauthnCredential
const { mutate: create } = useCreateWebauthnCredentialMutation({
  selection: { fields: { id: true } },
});
create({ ownerId: '<UUID>', credentialId: '<String>', publicKey: '<Base64EncodedBinary>', signCount: '<BigInt>', webauthnUserId: '<String>', transports: '<String>', credentialDeviceType: '<String>', backupEligible: '<Boolean>', backupState: '<Boolean>', name: '<String>', lastUsedAt: '<Datetime>' });
```

### AppClaimedInvite

```typescript
// List all appClaimedInvites
const { data, isLoading } = useAppClaimedInvitesQuery({
  selection: { fields: { id: true, data: true, senderId: true, receiverId: true, createdAt: true, updatedAt: true } },
});

// Get one appClaimedInvite
const { data: item } = useAppClaimedInviteQuery({
  id: '<UUID>',
  selection: { fields: { id: true, data: true, senderId: true, receiverId: true, createdAt: true, updatedAt: true } },
});

// Create a appClaimedInvite
const { mutate: create } = useCreateAppClaimedInviteMutation({
  selection: { fields: { id: true } },
});
create({ data: '<JSON>', senderId: '<UUID>', receiverId: '<UUID>' });
```

### OrgClaimedInvite

```typescript
// List all orgClaimedInvites
const { data, isLoading } = useOrgClaimedInvitesQuery({
  selection: { fields: { id: true, data: true, senderId: true, receiverId: true, createdAt: true, updatedAt: true, entityId: true } },
});

// Get one orgClaimedInvite
const { data: item } = useOrgClaimedInviteQuery({
  id: '<UUID>',
  selection: { fields: { id: true, data: true, senderId: true, receiverId: true, createdAt: true, updatedAt: true, entityId: true } },
});

// Create a orgClaimedInvite
const { mutate: create } = useCreateOrgClaimedInviteMutation({
  selection: { fields: { id: true } },
});
create({ data: '<JSON>', senderId: '<UUID>', receiverId: '<UUID>', entityId: '<UUID>' });
```

### AuditLogAuth

```typescript
// List all auditLogAuths
const { data, isLoading } = useAuditLogAuthsQuery({
  selection: { fields: { createdAt: true, id: true, event: true, actorId: true, origin: true, userAgent: true, ipAddress: true, success: true } },
});

// Get one auditLogAuth
const { data: item } = useAuditLogAuthQuery({
  id: '<UUID>',
  selection: { fields: { createdAt: true, id: true, event: true, actorId: true, origin: true, userAgent: true, ipAddress: true, success: true } },
});

// Create a auditLogAuth
const { mutate: create } = useCreateAuditLogAuthMutation({
  selection: { fields: { id: true } },
});
create({ event: '<String>', actorId: '<UUID>', origin: '<Origin>', userAgent: '<String>', ipAddress: '<InternetAddress>', success: '<Boolean>' });
```

### OrgPermission

```typescript
// List all orgPermissions
const { data, isLoading } = useOrgPermissionsQuery({
  selection: { fields: { id: true, name: true, bitnum: true, bitstr: true, description: true } },
});

// Get one orgPermission
const { data: item } = useOrgPermissionQuery({
  id: '<UUID>',
  selection: { fields: { id: true, name: true, bitnum: true, bitstr: true, description: true } },
});

// Create a orgPermission
const { mutate: create } = useCreateOrgPermissionMutation({
  selection: { fields: { id: true } },
});
create({ name: '<String>', bitnum: '<Int>', bitstr: '<BitString>', description: '<String>' });
```

### IdentityProvider

```typescript
// List all identityProviders
const { data, isLoading } = useIdentityProvidersQuery({
  selection: { fields: { slug: true, kind: true, displayName: true, enabled: true } },
});

// Create a identityProvider
const { mutate: create } = useCreateIdentityProviderMutation({
  selection: { fields: { id: true } },
});
create({ slug: '<String>', kind: '<String>', displayName: '<String>', enabled: '<Boolean>' });
```

### AppPermissionDefaultPermission

```typescript
// List all appPermissionDefaultPermissions
const { data, isLoading } = useAppPermissionDefaultPermissionsQuery({
  selection: { fields: { id: true, permissionId: true, createdAt: true, updatedAt: true } },
});

// Get one appPermissionDefaultPermission
const { data: item } = useAppPermissionDefaultPermissionQuery({
  id: '<UUID>',
  selection: { fields: { id: true, permissionId: true, createdAt: true, updatedAt: true } },
});

// Create a appPermissionDefaultPermission
const { mutate: create } = useCreateAppPermissionDefaultPermissionMutation({
  selection: { fields: { id: true } },
});
create({ permissionId: '<UUID>' });
```

### AppPermissionDefault

```typescript
// List all appPermissionDefaults
const { data, isLoading } = useAppPermissionDefaultsQuery({
  selection: { fields: { id: true, permissions: true } },
});

// Get one appPermissionDefault
const { data: item } = useAppPermissionDefaultQuery({
  id: '<UUID>',
  selection: { fields: { id: true, permissions: true } },
});

// Create a appPermissionDefault
const { mutate: create } = useCreateAppPermissionDefaultMutation({
  selection: { fields: { id: true } },
});
create({ permissions: '<BitString>' });
```

### RoleType

```typescript
// List all roleTypes
const { data, isLoading } = useRoleTypesQuery({
  selection: { fields: { id: true, name: true } },
});

// Get one roleType
const { data: item } = useRoleTypeQuery({
  id: '<Int>',
  selection: { fields: { id: true, name: true } },
});

// Create a roleType
const { mutate: create } = useCreateRoleTypeMutation({
  selection: { fields: { id: true } },
});
create({ name: '<String>' });
```

### AppMembershipDefault

```typescript
// List all appMembershipDefaults
const { data, isLoading } = useAppMembershipDefaultsQuery({
  selection: { fields: { id: true, createdAt: true, updatedAt: true, createdBy: true, updatedBy: true, isApproved: true, isVerified: true } },
});

// Get one appMembershipDefault
const { data: item } = useAppMembershipDefaultQuery({
  id: '<UUID>',
  selection: { fields: { id: true, createdAt: true, updatedAt: true, createdBy: true, updatedBy: true, isApproved: true, isVerified: true } },
});

// Create a appMembershipDefault
const { mutate: create } = useCreateAppMembershipDefaultMutation({
  selection: { fields: { id: true } },
});
create({ createdBy: '<UUID>', updatedBy: '<UUID>', isApproved: '<Boolean>', isVerified: '<Boolean>' });
```

### OrgMembershipDefault

```typescript
// List all orgMembershipDefaults
const { data, isLoading } = useOrgMembershipDefaultsQuery({
  selection: { fields: { id: true, createdAt: true, updatedAt: true, createdBy: true, updatedBy: true, isApproved: true, entityId: true } },
});

// Get one orgMembershipDefault
const { data: item } = useOrgMembershipDefaultQuery({
  id: '<UUID>',
  selection: { fields: { id: true, createdAt: true, updatedAt: true, createdBy: true, updatedBy: true, isApproved: true, entityId: true } },
});

// Create a orgMembershipDefault
const { mutate: create } = useCreateOrgMembershipDefaultMutation({
  selection: { fields: { id: true } },
});
create({ createdBy: '<UUID>', updatedBy: '<UUID>', isApproved: '<Boolean>', entityId: '<UUID>' });
```

### AppLimitCapsDefault

```typescript
// List all appLimitCapsDefaults
const { data, isLoading } = useAppLimitCapsDefaultsQuery({
  selection: { fields: { id: true, name: true, max: true } },
});

// Get one appLimitCapsDefault
const { data: item } = useAppLimitCapsDefaultQuery({
  id: '<UUID>',
  selection: { fields: { id: true, name: true, max: true } },
});

// Create a appLimitCapsDefault
const { mutate: create } = useCreateAppLimitCapsDefaultMutation({
  selection: { fields: { id: true } },
});
create({ name: '<String>', max: '<BigInt>' });
```

### OrgLimitCapsDefault

```typescript
// List all orgLimitCapsDefaults
const { data, isLoading } = useOrgLimitCapsDefaultsQuery({
  selection: { fields: { id: true, name: true, max: true } },
});

// Get one orgLimitCapsDefault
const { data: item } = useOrgLimitCapsDefaultQuery({
  id: '<UUID>',
  selection: { fields: { id: true, name: true, max: true } },
});

// Create a orgLimitCapsDefault
const { mutate: create } = useCreateOrgLimitCapsDefaultMutation({
  selection: { fields: { id: true } },
});
create({ name: '<String>', max: '<BigInt>' });
```

### AppLimitCap

```typescript
// List all appLimitCaps
const { data, isLoading } = useAppLimitCapsQuery({
  selection: { fields: { id: true, name: true, entityId: true, max: true } },
});

// Get one appLimitCap
const { data: item } = useAppLimitCapQuery({
  id: '<UUID>',
  selection: { fields: { id: true, name: true, entityId: true, max: true } },
});

// Create a appLimitCap
const { mutate: create } = useCreateAppLimitCapMutation({
  selection: { fields: { id: true } },
});
create({ name: '<String>', entityId: '<UUID>', max: '<BigInt>' });
```

### OrgLimitCap

```typescript
// List all orgLimitCaps
const { data, isLoading } = useOrgLimitCapsQuery({
  selection: { fields: { id: true, name: true, entityId: true, max: true } },
});

// Get one orgLimitCap
const { data: item } = useOrgLimitCapQuery({
  id: '<UUID>',
  selection: { fields: { id: true, name: true, entityId: true, max: true } },
});

// Create a orgLimitCap
const { mutate: create } = useCreateOrgLimitCapMutation({
  selection: { fields: { id: true } },
});
create({ name: '<String>', entityId: '<UUID>', max: '<BigInt>' });
```

### UserConnectedAccount

```typescript
// List all userConnectedAccounts
const { data, isLoading } = useUserConnectedAccountsQuery({
  selection: { fields: { id: true, ownerId: true, service: true, identifier: true, details: true, isVerified: true, createdAt: true, updatedAt: true } },
});

// Get one userConnectedAccount
const { data: item } = useUserConnectedAccountQuery({
  id: '<UUID>',
  selection: { fields: { id: true, ownerId: true, service: true, identifier: true, details: true, isVerified: true, createdAt: true, updatedAt: true } },
});

// Create a userConnectedAccount
const { mutate: create } = useCreateUserConnectedAccountMutation({
  selection: { fields: { id: true } },
});
create({ ownerId: '<UUID>', service: '<String>', identifier: '<String>', details: '<JSON>', isVerified: '<Boolean>' });
```

### AppLimitDefault

```typescript
// List all appLimitDefaults
const { data, isLoading } = useAppLimitDefaultsQuery({
  selection: { fields: { id: true, name: true, max: true, softMax: true } },
});

// Get one appLimitDefault
const { data: item } = useAppLimitDefaultQuery({
  id: '<UUID>',
  selection: { fields: { id: true, name: true, max: true, softMax: true } },
});

// Create a appLimitDefault
const { mutate: create } = useCreateAppLimitDefaultMutation({
  selection: { fields: { id: true } },
});
create({ name: '<String>', max: '<BigInt>', softMax: '<BigInt>' });
```

### OrgLimitDefault

```typescript
// List all orgLimitDefaults
const { data, isLoading } = useOrgLimitDefaultsQuery({
  selection: { fields: { id: true, name: true, max: true, softMax: true } },
});

// Get one orgLimitDefault
const { data: item } = useOrgLimitDefaultQuery({
  id: '<UUID>',
  selection: { fields: { id: true, name: true, max: true, softMax: true } },
});

// Create a orgLimitDefault
const { mutate: create } = useCreateOrgLimitDefaultMutation({
  selection: { fields: { id: true } },
});
create({ name: '<String>', max: '<BigInt>', softMax: '<BigInt>' });
```

### AppLimitCreditCode

```typescript
// List all appLimitCreditCodes
const { data, isLoading } = useAppLimitCreditCodesQuery({
  selection: { fields: { id: true, code: true, maxRedemptions: true, currentRedemptions: true, expiresAt: true } },
});

// Get one appLimitCreditCode
const { data: item } = useAppLimitCreditCodeQuery({
  id: '<UUID>',
  selection: { fields: { id: true, code: true, maxRedemptions: true, currentRedemptions: true, expiresAt: true } },
});

// Create a appLimitCreditCode
const { mutate: create } = useCreateAppLimitCreditCodeMutation({
  selection: { fields: { id: true } },
});
create({ code: '<String>', maxRedemptions: '<Int>', currentRedemptions: '<Int>', expiresAt: '<Datetime>' });
```

### AppLimitWarning

```typescript
// List all appLimitWarnings
const { data, isLoading } = useAppLimitWarningsQuery({
  selection: { fields: { id: true, name: true, warningType: true, thresholdValue: true, taskIdentifier: true } },
});

// Get one appLimitWarning
const { data: item } = useAppLimitWarningQuery({
  id: '<UUID>',
  selection: { fields: { id: true, name: true, warningType: true, thresholdValue: true, taskIdentifier: true } },
});

// Create a appLimitWarning
const { mutate: create } = useCreateAppLimitWarningMutation({
  selection: { fields: { id: true } },
});
create({ name: '<String>', warningType: '<String>', thresholdValue: '<BigInt>', taskIdentifier: '<String>' });
```

### MembershipType

```typescript
// List all membershipTypes
const { data, isLoading } = useMembershipTypesQuery({
  selection: { fields: { id: true, name: true, description: true, scope: true, parentMembershipType: true, hasUsersTableEntry: true } },
});

// Get one membershipType
const { data: item } = useMembershipTypeQuery({
  id: '<Int>',
  selection: { fields: { id: true, name: true, description: true, scope: true, parentMembershipType: true, hasUsersTableEntry: true } },
});

// Create a membershipType
const { mutate: create } = useCreateMembershipTypeMutation({
  selection: { fields: { id: true } },
});
create({ name: '<String>', description: '<String>', scope: '<String>', parentMembershipType: '<Int>', hasUsersTableEntry: '<Boolean>' });
```

### AppInternalSecret

```typescript
// List all appInternalSecrets
const { data, isLoading } = useAppInternalSecretsQuery({
  selection: { fields: { id: true, name: true, namespaceId: true, description: true, labels: true, annotations: true, createdAt: true, updatedAt: true, rotatedAt: true, retiredAt: true } },
});

// Get one appInternalSecret
const { data: item } = useAppInternalSecretQuery({
  id: '<UUID>',
  selection: { fields: { id: true, name: true, namespaceId: true, description: true, labels: true, annotations: true, createdAt: true, updatedAt: true, rotatedAt: true, retiredAt: true } },
});

// Create a appInternalSecret
const { mutate: create } = useCreateAppInternalSecretMutation({
  selection: { fields: { id: true } },
});
create({ name: '<String>', namespaceId: '<UUID>', description: '<String>', labels: '<JSON>', annotations: '<JSON>', rotatedAt: '<Datetime>', retiredAt: '<Datetime>' });
```

### AppProfileTemplate

```typescript
// List all appProfileTemplates
const { data, isLoading } = useAppProfileTemplatesQuery({
  selection: { fields: { id: true, name: true, slug: true, description: true, permissions: true, isDefault: true, createdAt: true, updatedAt: true } },
});

// Get one appProfileTemplate
const { data: item } = useAppProfileTemplateQuery({
  id: '<UUID>',
  selection: { fields: { id: true, name: true, slug: true, description: true, permissions: true, isDefault: true, createdAt: true, updatedAt: true } },
});

// Create a appProfileTemplate
const { mutate: create } = useCreateAppProfileTemplateMutation({
  selection: { fields: { id: true } },
});
create({ name: '<String>', slug: '<String>', description: '<String>', permissions: '<BitString>', isDefault: '<Boolean>' });
```

### OrgProfileTemplate

```typescript
// List all orgProfileTemplates
const { data, isLoading } = useOrgProfileTemplatesQuery({
  selection: { fields: { id: true, name: true, slug: true, description: true, permissions: true, isDefault: true, createdAt: true, updatedAt: true } },
});

// Get one orgProfileTemplate
const { data: item } = useOrgProfileTemplateQuery({
  id: '<UUID>',
  selection: { fields: { id: true, name: true, slug: true, description: true, permissions: true, isDefault: true, createdAt: true, updatedAt: true } },
});

// Create a orgProfileTemplate
const { mutate: create } = useCreateOrgProfileTemplateMutation({
  selection: { fields: { id: true } },
});
create({ name: '<String>', slug: '<String>', description: '<String>', permissions: '<BitString>', isDefault: '<Boolean>' });
```

### OrgApiKeyList

```typescript
// List all orgApiKeyLists
const { data, isLoading } = useOrgApiKeyListsQuery({
  selection: { fields: { id: true, keyId: true, name: true, principalId: true, orgId: true, expiresAt: true, revokedAt: true, lastUsedAt: true, mfaLevel: true, accessLevel: true, createdAt: true, updatedAt: true } },
});

// Get one orgApiKeyList
const { data: item } = useOrgApiKeyListQuery({
  id: '<UUID>',
  selection: { fields: { id: true, keyId: true, name: true, principalId: true, orgId: true, expiresAt: true, revokedAt: true, lastUsedAt: true, mfaLevel: true, accessLevel: true, createdAt: true, updatedAt: true } },
});

// Create a orgApiKeyList
const { mutate: create } = useCreateOrgApiKeyListMutation({
  selection: { fields: { id: true } },
});
create({ keyId: '<String>', name: '<String>', principalId: '<UUID>', orgId: '<UUID>', expiresAt: '<Datetime>', revokedAt: '<Datetime>', lastUsedAt: '<Datetime>', mfaLevel: '<String>', accessLevel: '<String>' });
```

### AppProfile

```typescript
// List all appProfiles
const { data, isLoading } = useAppProfilesQuery({
  selection: { fields: { id: true, name: true, slug: true, description: true, permissions: true, isSystem: true, isDefault: true, createdAt: true, updatedAt: true } },
});

// Get one appProfile
const { data: item } = useAppProfileQuery({
  id: '<UUID>',
  selection: { fields: { id: true, name: true, slug: true, description: true, permissions: true, isSystem: true, isDefault: true, createdAt: true, updatedAt: true } },
});

// Create a appProfile
const { mutate: create } = useCreateAppProfileMutation({
  selection: { fields: { id: true } },
});
create({ name: '<String>', slug: '<String>', description: '<String>', permissions: '<BitString>', isSystem: '<Boolean>', isDefault: '<Boolean>' });
```

### AppBucket

```typescript
// List all appBuckets
const { data, isLoading } = useAppBucketsQuery({
  selection: { fields: { id: true, createdAt: true, updatedAt: true, key: true, type: true, physicalName: true, isPublic: true, description: true, actorId: true, maxFileSize: true, allowedMimeTypes: true, allowedOrigins: true, allowCustomKeys: true } },
});

// Get one appBucket
const { data: item } = useAppBucketQuery({
  id: '<UUID>',
  selection: { fields: { id: true, createdAt: true, updatedAt: true, key: true, type: true, physicalName: true, isPublic: true, description: true, actorId: true, maxFileSize: true, allowedMimeTypes: true, allowedOrigins: true, allowCustomKeys: true } },
});

// Create a appBucket
const { mutate: create } = useCreateAppBucketMutation({
  selection: { fields: { id: true } },
});
create({ key: '<String>', type: '<String>', physicalName: '<String>', isPublic: '<Boolean>', description: '<String>', actorId: '<UUID>', maxFileSize: '<BigInt>', allowedMimeTypes: '<String>', allowedOrigins: '<String>', allowCustomKeys: '<Boolean>' });
```

### AppFile

```typescript
// List all appFiles
const { data, isLoading } = useAppFilesQuery({
  selection: { fields: { filePath: true, id: true, createdAt: true, updatedAt: true, key: true, contentHash: true, bucketId: true, actorId: true, isPublic: true, mimeType: true, size: true, description: true, tags: true, filename: true, status: true, upload: true, downloadUrl: true } },
});

// Get one appFile
const { data: item } = useAppFileQuery({
  id: '<UUID>',
  selection: { fields: { filePath: true, id: true, createdAt: true, updatedAt: true, key: true, contentHash: true, bucketId: true, actorId: true, isPublic: true, mimeType: true, size: true, description: true, tags: true, filename: true, status: true, upload: true, downloadUrl: true } },
});

// Create a appFile
const { mutate: create } = useCreateAppFileMutation({
  selection: { fields: { id: true } },
});
create({ filePath: '<String>', key: '<String>', contentHash: '<String>', bucketId: '<UUID>', actorId: '<UUID>', isPublic: '<Boolean>', mimeType: '<String>', size: '<BigInt>', description: '<String>', tags: '<String>', filename: '<String>', status: '<FileStatus>', upload: '<Upload>', downloadUrl: '<String>' });
```

### OrgMembershipSetting

```typescript
// List all orgMembershipSettings
const { data, isLoading } = useOrgMembershipSettingsQuery({
  selection: { fields: { id: true, createdAt: true, updatedAt: true, createdBy: true, updatedBy: true, entityId: true, deleteMemberCascadeChildren: true, createChildCascadeOwners: true, createChildCascadeAdmins: true, createChildCascadeMembers: true, allowExternalMembers: true, inviteProfileAssignmentMode: true, populateMemberEmail: true, limitAllocationMode: true } },
});

// Get one orgMembershipSetting
const { data: item } = useOrgMembershipSettingQuery({
  id: '<UUID>',
  selection: { fields: { id: true, createdAt: true, updatedAt: true, createdBy: true, updatedBy: true, entityId: true, deleteMemberCascadeChildren: true, createChildCascadeOwners: true, createChildCascadeAdmins: true, createChildCascadeMembers: true, allowExternalMembers: true, inviteProfileAssignmentMode: true, populateMemberEmail: true, limitAllocationMode: true } },
});

// Create a orgMembershipSetting
const { mutate: create } = useCreateOrgMembershipSettingMutation({
  selection: { fields: { id: true } },
});
create({ createdBy: '<UUID>', updatedBy: '<UUID>', entityId: '<UUID>', deleteMemberCascadeChildren: '<Boolean>', createChildCascadeOwners: '<Boolean>', createChildCascadeAdmins: '<Boolean>', createChildCascadeMembers: '<Boolean>', allowExternalMembers: '<Boolean>', inviteProfileAssignmentMode: '<String>', populateMemberEmail: '<Boolean>', limitAllocationMode: '<String>' });
```

### AppLimitEvent

```typescript
// List all appLimitEvents
const { data, isLoading } = useAppLimitEventsQuery({
  selection: { fields: { createdAt: true, id: true, name: true, actorId: true, entityId: true, organizationId: true, entityType: true, eventType: true, delta: true, numBefore: true, numAfter: true, maxAtEvent: true, reason: true } },
});

// Get one appLimitEvent
const { data: item } = useAppLimitEventQuery({
  id: '<UUID>',
  selection: { fields: { createdAt: true, id: true, name: true, actorId: true, entityId: true, organizationId: true, entityType: true, eventType: true, delta: true, numBefore: true, numAfter: true, maxAtEvent: true, reason: true } },
});

// Create a appLimitEvent
const { mutate: create } = useCreateAppLimitEventMutation({
  selection: { fields: { id: true } },
});
create({ name: '<String>', actorId: '<UUID>', entityId: '<UUID>', organizationId: '<UUID>', entityType: '<String>', eventType: '<String>', delta: '<BigInt>', numBefore: '<BigInt>', numAfter: '<BigInt>', maxAtEvent: '<BigInt>', reason: '<String>' });
```

### OrgLimitEvent

```typescript
// List all orgLimitEvents
const { data, isLoading } = useOrgLimitEventsQuery({
  selection: { fields: { createdAt: true, id: true, name: true, actorId: true, entityId: true, organizationId: true, entityType: true, eventType: true, delta: true, numBefore: true, numAfter: true, maxAtEvent: true, reason: true } },
});

// Get one orgLimitEvent
const { data: item } = useOrgLimitEventQuery({
  id: '<UUID>',
  selection: { fields: { createdAt: true, id: true, name: true, actorId: true, entityId: true, organizationId: true, entityType: true, eventType: true, delta: true, numBefore: true, numAfter: true, maxAtEvent: true, reason: true } },
});

// Create a orgLimitEvent
const { mutate: create } = useCreateOrgLimitEventMutation({
  selection: { fields: { id: true } },
});
create({ name: '<String>', actorId: '<UUID>', entityId: '<UUID>', organizationId: '<UUID>', entityType: '<String>', eventType: '<String>', delta: '<BigInt>', numBefore: '<BigInt>', numAfter: '<BigInt>', maxAtEvent: '<BigInt>', reason: '<String>' });
```

### User

```typescript
// List all users
const { data, isLoading } = useUsersQuery({
  selection: { fields: { id: true, username: true, displayName: true, profilePicture: true, searchTsv: true, type: true, createdAt: true, updatedAt: true, searchTsvRank: true, displayNameTrgmSimilarity: true, searchScore: true } },
});

// Get one user
const { data: item } = useUserQuery({
  id: '<UUID>',
  selection: { fields: { id: true, username: true, displayName: true, profilePicture: true, searchTsv: true, type: true, createdAt: true, updatedAt: true, searchTsvRank: true, displayNameTrgmSimilarity: true, searchScore: true } },
});

// Create a user
const { mutate: create } = useCreateUserMutation({
  selection: { fields: { id: true } },
});
create({ username: '<String>', displayName: '<String>', profilePicture: '<Image>', searchTsv: '<FullText>', type: '<Int>', searchTsvRank: '<Float>', displayNameTrgmSimilarity: '<Float>', searchScore: '<Float>' });
```

## Custom Operation Hooks

### `useCurrentUserIdQuery`

currentUserId

- **Type:** query
- **Arguments:** none

### `useCurrentUserAgentQuery`

currentUserAgent

- **Type:** query
- **Arguments:** none

### `useCurrentIpAddressQuery`

currentIpAddress

- **Type:** query
- **Arguments:** none

### `useRequireStepUpQuery`

requireStepUp

- **Type:** query
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `stepUpType` | String |

### `useAppPermissionsGetPaddedMaskQuery`

appPermissionsGetPaddedMask

- **Type:** query
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `mask` | BitString |

### `useOrgPermissionsGetPaddedMaskQuery`

orgPermissionsGetPaddedMask

- **Type:** query
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `mask` | BitString |

### `useOrgIsManagerOfQuery`

orgIsManagerOf

- **Type:** query
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `targetEntityId` | UUID |
  | `managerId` | UUID |
  | `userId` | UUID |
  | `maxDepth` | Int |

### `useAppPermissionsGetMaskQuery`

appPermissionsGetMask

- **Type:** query
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `ids` | [UUID] |

### `useOrgPermissionsGetMaskQuery`

orgPermissionsGetMask

- **Type:** query
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `ids` | [UUID] |

### `useAppPermissionsGetMaskByNamesQuery`

appPermissionsGetMaskByNames

- **Type:** query
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `names` | [String] |

### `useOrgPermissionsGetMaskByNamesQuery`

orgPermissionsGetMaskByNames

- **Type:** query
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `names` | [String] |

### `useAppPermissionsGetByMaskQuery`

Reads and enables pagination through a set of `AppPermission`.

- **Type:** query
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `mask` | BitString |
  | `first` | Int |
  | `offset` | Int |
  | `after` | Cursor |

### `useOrgPermissionsGetByMaskQuery`

Reads and enables pagination through a set of `OrgPermission`.

- **Type:** query
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `mask` | BitString |
  | `first` | Int |
  | `offset` | Int |
  | `after` | Cursor |

### `useCurrentUserQuery`

currentUser

- **Type:** query
- **Arguments:** none

### `useSendAccountDeletionEmailMutation`

sendAccountDeletionEmail

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | SendAccountDeletionEmailInput (required) |

### `useSignOutMutation`

signOut

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | SignOutInput (required) |

### `useApproveDeviceMutation`

approveDevice

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | ApproveDeviceInput (required) |

### `useDeleteOrgPrincipalMutation`

deleteOrgPrincipal

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | DeleteOrgPrincipalInput (required) |

### `useDisconnectAccountMutation`

disconnectAccount

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | DisconnectAccountInput (required) |

### `useRevokeApiKeyMutation`

revokeApiKey

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | RevokeApiKeyInput (required) |

### `useRevokeSessionMutation`

revokeSession

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | RevokeSessionInput (required) |

### `useVerifyPasswordMutation`

verifyPassword

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | VerifyPasswordInput (required) |

### `useVerifyTotpMutation`

verifyTotp

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | VerifyTotpInput (required) |

### `useSubmitAppInviteCodeMutation`

submitAppInviteCode

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | SubmitAppInviteCodeInput (required) |

### `useSubmitOrgInviteCodeMutation`

submitOrgInviteCode

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | SubmitOrgInviteCodeInput (required) |

### `useCheckPasswordMutation`

checkPassword

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | CheckPasswordInput (required) |

### `useProvisionNewUserMutation`

provisionNewUser

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | ProvisionNewUserInput (required) |

### `useConfirmDeleteAccountMutation`

confirmDeleteAccount

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | ConfirmDeleteAccountInput (required) |

### `useRevokeOrgApiKeyMutation`

revokeOrgApiKey

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | RevokeOrgApiKeyInput (required) |

### `useSetPasswordMutation`

setPassword

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | SetPasswordInput (required) |

### `useVerifyEmailMutation`

verifyEmail

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | VerifyEmailInput (required) |

### `useAppInternalSecretsDelMutation`

appInternalSecretsDel

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | AppInternalSecretsDelInput (required) |

### `useResetPasswordMutation`

resetPassword

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | ResetPasswordInput (required) |

### `useAppInternalSecretsRotateMutation`

appInternalSecretsRotate

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | AppInternalSecretsRotateInput (required) |

### `useAppInternalSecretsSetMutation`

appInternalSecretsSet

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | AppInternalSecretsSetInput (required) |

### `useCreateOrgPrincipalMutation`

createOrgPrincipal

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | CreateOrgPrincipalInput (required) |

### `useSignInCrossOriginMutation`

signInCrossOrigin

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | SignInCrossOriginInput (required) |

### `useSignUpSmsMutation`

signUpSms

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | SignUpSmsInput (required) |

### `useSignInSmsOtpMutation`

signInSmsOtp

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | SignInSmsOtpInput (required) |

### `useSignUpMutation`

signUp

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | SignUpInput (required) |

### `useSignInMutation`

signIn

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | SignInInput (required) |

### `useSeedAppLimitCapsDefaultsMutation`

seedAppLimitCapsDefaults

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | SeedAppLimitCapsDefaultsInput (required) |

### `useSeedAppLimitDefaultsMutation`

seedAppLimitDefaults

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | SeedAppLimitDefaultsInput (required) |

### `useSeedOrgLimitCapsDefaultsMutation`

seedOrgLimitCapsDefaults

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | SeedOrgLimitCapsDefaultsInput (required) |

### `useSeedOrgLimitDefaultsMutation`

seedOrgLimitDefaults

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | SeedOrgLimitDefaultsInput (required) |

### `useLinkIdentityMutation`

linkIdentity

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | LinkIdentityInput (required) |

### `useAppInternalSecretsRemoveArrayMutation`

appInternalSecretsRemoveArray

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | AppInternalSecretsRemoveArrayInput (required) |

### `useExtendTokenExpiresMutation`

extendTokenExpires

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | ExtendTokenExpiresInput (required) |

### `useCreateOrgApiKeyMutation`

createOrgApiKey

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | CreateOrgApiKeyInput (required) |

### `useCreateApiKeyMutation`

createApiKey

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | CreateApiKeyInput (required) |

### `useRequestCrossOriginTokenMutation`

requestCrossOriginToken

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | RequestCrossOriginTokenInput (required) |

### `useSendVerificationEmailMutation`

sendVerificationEmail

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | SendVerificationEmailInput (required) |

### `useForgotPasswordMutation`

forgotPassword

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | ForgotPasswordInput (required) |

### `useAppFilesRenameMutation`

appFilesRename

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | AppFilesRenameInput (required) |

### `useUploadAppFileMutation`

Upload a file: resolves the bucket by key, creates the file row, and returns a presigned PUT URL.

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | UploadAppFileInput (required) |

### `useUploadAppFilesMutation`

Upload multiple files: resolves the bucket by key, creates file rows, and returns presigned PUT URLs for each.

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | UploadAppFileBulkInput (required) |

### `useProvisionBucketMutation`

Provision an S3 bucket for a logical bucket in the database.
Reads the bucket config via RLS, then creates and configures
the S3 bucket with the appropriate privacy policies, CORS rules,
and lifecycle settings.

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | ProvisionBucketInput (required) |

---

Built by the [Constructive](https://constructive.io) team.

## Disclaimer

AS DESCRIBED IN THE LICENSES, THE SOFTWARE IS PROVIDED "AS IS", AT YOUR OWN RISK, AND WITHOUT WARRANTIES OF ANY KIND.

No developer or entity involved in creating this software will be liable for any claims or damages whatsoever associated with your use, inability to use, or your interaction with other users of the code, including any direct, indirect, incidental, special, exemplary, punitive or consequential damages, or loss of profits, cryptocurrencies, tokens, or anything else of value.
