# ORM Client

<p align="center" width="100%">
  <img height="120" src="https://raw.githubusercontent.com/constructive-io/constructive/refs/heads/main/assets/outline-logo.svg" />
</p>

<!-- @constructive-io/graphql-codegen - DO NOT EDIT -->

## Setup

```typescript
import { createClient } from './orm';

const db = createClient({
  endpoint: 'https://api.example.com/graphql',
  headers: { Authorization: 'Bearer <token>' },
});
```

## Models

| Model | Operations |
|-------|------------|
| `orgGetManagersRecord` | findMany, findOne, create, update, delete |
| `orgGetSubordinatesRecord` | findMany, findOne, create, update, delete |
| `appPermission` | findMany, findOne, create, update, delete |
| `appPermissionDefaultGrant` | findMany, findOne, create, update, delete |
| `appMembership` | findMany, findOne, create, update, delete |
| `appProfilePermission` | findMany, findOne, create, update, delete |
| `appProfileGrant` | findMany, findOne, create, update, delete |
| `appProfileDefinitionGrant` | findMany, findOne, create, update, delete |
| `appInvite` | findMany, findOne, create, update, delete |
| `appAdminGrant` | findMany, findOne, create, update, delete |
| `appOwnerGrant` | findMany, findOne, create, update, delete |
| `appGrant` | findMany, findOne, create, update, delete |
| `orgMembership` | findMany, findOne, create, update, delete |
| `orgProfilePermission` | findMany, findOne, create, update, delete |
| `orgPermissionDefaultPermission` | findMany, findOne, create, update, delete |
| `orgPermissionDefaultGrant` | findMany, findOne, create, update, delete |
| `orgProfileDefinitionGrant` | findMany, findOne, create, update, delete |
| `orgProfileGrant` | findMany, findOne, create, update, delete |
| `orgInvite` | findMany, findOne, create, update, delete |
| `orgMember` | findMany, findOne, create, update, delete |
| `orgAdminGrant` | findMany, findOne, create, update, delete |
| `orgOwnerGrant` | findMany, findOne, create, update, delete |
| `orgMemberProfile` | findMany, findOne, create, update, delete |
| `orgGrant` | findMany, findOne, create, update, delete |
| `orgChartEdge` | findMany, findOne, create, update, delete |
| `orgChartEdgeGrant` | findMany, findOne, create, update, delete |
| `orgPermissionDefault` | findMany, findOne, create, update, delete |
| `appLimit` | findMany, findOne, create, update, delete |
| `appLimitCredit` | findMany, findOne, create, update, delete |
| `appLimitCreditCodeItem` | findMany, findOne, create, update, delete |
| `appLimitCreditRedemption` | findMany, findOne, create, update, delete |
| `orgLimit` | findMany, findOne, create, update, delete |
| `orgLimitCredit` | findMany, findOne, create, update, delete |
| `orgLimitAggregate` | findMany, findOne, create, update, delete |
| `orgLimitWarning` | findMany, findOne, create, update, delete |
| `orgProfile` | findMany, findOne, create, update, delete |
| `principal` | findMany, findOne, create, update, delete |
| `principalEntity` | findMany, findOne, create, update, delete |
| `principalScopeOverride` | findMany, findOne, create, update, delete |
| `email` | findMany, findOne, create, update, delete |
| `phoneNumber` | findMany, findOne, create, update, delete |
| `webauthnCredential` | findMany, findOne, create, update, delete |
| `appClaimedInvite` | findMany, findOne, create, update, delete |
| `orgClaimedInvite` | findMany, findOne, create, update, delete |
| `auditLogAuth` | findMany, findOne, create, update, delete |
| `orgPermission` | findMany, findOne, create, update, delete |
| `identityProvider` | findMany, findOne, create, update, delete |
| `appPermissionDefaultPermission` | findMany, findOne, create, update, delete |
| `appPermissionDefault` | findMany, findOne, create, update, delete |
| `roleType` | findMany, findOne, create, update, delete |
| `appMembershipDefault` | findMany, findOne, create, update, delete |
| `orgMembershipDefault` | findMany, findOne, create, update, delete |
| `appLimitCapsDefault` | findMany, findOne, create, update, delete |
| `orgLimitCapsDefault` | findMany, findOne, create, update, delete |
| `appLimitCap` | findMany, findOne, create, update, delete |
| `orgLimitCap` | findMany, findOne, create, update, delete |
| `userConnectedAccount` | findMany, findOne, create, update, delete |
| `appLimitDefault` | findMany, findOne, create, update, delete |
| `orgLimitDefault` | findMany, findOne, create, update, delete |
| `appLimitCreditCode` | findMany, findOne, create, update, delete |
| `appLimitWarning` | findMany, findOne, create, update, delete |
| `membershipType` | findMany, findOne, create, update, delete |
| `appInternalSecret` | findMany, findOne, create, update, delete |
| `appProfileTemplate` | findMany, findOne, create, update, delete |
| `orgProfileTemplate` | findMany, findOne, create, update, delete |
| `orgApiKeyList` | findMany, findOne, create, update, delete |
| `appProfile` | findMany, findOne, create, update, delete |
| `appBucket` | findMany, findOne, create, update, delete |
| `appFile` | findMany, findOne, create, update, delete |
| `orgMembershipSetting` | findMany, findOne, create, update, delete |
| `appLimitEvent` | findMany, findOne, create, update, delete |
| `orgLimitEvent` | findMany, findOne, create, update, delete |
| `user` | findMany, findOne, create, update, delete |

## Table Operations

### `db.orgGetManagersRecord`

CRUD operations for OrgGetManagersRecord records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `userId` | UUID | Yes |
| `depth` | Int | Yes |

**Operations:**

```typescript
// List all orgGetManagersRecord records
const items = await db.orgGetManagersRecord.findMany({ select: { userId: true, depth: true } }).execute();

// Get one by id
const item = await db.orgGetManagersRecord.findOne({ id: '<UUID>', select: { userId: true, depth: true } }).execute();

// Create
const created = await db.orgGetManagersRecord.create({ data: { userId: '<UUID>', depth: '<Int>' }, select: { id: true } }).execute();

// Update
const updated = await db.orgGetManagersRecord.update({ where: { id: '<UUID>' }, data: { userId: '<UUID>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.orgGetManagersRecord.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.orgGetSubordinatesRecord`

CRUD operations for OrgGetSubordinatesRecord records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `userId` | UUID | Yes |
| `depth` | Int | Yes |

**Operations:**

```typescript
// List all orgGetSubordinatesRecord records
const items = await db.orgGetSubordinatesRecord.findMany({ select: { userId: true, depth: true } }).execute();

// Get one by id
const item = await db.orgGetSubordinatesRecord.findOne({ id: '<UUID>', select: { userId: true, depth: true } }).execute();

// Create
const created = await db.orgGetSubordinatesRecord.create({ data: { userId: '<UUID>', depth: '<Int>' }, select: { id: true } }).execute();

// Update
const updated = await db.orgGetSubordinatesRecord.update({ where: { id: '<UUID>' }, data: { userId: '<UUID>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.orgGetSubordinatesRecord.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.appPermission`

CRUD operations for AppPermission records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `name` | String | Yes |
| `bitnum` | Int | Yes |
| `bitstr` | BitString | Yes |
| `description` | String | Yes |

**Operations:**

```typescript
// List all appPermission records
const items = await db.appPermission.findMany({ select: { id: true, name: true, bitnum: true, bitstr: true, description: true } }).execute();

// Get one by id
const item = await db.appPermission.findOne({ id: '<UUID>', select: { id: true, name: true, bitnum: true, bitstr: true, description: true } }).execute();

// Create
const created = await db.appPermission.create({ data: { name: '<String>', bitnum: '<Int>', bitstr: '<BitString>', description: '<String>' }, select: { id: true } }).execute();

// Update
const updated = await db.appPermission.update({ where: { id: '<UUID>' }, data: { name: '<String>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.appPermission.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.appPermissionDefaultGrant`

CRUD operations for AppPermissionDefaultGrant records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `permissionId` | UUID | Yes |
| `isGrant` | Boolean | Yes |
| `grantorId` | UUID | Yes |
| `createdAt` | Datetime | No |
| `updatedAt` | Datetime | No |

**Operations:**

```typescript
// List all appPermissionDefaultGrant records
const items = await db.appPermissionDefaultGrant.findMany({ select: { id: true, permissionId: true, isGrant: true, grantorId: true, createdAt: true, updatedAt: true } }).execute();

// Get one by id
const item = await db.appPermissionDefaultGrant.findOne({ id: '<UUID>', select: { id: true, permissionId: true, isGrant: true, grantorId: true, createdAt: true, updatedAt: true } }).execute();

// Create
const created = await db.appPermissionDefaultGrant.create({ data: { permissionId: '<UUID>', isGrant: '<Boolean>', grantorId: '<UUID>' }, select: { id: true } }).execute();

// Update
const updated = await db.appPermissionDefaultGrant.update({ where: { id: '<UUID>' }, data: { permissionId: '<UUID>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.appPermissionDefaultGrant.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.appMembership`

CRUD operations for AppMembership records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `createdAt` | Datetime | No |
| `updatedAt` | Datetime | No |
| `createdBy` | UUID | Yes |
| `updatedBy` | UUID | Yes |
| `isApproved` | Boolean | Yes |
| `isBanned` | Boolean | Yes |
| `isDisabled` | Boolean | Yes |
| `isVerified` | Boolean | Yes |
| `isActive` | Boolean | Yes |
| `isOwner` | Boolean | Yes |
| `isAdmin` | Boolean | Yes |
| `permissions` | BitString | Yes |
| `granted` | BitString | Yes |
| `actorId` | UUID | Yes |
| `profileId` | UUID | Yes |

**Operations:**

```typescript
// List all appMembership records
const items = await db.appMembership.findMany({ select: { id: true, createdAt: true, updatedAt: true, createdBy: true, updatedBy: true, isApproved: true, isBanned: true, isDisabled: true, isVerified: true, isActive: true, isOwner: true, isAdmin: true, permissions: true, granted: true, actorId: true, profileId: true } }).execute();

// Get one by id
const item = await db.appMembership.findOne({ id: '<UUID>', select: { id: true, createdAt: true, updatedAt: true, createdBy: true, updatedBy: true, isApproved: true, isBanned: true, isDisabled: true, isVerified: true, isActive: true, isOwner: true, isAdmin: true, permissions: true, granted: true, actorId: true, profileId: true } }).execute();

// Create
const created = await db.appMembership.create({ data: { createdBy: '<UUID>', updatedBy: '<UUID>', isApproved: '<Boolean>', isBanned: '<Boolean>', isDisabled: '<Boolean>', isVerified: '<Boolean>', isActive: '<Boolean>', isOwner: '<Boolean>', isAdmin: '<Boolean>', permissions: '<BitString>', granted: '<BitString>', actorId: '<UUID>', profileId: '<UUID>' }, select: { id: true } }).execute();

// Update
const updated = await db.appMembership.update({ where: { id: '<UUID>' }, data: { createdBy: '<UUID>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.appMembership.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.appProfilePermission`

CRUD operations for AppProfilePermission records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `profileId` | UUID | Yes |
| `permissionId` | UUID | Yes |
| `createdAt` | Datetime | No |
| `updatedAt` | Datetime | No |

**Operations:**

```typescript
// List all appProfilePermission records
const items = await db.appProfilePermission.findMany({ select: { id: true, profileId: true, permissionId: true, createdAt: true, updatedAt: true } }).execute();

// Get one by id
const item = await db.appProfilePermission.findOne({ id: '<UUID>', select: { id: true, profileId: true, permissionId: true, createdAt: true, updatedAt: true } }).execute();

// Create
const created = await db.appProfilePermission.create({ data: { profileId: '<UUID>', permissionId: '<UUID>' }, select: { id: true } }).execute();

// Update
const updated = await db.appProfilePermission.update({ where: { id: '<UUID>' }, data: { profileId: '<UUID>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.appProfilePermission.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.appProfileGrant`

CRUD operations for AppProfileGrant records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `membershipId` | UUID | Yes |
| `profileId` | UUID | Yes |
| `grantorId` | UUID | Yes |
| `isGrant` | Boolean | Yes |
| `createdAt` | Datetime | No |
| `updatedAt` | Datetime | No |

**Operations:**

```typescript
// List all appProfileGrant records
const items = await db.appProfileGrant.findMany({ select: { id: true, membershipId: true, profileId: true, grantorId: true, isGrant: true, createdAt: true, updatedAt: true } }).execute();

// Get one by id
const item = await db.appProfileGrant.findOne({ id: '<UUID>', select: { id: true, membershipId: true, profileId: true, grantorId: true, isGrant: true, createdAt: true, updatedAt: true } }).execute();

// Create
const created = await db.appProfileGrant.create({ data: { membershipId: '<UUID>', profileId: '<UUID>', grantorId: '<UUID>', isGrant: '<Boolean>' }, select: { id: true } }).execute();

// Update
const updated = await db.appProfileGrant.update({ where: { id: '<UUID>' }, data: { membershipId: '<UUID>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.appProfileGrant.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.appProfileDefinitionGrant`

CRUD operations for AppProfileDefinitionGrant records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `profileId` | UUID | Yes |
| `permissionId` | UUID | Yes |
| `grantorId` | UUID | Yes |
| `isGrant` | Boolean | Yes |
| `createdAt` | Datetime | No |
| `updatedAt` | Datetime | No |

**Operations:**

```typescript
// List all appProfileDefinitionGrant records
const items = await db.appProfileDefinitionGrant.findMany({ select: { id: true, profileId: true, permissionId: true, grantorId: true, isGrant: true, createdAt: true, updatedAt: true } }).execute();

// Get one by id
const item = await db.appProfileDefinitionGrant.findOne({ id: '<UUID>', select: { id: true, profileId: true, permissionId: true, grantorId: true, isGrant: true, createdAt: true, updatedAt: true } }).execute();

// Create
const created = await db.appProfileDefinitionGrant.create({ data: { profileId: '<UUID>', permissionId: '<UUID>', grantorId: '<UUID>', isGrant: '<Boolean>' }, select: { id: true } }).execute();

// Update
const updated = await db.appProfileDefinitionGrant.update({ where: { id: '<UUID>' }, data: { profileId: '<UUID>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.appProfileDefinitionGrant.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.appInvite`

CRUD operations for AppInvite records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `channel` | String | Yes |
| `email` | ConstructiveInternalTypeEmail | Yes |
| `phone` | String | Yes |
| `senderId` | UUID | Yes |
| `inviteToken` | String | Yes |
| `inviteValid` | Boolean | Yes |
| `inviteLimit` | Int | Yes |
| `inviteCount` | Int | Yes |
| `multiple` | Boolean | Yes |
| `data` | JSON | Yes |
| `profileId` | UUID | Yes |
| `expiresAt` | Datetime | Yes |
| `createdAt` | Datetime | No |
| `updatedAt` | Datetime | No |

**Operations:**

```typescript
// List all appInvite records
const items = await db.appInvite.findMany({ select: { id: true, channel: true, email: true, phone: true, senderId: true, inviteToken: true, inviteValid: true, inviteLimit: true, inviteCount: true, multiple: true, data: true, profileId: true, expiresAt: true, createdAt: true, updatedAt: true } }).execute();

// Get one by id
const item = await db.appInvite.findOne({ id: '<UUID>', select: { id: true, channel: true, email: true, phone: true, senderId: true, inviteToken: true, inviteValid: true, inviteLimit: true, inviteCount: true, multiple: true, data: true, profileId: true, expiresAt: true, createdAt: true, updatedAt: true } }).execute();

// Create
const created = await db.appInvite.create({ data: { channel: '<String>', email: '<Email>', phone: '<String>', senderId: '<UUID>', inviteToken: '<String>', inviteValid: '<Boolean>', inviteLimit: '<Int>', inviteCount: '<Int>', multiple: '<Boolean>', data: '<JSON>', profileId: '<UUID>', expiresAt: '<Datetime>' }, select: { id: true } }).execute();

// Update
const updated = await db.appInvite.update({ where: { id: '<UUID>' }, data: { channel: '<String>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.appInvite.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.appAdminGrant`

CRUD operations for AppAdminGrant records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `isGrant` | Boolean | Yes |
| `actorId` | UUID | Yes |
| `grantorId` | UUID | Yes |
| `createdAt` | Datetime | No |
| `updatedAt` | Datetime | No |

**Operations:**

```typescript
// List all appAdminGrant records
const items = await db.appAdminGrant.findMany({ select: { id: true, isGrant: true, actorId: true, grantorId: true, createdAt: true, updatedAt: true } }).execute();

// Get one by id
const item = await db.appAdminGrant.findOne({ id: '<UUID>', select: { id: true, isGrant: true, actorId: true, grantorId: true, createdAt: true, updatedAt: true } }).execute();

// Create
const created = await db.appAdminGrant.create({ data: { isGrant: '<Boolean>', actorId: '<UUID>', grantorId: '<UUID>' }, select: { id: true } }).execute();

// Update
const updated = await db.appAdminGrant.update({ where: { id: '<UUID>' }, data: { isGrant: '<Boolean>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.appAdminGrant.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.appOwnerGrant`

CRUD operations for AppOwnerGrant records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `isGrant` | Boolean | Yes |
| `actorId` | UUID | Yes |
| `grantorId` | UUID | Yes |
| `createdAt` | Datetime | No |
| `updatedAt` | Datetime | No |

**Operations:**

```typescript
// List all appOwnerGrant records
const items = await db.appOwnerGrant.findMany({ select: { id: true, isGrant: true, actorId: true, grantorId: true, createdAt: true, updatedAt: true } }).execute();

// Get one by id
const item = await db.appOwnerGrant.findOne({ id: '<UUID>', select: { id: true, isGrant: true, actorId: true, grantorId: true, createdAt: true, updatedAt: true } }).execute();

// Create
const created = await db.appOwnerGrant.create({ data: { isGrant: '<Boolean>', actorId: '<UUID>', grantorId: '<UUID>' }, select: { id: true } }).execute();

// Update
const updated = await db.appOwnerGrant.update({ where: { id: '<UUID>' }, data: { isGrant: '<Boolean>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.appOwnerGrant.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.appGrant`

CRUD operations for AppGrant records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `permissions` | BitString | Yes |
| `isGrant` | Boolean | Yes |
| `actorId` | UUID | Yes |
| `grantorId` | UUID | Yes |
| `createdAt` | Datetime | No |
| `updatedAt` | Datetime | No |

**Operations:**

```typescript
// List all appGrant records
const items = await db.appGrant.findMany({ select: { id: true, permissions: true, isGrant: true, actorId: true, grantorId: true, createdAt: true, updatedAt: true } }).execute();

// Get one by id
const item = await db.appGrant.findOne({ id: '<UUID>', select: { id: true, permissions: true, isGrant: true, actorId: true, grantorId: true, createdAt: true, updatedAt: true } }).execute();

// Create
const created = await db.appGrant.create({ data: { permissions: '<BitString>', isGrant: '<Boolean>', actorId: '<UUID>', grantorId: '<UUID>' }, select: { id: true } }).execute();

// Update
const updated = await db.appGrant.update({ where: { id: '<UUID>' }, data: { permissions: '<BitString>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.appGrant.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.orgMembership`

CRUD operations for OrgMembership records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `createdAt` | Datetime | No |
| `updatedAt` | Datetime | No |
| `createdBy` | UUID | Yes |
| `updatedBy` | UUID | Yes |
| `isApproved` | Boolean | Yes |
| `isBanned` | Boolean | Yes |
| `isDisabled` | Boolean | Yes |
| `isActive` | Boolean | Yes |
| `isExternal` | Boolean | Yes |
| `isOwner` | Boolean | Yes |
| `isAdmin` | Boolean | Yes |
| `permissions` | BitString | Yes |
| `granted` | BitString | Yes |
| `actorId` | UUID | Yes |
| `entityId` | UUID | Yes |
| `isReadOnly` | Boolean | Yes |
| `profileId` | UUID | Yes |

**Operations:**

```typescript
// List all orgMembership records
const items = await db.orgMembership.findMany({ select: { id: true, createdAt: true, updatedAt: true, createdBy: true, updatedBy: true, isApproved: true, isBanned: true, isDisabled: true, isActive: true, isExternal: true, isOwner: true, isAdmin: true, permissions: true, granted: true, actorId: true, entityId: true, isReadOnly: true, profileId: true } }).execute();

// Get one by id
const item = await db.orgMembership.findOne({ id: '<UUID>', select: { id: true, createdAt: true, updatedAt: true, createdBy: true, updatedBy: true, isApproved: true, isBanned: true, isDisabled: true, isActive: true, isExternal: true, isOwner: true, isAdmin: true, permissions: true, granted: true, actorId: true, entityId: true, isReadOnly: true, profileId: true } }).execute();

// Create
const created = await db.orgMembership.create({ data: { createdBy: '<UUID>', updatedBy: '<UUID>', isApproved: '<Boolean>', isBanned: '<Boolean>', isDisabled: '<Boolean>', isActive: '<Boolean>', isExternal: '<Boolean>', isOwner: '<Boolean>', isAdmin: '<Boolean>', permissions: '<BitString>', granted: '<BitString>', actorId: '<UUID>', entityId: '<UUID>', isReadOnly: '<Boolean>', profileId: '<UUID>' }, select: { id: true } }).execute();

// Update
const updated = await db.orgMembership.update({ where: { id: '<UUID>' }, data: { createdBy: '<UUID>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.orgMembership.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.orgProfilePermission`

CRUD operations for OrgProfilePermission records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `profileId` | UUID | Yes |
| `permissionId` | UUID | Yes |
| `createdAt` | Datetime | No |
| `updatedAt` | Datetime | No |

**Operations:**

```typescript
// List all orgProfilePermission records
const items = await db.orgProfilePermission.findMany({ select: { id: true, profileId: true, permissionId: true, createdAt: true, updatedAt: true } }).execute();

// Get one by id
const item = await db.orgProfilePermission.findOne({ id: '<UUID>', select: { id: true, profileId: true, permissionId: true, createdAt: true, updatedAt: true } }).execute();

// Create
const created = await db.orgProfilePermission.create({ data: { profileId: '<UUID>', permissionId: '<UUID>' }, select: { id: true } }).execute();

// Update
const updated = await db.orgProfilePermission.update({ where: { id: '<UUID>' }, data: { profileId: '<UUID>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.orgProfilePermission.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.orgPermissionDefaultPermission`

CRUD operations for OrgPermissionDefaultPermission records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `permissionId` | UUID | Yes |
| `entityId` | UUID | Yes |
| `createdAt` | Datetime | No |
| `updatedAt` | Datetime | No |

**Operations:**

```typescript
// List all orgPermissionDefaultPermission records
const items = await db.orgPermissionDefaultPermission.findMany({ select: { id: true, permissionId: true, entityId: true, createdAt: true, updatedAt: true } }).execute();

// Get one by id
const item = await db.orgPermissionDefaultPermission.findOne({ id: '<UUID>', select: { id: true, permissionId: true, entityId: true, createdAt: true, updatedAt: true } }).execute();

// Create
const created = await db.orgPermissionDefaultPermission.create({ data: { permissionId: '<UUID>', entityId: '<UUID>' }, select: { id: true } }).execute();

// Update
const updated = await db.orgPermissionDefaultPermission.update({ where: { id: '<UUID>' }, data: { permissionId: '<UUID>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.orgPermissionDefaultPermission.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.orgPermissionDefaultGrant`

CRUD operations for OrgPermissionDefaultGrant records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `permissionId` | UUID | Yes |
| `isGrant` | Boolean | Yes |
| `grantorId` | UUID | Yes |
| `entityId` | UUID | Yes |
| `createdAt` | Datetime | No |
| `updatedAt` | Datetime | No |

**Operations:**

```typescript
// List all orgPermissionDefaultGrant records
const items = await db.orgPermissionDefaultGrant.findMany({ select: { id: true, permissionId: true, isGrant: true, grantorId: true, entityId: true, createdAt: true, updatedAt: true } }).execute();

// Get one by id
const item = await db.orgPermissionDefaultGrant.findOne({ id: '<UUID>', select: { id: true, permissionId: true, isGrant: true, grantorId: true, entityId: true, createdAt: true, updatedAt: true } }).execute();

// Create
const created = await db.orgPermissionDefaultGrant.create({ data: { permissionId: '<UUID>', isGrant: '<Boolean>', grantorId: '<UUID>', entityId: '<UUID>' }, select: { id: true } }).execute();

// Update
const updated = await db.orgPermissionDefaultGrant.update({ where: { id: '<UUID>' }, data: { permissionId: '<UUID>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.orgPermissionDefaultGrant.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.orgProfileDefinitionGrant`

CRUD operations for OrgProfileDefinitionGrant records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `profileId` | UUID | Yes |
| `permissionId` | UUID | Yes |
| `grantorId` | UUID | Yes |
| `isGrant` | Boolean | Yes |
| `createdAt` | Datetime | No |
| `updatedAt` | Datetime | No |

**Operations:**

```typescript
// List all orgProfileDefinitionGrant records
const items = await db.orgProfileDefinitionGrant.findMany({ select: { id: true, profileId: true, permissionId: true, grantorId: true, isGrant: true, createdAt: true, updatedAt: true } }).execute();

// Get one by id
const item = await db.orgProfileDefinitionGrant.findOne({ id: '<UUID>', select: { id: true, profileId: true, permissionId: true, grantorId: true, isGrant: true, createdAt: true, updatedAt: true } }).execute();

// Create
const created = await db.orgProfileDefinitionGrant.create({ data: { profileId: '<UUID>', permissionId: '<UUID>', grantorId: '<UUID>', isGrant: '<Boolean>' }, select: { id: true } }).execute();

// Update
const updated = await db.orgProfileDefinitionGrant.update({ where: { id: '<UUID>' }, data: { profileId: '<UUID>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.orgProfileDefinitionGrant.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.orgProfileGrant`

CRUD operations for OrgProfileGrant records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `membershipId` | UUID | Yes |
| `profileId` | UUID | Yes |
| `entityId` | UUID | Yes |
| `grantorId` | UUID | Yes |
| `isGrant` | Boolean | Yes |
| `createdAt` | Datetime | No |
| `updatedAt` | Datetime | No |

**Operations:**

```typescript
// List all orgProfileGrant records
const items = await db.orgProfileGrant.findMany({ select: { id: true, membershipId: true, profileId: true, entityId: true, grantorId: true, isGrant: true, createdAt: true, updatedAt: true } }).execute();

// Get one by id
const item = await db.orgProfileGrant.findOne({ id: '<UUID>', select: { id: true, membershipId: true, profileId: true, entityId: true, grantorId: true, isGrant: true, createdAt: true, updatedAt: true } }).execute();

// Create
const created = await db.orgProfileGrant.create({ data: { membershipId: '<UUID>', profileId: '<UUID>', entityId: '<UUID>', grantorId: '<UUID>', isGrant: '<Boolean>' }, select: { id: true } }).execute();

// Update
const updated = await db.orgProfileGrant.update({ where: { id: '<UUID>' }, data: { membershipId: '<UUID>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.orgProfileGrant.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.orgInvite`

CRUD operations for OrgInvite records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `channel` | String | Yes |
| `email` | ConstructiveInternalTypeEmail | Yes |
| `phone` | String | Yes |
| `senderId` | UUID | Yes |
| `receiverId` | UUID | Yes |
| `inviteToken` | String | Yes |
| `inviteValid` | Boolean | Yes |
| `inviteLimit` | Int | Yes |
| `inviteCount` | Int | Yes |
| `multiple` | Boolean | Yes |
| `data` | JSON | Yes |
| `profileId` | UUID | Yes |
| `isReadOnly` | Boolean | Yes |
| `expiresAt` | Datetime | Yes |
| `createdAt` | Datetime | No |
| `updatedAt` | Datetime | No |
| `entityId` | UUID | Yes |

**Operations:**

```typescript
// List all orgInvite records
const items = await db.orgInvite.findMany({ select: { id: true, channel: true, email: true, phone: true, senderId: true, receiverId: true, inviteToken: true, inviteValid: true, inviteLimit: true, inviteCount: true, multiple: true, data: true, profileId: true, isReadOnly: true, expiresAt: true, createdAt: true, updatedAt: true, entityId: true } }).execute();

// Get one by id
const item = await db.orgInvite.findOne({ id: '<UUID>', select: { id: true, channel: true, email: true, phone: true, senderId: true, receiverId: true, inviteToken: true, inviteValid: true, inviteLimit: true, inviteCount: true, multiple: true, data: true, profileId: true, isReadOnly: true, expiresAt: true, createdAt: true, updatedAt: true, entityId: true } }).execute();

// Create
const created = await db.orgInvite.create({ data: { channel: '<String>', email: '<Email>', phone: '<String>', senderId: '<UUID>', receiverId: '<UUID>', inviteToken: '<String>', inviteValid: '<Boolean>', inviteLimit: '<Int>', inviteCount: '<Int>', multiple: '<Boolean>', data: '<JSON>', profileId: '<UUID>', isReadOnly: '<Boolean>', expiresAt: '<Datetime>', entityId: '<UUID>' }, select: { id: true } }).execute();

// Update
const updated = await db.orgInvite.update({ where: { id: '<UUID>' }, data: { channel: '<String>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.orgInvite.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.orgMember`

CRUD operations for OrgMember records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `isAdmin` | Boolean | Yes |
| `actorId` | UUID | Yes |
| `entityId` | UUID | Yes |

**Operations:**

```typescript
// List all orgMember records
const items = await db.orgMember.findMany({ select: { id: true, isAdmin: true, actorId: true, entityId: true } }).execute();

// Get one by id
const item = await db.orgMember.findOne({ id: '<UUID>', select: { id: true, isAdmin: true, actorId: true, entityId: true } }).execute();

// Create
const created = await db.orgMember.create({ data: { isAdmin: '<Boolean>', actorId: '<UUID>', entityId: '<UUID>' }, select: { id: true } }).execute();

// Update
const updated = await db.orgMember.update({ where: { id: '<UUID>' }, data: { isAdmin: '<Boolean>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.orgMember.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.orgAdminGrant`

CRUD operations for OrgAdminGrant records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `isGrant` | Boolean | Yes |
| `actorId` | UUID | Yes |
| `entityId` | UUID | Yes |
| `grantorId` | UUID | Yes |
| `createdAt` | Datetime | No |
| `updatedAt` | Datetime | No |

**Operations:**

```typescript
// List all orgAdminGrant records
const items = await db.orgAdminGrant.findMany({ select: { id: true, isGrant: true, actorId: true, entityId: true, grantorId: true, createdAt: true, updatedAt: true } }).execute();

// Get one by id
const item = await db.orgAdminGrant.findOne({ id: '<UUID>', select: { id: true, isGrant: true, actorId: true, entityId: true, grantorId: true, createdAt: true, updatedAt: true } }).execute();

// Create
const created = await db.orgAdminGrant.create({ data: { isGrant: '<Boolean>', actorId: '<UUID>', entityId: '<UUID>', grantorId: '<UUID>' }, select: { id: true } }).execute();

// Update
const updated = await db.orgAdminGrant.update({ where: { id: '<UUID>' }, data: { isGrant: '<Boolean>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.orgAdminGrant.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.orgOwnerGrant`

CRUD operations for OrgOwnerGrant records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `isGrant` | Boolean | Yes |
| `actorId` | UUID | Yes |
| `entityId` | UUID | Yes |
| `grantorId` | UUID | Yes |
| `createdAt` | Datetime | No |
| `updatedAt` | Datetime | No |

**Operations:**

```typescript
// List all orgOwnerGrant records
const items = await db.orgOwnerGrant.findMany({ select: { id: true, isGrant: true, actorId: true, entityId: true, grantorId: true, createdAt: true, updatedAt: true } }).execute();

// Get one by id
const item = await db.orgOwnerGrant.findOne({ id: '<UUID>', select: { id: true, isGrant: true, actorId: true, entityId: true, grantorId: true, createdAt: true, updatedAt: true } }).execute();

// Create
const created = await db.orgOwnerGrant.create({ data: { isGrant: '<Boolean>', actorId: '<UUID>', entityId: '<UUID>', grantorId: '<UUID>' }, select: { id: true } }).execute();

// Update
const updated = await db.orgOwnerGrant.update({ where: { id: '<UUID>' }, data: { isGrant: '<Boolean>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.orgOwnerGrant.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.orgMemberProfile`

CRUD operations for OrgMemberProfile records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `createdAt` | Datetime | No |
| `updatedAt` | Datetime | No |
| `membershipId` | UUID | Yes |
| `entityId` | UUID | Yes |
| `actorId` | UUID | Yes |
| `displayName` | String | Yes |
| `email` | String | Yes |
| `title` | String | Yes |
| `bio` | String | Yes |
| `profilePicture` | ConstructiveInternalTypeImage | Yes |

**Operations:**

```typescript
// List all orgMemberProfile records
const items = await db.orgMemberProfile.findMany({ select: { id: true, createdAt: true, updatedAt: true, membershipId: true, entityId: true, actorId: true, displayName: true, email: true, title: true, bio: true, profilePicture: true } }).execute();

// Get one by id
const item = await db.orgMemberProfile.findOne({ id: '<UUID>', select: { id: true, createdAt: true, updatedAt: true, membershipId: true, entityId: true, actorId: true, displayName: true, email: true, title: true, bio: true, profilePicture: true } }).execute();

// Create
const created = await db.orgMemberProfile.create({ data: { membershipId: '<UUID>', entityId: '<UUID>', actorId: '<UUID>', displayName: '<String>', email: '<String>', title: '<String>', bio: '<String>', profilePicture: '<Image>' }, select: { id: true } }).execute();

// Update
const updated = await db.orgMemberProfile.update({ where: { id: '<UUID>' }, data: { membershipId: '<UUID>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.orgMemberProfile.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.orgGrant`

CRUD operations for OrgGrant records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `permissions` | BitString | Yes |
| `isGrant` | Boolean | Yes |
| `actorId` | UUID | Yes |
| `entityId` | UUID | Yes |
| `grantorId` | UUID | Yes |
| `createdAt` | Datetime | No |
| `updatedAt` | Datetime | No |

**Operations:**

```typescript
// List all orgGrant records
const items = await db.orgGrant.findMany({ select: { id: true, permissions: true, isGrant: true, actorId: true, entityId: true, grantorId: true, createdAt: true, updatedAt: true } }).execute();

// Get one by id
const item = await db.orgGrant.findOne({ id: '<UUID>', select: { id: true, permissions: true, isGrant: true, actorId: true, entityId: true, grantorId: true, createdAt: true, updatedAt: true } }).execute();

// Create
const created = await db.orgGrant.create({ data: { permissions: '<BitString>', isGrant: '<Boolean>', actorId: '<UUID>', entityId: '<UUID>', grantorId: '<UUID>' }, select: { id: true } }).execute();

// Update
const updated = await db.orgGrant.update({ where: { id: '<UUID>' }, data: { permissions: '<BitString>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.orgGrant.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.orgChartEdge`

CRUD operations for OrgChartEdge records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `createdAt` | Datetime | No |
| `updatedAt` | Datetime | No |
| `entityId` | UUID | Yes |
| `childId` | UUID | Yes |
| `parentId` | UUID | Yes |
| `positionTitle` | String | Yes |
| `positionLevel` | Int | Yes |

**Operations:**

```typescript
// List all orgChartEdge records
const items = await db.orgChartEdge.findMany({ select: { id: true, createdAt: true, updatedAt: true, entityId: true, childId: true, parentId: true, positionTitle: true, positionLevel: true } }).execute();

// Get one by id
const item = await db.orgChartEdge.findOne({ id: '<UUID>', select: { id: true, createdAt: true, updatedAt: true, entityId: true, childId: true, parentId: true, positionTitle: true, positionLevel: true } }).execute();

// Create
const created = await db.orgChartEdge.create({ data: { entityId: '<UUID>', childId: '<UUID>', parentId: '<UUID>', positionTitle: '<String>', positionLevel: '<Int>' }, select: { id: true } }).execute();

// Update
const updated = await db.orgChartEdge.update({ where: { id: '<UUID>' }, data: { entityId: '<UUID>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.orgChartEdge.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.orgChartEdgeGrant`

CRUD operations for OrgChartEdgeGrant records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `entityId` | UUID | Yes |
| `childId` | UUID | Yes |
| `parentId` | UUID | Yes |
| `grantorId` | UUID | Yes |
| `isGrant` | Boolean | Yes |
| `positionTitle` | String | Yes |
| `positionLevel` | Int | Yes |
| `createdAt` | Datetime | No |

**Operations:**

```typescript
// List all orgChartEdgeGrant records
const items = await db.orgChartEdgeGrant.findMany({ select: { id: true, entityId: true, childId: true, parentId: true, grantorId: true, isGrant: true, positionTitle: true, positionLevel: true, createdAt: true } }).execute();

// Get one by id
const item = await db.orgChartEdgeGrant.findOne({ id: '<UUID>', select: { id: true, entityId: true, childId: true, parentId: true, grantorId: true, isGrant: true, positionTitle: true, positionLevel: true, createdAt: true } }).execute();

// Create
const created = await db.orgChartEdgeGrant.create({ data: { entityId: '<UUID>', childId: '<UUID>', parentId: '<UUID>', grantorId: '<UUID>', isGrant: '<Boolean>', positionTitle: '<String>', positionLevel: '<Int>' }, select: { id: true } }).execute();

// Update
const updated = await db.orgChartEdgeGrant.update({ where: { id: '<UUID>' }, data: { entityId: '<UUID>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.orgChartEdgeGrant.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.orgPermissionDefault`

CRUD operations for OrgPermissionDefault records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `permissions` | BitString | Yes |
| `entityId` | UUID | Yes |

**Operations:**

```typescript
// List all orgPermissionDefault records
const items = await db.orgPermissionDefault.findMany({ select: { id: true, permissions: true, entityId: true } }).execute();

// Get one by id
const item = await db.orgPermissionDefault.findOne({ id: '<UUID>', select: { id: true, permissions: true, entityId: true } }).execute();

// Create
const created = await db.orgPermissionDefault.create({ data: { permissions: '<BitString>', entityId: '<UUID>' }, select: { id: true } }).execute();

// Update
const updated = await db.orgPermissionDefault.update({ where: { id: '<UUID>' }, data: { permissions: '<BitString>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.orgPermissionDefault.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.appLimit`

CRUD operations for AppLimit records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `name` | String | Yes |
| `actorId` | UUID | Yes |
| `num` | BigInt | Yes |
| `max` | BigInt | Yes |
| `softMax` | BigInt | Yes |
| `windowStart` | Datetime | Yes |
| `windowDuration` | Interval | Yes |
| `planMax` | BigInt | Yes |
| `purchasedCredits` | BigInt | Yes |
| `periodCredits` | BigInt | Yes |
| `organizationId` | UUID | Yes |
| `entityType` | String | Yes |

**Operations:**

```typescript
// List all appLimit records
const items = await db.appLimit.findMany({ select: { id: true, name: true, actorId: true, num: true, max: true, softMax: true, windowStart: true, windowDuration: true, planMax: true, purchasedCredits: true, periodCredits: true, organizationId: true, entityType: true } }).execute();

// Get one by id
const item = await db.appLimit.findOne({ id: '<UUID>', select: { id: true, name: true, actorId: true, num: true, max: true, softMax: true, windowStart: true, windowDuration: true, planMax: true, purchasedCredits: true, periodCredits: true, organizationId: true, entityType: true } }).execute();

// Create
const created = await db.appLimit.create({ data: { name: '<String>', actorId: '<UUID>', num: '<BigInt>', max: '<BigInt>', softMax: '<BigInt>', windowStart: '<Datetime>', windowDuration: '<Interval>', planMax: '<BigInt>', purchasedCredits: '<BigInt>', periodCredits: '<BigInt>', organizationId: '<UUID>', entityType: '<String>' }, select: { id: true } }).execute();

// Update
const updated = await db.appLimit.update({ where: { id: '<UUID>' }, data: { name: '<String>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.appLimit.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.appLimitCredit`

CRUD operations for AppLimitCredit records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `defaultLimitId` | UUID | Yes |
| `actorId` | UUID | Yes |
| `amount` | BigInt | Yes |
| `creditType` | String | Yes |
| `reason` | String | Yes |

**Operations:**

```typescript
// List all appLimitCredit records
const items = await db.appLimitCredit.findMany({ select: { id: true, defaultLimitId: true, actorId: true, amount: true, creditType: true, reason: true } }).execute();

// Get one by id
const item = await db.appLimitCredit.findOne({ id: '<UUID>', select: { id: true, defaultLimitId: true, actorId: true, amount: true, creditType: true, reason: true } }).execute();

// Create
const created = await db.appLimitCredit.create({ data: { defaultLimitId: '<UUID>', actorId: '<UUID>', amount: '<BigInt>', creditType: '<String>', reason: '<String>' }, select: { id: true } }).execute();

// Update
const updated = await db.appLimitCredit.update({ where: { id: '<UUID>' }, data: { defaultLimitId: '<UUID>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.appLimitCredit.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.appLimitCreditCodeItem`

CRUD operations for AppLimitCreditCodeItem records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `creditCodeId` | UUID | Yes |
| `defaultLimitId` | UUID | Yes |
| `amount` | BigInt | Yes |
| `creditType` | String | Yes |

**Operations:**

```typescript
// List all appLimitCreditCodeItem records
const items = await db.appLimitCreditCodeItem.findMany({ select: { id: true, creditCodeId: true, defaultLimitId: true, amount: true, creditType: true } }).execute();

// Get one by id
const item = await db.appLimitCreditCodeItem.findOne({ id: '<UUID>', select: { id: true, creditCodeId: true, defaultLimitId: true, amount: true, creditType: true } }).execute();

// Create
const created = await db.appLimitCreditCodeItem.create({ data: { creditCodeId: '<UUID>', defaultLimitId: '<UUID>', amount: '<BigInt>', creditType: '<String>' }, select: { id: true } }).execute();

// Update
const updated = await db.appLimitCreditCodeItem.update({ where: { id: '<UUID>' }, data: { creditCodeId: '<UUID>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.appLimitCreditCodeItem.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.appLimitCreditRedemption`

CRUD operations for AppLimitCreditRedemption records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `creditCodeId` | UUID | Yes |
| `entityId` | UUID | Yes |
| `organizationId` | UUID | Yes |
| `entityType` | String | Yes |

**Operations:**

```typescript
// List all appLimitCreditRedemption records
const items = await db.appLimitCreditRedemption.findMany({ select: { id: true, creditCodeId: true, entityId: true, organizationId: true, entityType: true } }).execute();

// Get one by id
const item = await db.appLimitCreditRedemption.findOne({ id: '<UUID>', select: { id: true, creditCodeId: true, entityId: true, organizationId: true, entityType: true } }).execute();

// Create
const created = await db.appLimitCreditRedemption.create({ data: { creditCodeId: '<UUID>', entityId: '<UUID>', organizationId: '<UUID>', entityType: '<String>' }, select: { id: true } }).execute();

// Update
const updated = await db.appLimitCreditRedemption.update({ where: { id: '<UUID>' }, data: { creditCodeId: '<UUID>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.appLimitCreditRedemption.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.orgLimit`

CRUD operations for OrgLimit records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `name` | String | Yes |
| `actorId` | UUID | Yes |
| `num` | BigInt | Yes |
| `max` | BigInt | Yes |
| `softMax` | BigInt | Yes |
| `windowStart` | Datetime | Yes |
| `windowDuration` | Interval | Yes |
| `planMax` | BigInt | Yes |
| `purchasedCredits` | BigInt | Yes |
| `periodCredits` | BigInt | Yes |
| `entityId` | UUID | Yes |
| `organizationId` | UUID | Yes |
| `entityType` | String | Yes |

**Operations:**

```typescript
// List all orgLimit records
const items = await db.orgLimit.findMany({ select: { id: true, name: true, actorId: true, num: true, max: true, softMax: true, windowStart: true, windowDuration: true, planMax: true, purchasedCredits: true, periodCredits: true, entityId: true, organizationId: true, entityType: true } }).execute();

// Get one by id
const item = await db.orgLimit.findOne({ id: '<UUID>', select: { id: true, name: true, actorId: true, num: true, max: true, softMax: true, windowStart: true, windowDuration: true, planMax: true, purchasedCredits: true, periodCredits: true, entityId: true, organizationId: true, entityType: true } }).execute();

// Create
const created = await db.orgLimit.create({ data: { name: '<String>', actorId: '<UUID>', num: '<BigInt>', max: '<BigInt>', softMax: '<BigInt>', windowStart: '<Datetime>', windowDuration: '<Interval>', planMax: '<BigInt>', purchasedCredits: '<BigInt>', periodCredits: '<BigInt>', entityId: '<UUID>', organizationId: '<UUID>', entityType: '<String>' }, select: { id: true } }).execute();

// Update
const updated = await db.orgLimit.update({ where: { id: '<UUID>' }, data: { name: '<String>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.orgLimit.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.orgLimitCredit`

CRUD operations for OrgLimitCredit records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `defaultLimitId` | UUID | Yes |
| `actorId` | UUID | Yes |
| `entityId` | UUID | Yes |
| `organizationId` | UUID | Yes |
| `entityType` | String | Yes |
| `amount` | BigInt | Yes |
| `creditType` | String | Yes |
| `reason` | String | Yes |

**Operations:**

```typescript
// List all orgLimitCredit records
const items = await db.orgLimitCredit.findMany({ select: { id: true, defaultLimitId: true, actorId: true, entityId: true, organizationId: true, entityType: true, amount: true, creditType: true, reason: true } }).execute();

// Get one by id
const item = await db.orgLimitCredit.findOne({ id: '<UUID>', select: { id: true, defaultLimitId: true, actorId: true, entityId: true, organizationId: true, entityType: true, amount: true, creditType: true, reason: true } }).execute();

// Create
const created = await db.orgLimitCredit.create({ data: { defaultLimitId: '<UUID>', actorId: '<UUID>', entityId: '<UUID>', organizationId: '<UUID>', entityType: '<String>', amount: '<BigInt>', creditType: '<String>', reason: '<String>' }, select: { id: true } }).execute();

// Update
const updated = await db.orgLimitCredit.update({ where: { id: '<UUID>' }, data: { defaultLimitId: '<UUID>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.orgLimitCredit.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.orgLimitAggregate`

CRUD operations for OrgLimitAggregate records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `name` | String | Yes |
| `entityId` | UUID | Yes |
| `num` | BigInt | Yes |
| `max` | BigInt | Yes |
| `softMax` | BigInt | Yes |
| `windowStart` | Datetime | Yes |
| `windowDuration` | Interval | Yes |
| `planMax` | BigInt | Yes |
| `purchasedCredits` | BigInt | Yes |
| `periodCredits` | BigInt | Yes |
| `reserved` | BigInt | Yes |
| `organizationId` | UUID | Yes |
| `entityType` | String | Yes |

**Operations:**

```typescript
// List all orgLimitAggregate records
const items = await db.orgLimitAggregate.findMany({ select: { id: true, name: true, entityId: true, num: true, max: true, softMax: true, windowStart: true, windowDuration: true, planMax: true, purchasedCredits: true, periodCredits: true, reserved: true, organizationId: true, entityType: true } }).execute();

// Get one by id
const item = await db.orgLimitAggregate.findOne({ id: '<UUID>', select: { id: true, name: true, entityId: true, num: true, max: true, softMax: true, windowStart: true, windowDuration: true, planMax: true, purchasedCredits: true, periodCredits: true, reserved: true, organizationId: true, entityType: true } }).execute();

// Create
const created = await db.orgLimitAggregate.create({ data: { name: '<String>', entityId: '<UUID>', num: '<BigInt>', max: '<BigInt>', softMax: '<BigInt>', windowStart: '<Datetime>', windowDuration: '<Interval>', planMax: '<BigInt>', purchasedCredits: '<BigInt>', periodCredits: '<BigInt>', reserved: '<BigInt>', organizationId: '<UUID>', entityType: '<String>' }, select: { id: true } }).execute();

// Update
const updated = await db.orgLimitAggregate.update({ where: { id: '<UUID>' }, data: { name: '<String>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.orgLimitAggregate.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.orgLimitWarning`

CRUD operations for OrgLimitWarning records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `name` | String | Yes |
| `warningType` | String | Yes |
| `thresholdValue` | BigInt | Yes |
| `taskIdentifier` | String | Yes |
| `entityId` | UUID | Yes |

**Operations:**

```typescript
// List all orgLimitWarning records
const items = await db.orgLimitWarning.findMany({ select: { id: true, name: true, warningType: true, thresholdValue: true, taskIdentifier: true, entityId: true } }).execute();

// Get one by id
const item = await db.orgLimitWarning.findOne({ id: '<UUID>', select: { id: true, name: true, warningType: true, thresholdValue: true, taskIdentifier: true, entityId: true } }).execute();

// Create
const created = await db.orgLimitWarning.create({ data: { name: '<String>', warningType: '<String>', thresholdValue: '<BigInt>', taskIdentifier: '<String>', entityId: '<UUID>' }, select: { id: true } }).execute();

// Update
const updated = await db.orgLimitWarning.update({ where: { id: '<UUID>' }, data: { name: '<String>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.orgLimitWarning.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.orgProfile`

CRUD operations for OrgProfile records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `name` | String | Yes |
| `slug` | String | Yes |
| `description` | String | Yes |
| `permissions` | BitString | Yes |
| `isSystem` | Boolean | Yes |
| `isDefault` | Boolean | Yes |
| `createdAt` | Datetime | No |
| `updatedAt` | Datetime | No |
| `entityId` | UUID | Yes |

**Operations:**

```typescript
// List all orgProfile records
const items = await db.orgProfile.findMany({ select: { id: true, name: true, slug: true, description: true, permissions: true, isSystem: true, isDefault: true, createdAt: true, updatedAt: true, entityId: true } }).execute();

// Get one by id
const item = await db.orgProfile.findOne({ id: '<UUID>', select: { id: true, name: true, slug: true, description: true, permissions: true, isSystem: true, isDefault: true, createdAt: true, updatedAt: true, entityId: true } }).execute();

// Create
const created = await db.orgProfile.create({ data: { name: '<String>', slug: '<String>', description: '<String>', permissions: '<BitString>', isSystem: '<Boolean>', isDefault: '<Boolean>', entityId: '<UUID>' }, select: { id: true } }).execute();

// Update
const updated = await db.orgProfile.update({ where: { id: '<UUID>' }, data: { name: '<String>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.orgProfile.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.principal`

CRUD operations for Principal records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | Yes |
| `createdAt` | Datetime | No |
| `updatedAt` | Datetime | No |
| `ownerId` | UUID | Yes |
| `userId` | UUID | Yes |
| `name` | String | Yes |
| `useAdminOwner` | Boolean | Yes |
| `isReadOnly` | Boolean | Yes |
| `bypassStepUp` | Boolean | Yes |

**Operations:**

```typescript
// List all principal records
const items = await db.principal.findMany({ select: { id: true, createdAt: true, updatedAt: true, ownerId: true, userId: true, name: true, useAdminOwner: true, isReadOnly: true, bypassStepUp: true } }).execute();

// Get one by principalId
const item = await db.principal.findOne({ principalId: '<UUID>', select: { id: true, createdAt: true, updatedAt: true, ownerId: true, userId: true, name: true, useAdminOwner: true, isReadOnly: true, bypassStepUp: true } }).execute();

// Create
const created = await db.principal.create({ data: { id: '<UUID>', ownerId: '<UUID>', userId: '<UUID>', name: '<String>', useAdminOwner: '<Boolean>', isReadOnly: '<Boolean>', bypassStepUp: '<Boolean>' }, select: { principalId: true } }).execute();

// Update
const updated = await db.principal.update({ where: { principalId: '<UUID>' }, data: { id: '<UUID>' }, select: { principalId: true } }).execute();

// Delete
const deleted = await db.principal.delete({ where: { principalId: '<UUID>' } }).execute();
```

### `db.principalEntity`

CRUD operations for PrincipalEntity records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `createdAt` | Datetime | No |
| `updatedAt` | Datetime | No |
| `principalId` | UUID | Yes |
| `entityId` | UUID | Yes |
| `ownerId` | UUID | Yes |

**Operations:**

```typescript
// List all principalEntity records
const items = await db.principalEntity.findMany({ select: { id: true, createdAt: true, updatedAt: true, principalId: true, entityId: true, ownerId: true } }).execute();

// Get one by id
const item = await db.principalEntity.findOne({ id: '<UUID>', select: { id: true, createdAt: true, updatedAt: true, principalId: true, entityId: true, ownerId: true } }).execute();

// Create
const created = await db.principalEntity.create({ data: { principalId: '<UUID>', entityId: '<UUID>', ownerId: '<UUID>' }, select: { id: true } }).execute();

// Update
const updated = await db.principalEntity.update({ where: { id: '<UUID>' }, data: { principalId: '<UUID>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.principalEntity.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.principalScopeOverride`

CRUD operations for PrincipalScopeOverride records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `createdAt` | Datetime | No |
| `updatedAt` | Datetime | No |
| `principalId` | UUID | Yes |
| `membershipType` | Int | Yes |
| `allowedMask` | BitString | Yes |
| `useAdminOwner` | Boolean | Yes |
| `isActive` | Boolean | Yes |
| `isReadOnly` | Boolean | Yes |

**Operations:**

```typescript
// List all principalScopeOverride records
const items = await db.principalScopeOverride.findMany({ select: { id: true, createdAt: true, updatedAt: true, principalId: true, membershipType: true, allowedMask: true, useAdminOwner: true, isActive: true, isReadOnly: true } }).execute();

// Get one by id
const item = await db.principalScopeOverride.findOne({ id: '<UUID>', select: { id: true, createdAt: true, updatedAt: true, principalId: true, membershipType: true, allowedMask: true, useAdminOwner: true, isActive: true, isReadOnly: true } }).execute();

// Create
const created = await db.principalScopeOverride.create({ data: { principalId: '<UUID>', membershipType: '<Int>', allowedMask: '<BitString>', useAdminOwner: '<Boolean>', isActive: '<Boolean>', isReadOnly: '<Boolean>' }, select: { id: true } }).execute();

// Update
const updated = await db.principalScopeOverride.update({ where: { id: '<UUID>' }, data: { principalId: '<UUID>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.principalScopeOverride.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.email`

CRUD operations for Email records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `ownerId` | UUID | Yes |
| `email` | ConstructiveInternalTypeEmail | Yes |
| `isVerified` | Boolean | Yes |
| `isPrimary` | Boolean | Yes |
| `name` | String | Yes |
| `createdAt` | Datetime | No |
| `updatedAt` | Datetime | No |

**Operations:**

```typescript
// List all email records
const items = await db.email.findMany({ select: { id: true, ownerId: true, email: true, isVerified: true, isPrimary: true, name: true, createdAt: true, updatedAt: true } }).execute();

// Get one by id
const item = await db.email.findOne({ id: '<UUID>', select: { id: true, ownerId: true, email: true, isVerified: true, isPrimary: true, name: true, createdAt: true, updatedAt: true } }).execute();

// Create
const created = await db.email.create({ data: { ownerId: '<UUID>', email: '<Email>', isVerified: '<Boolean>', isPrimary: '<Boolean>', name: '<String>' }, select: { id: true } }).execute();

// Update
const updated = await db.email.update({ where: { id: '<UUID>' }, data: { ownerId: '<UUID>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.email.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.phoneNumber`

CRUD operations for PhoneNumber records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `ownerId` | UUID | Yes |
| `cc` | String | Yes |
| `number` | String | Yes |
| `isVerified` | Boolean | Yes |
| `isPrimary` | Boolean | Yes |
| `name` | String | Yes |
| `createdAt` | Datetime | No |
| `updatedAt` | Datetime | No |

**Operations:**

```typescript
// List all phoneNumber records
const items = await db.phoneNumber.findMany({ select: { id: true, ownerId: true, cc: true, number: true, isVerified: true, isPrimary: true, name: true, createdAt: true, updatedAt: true } }).execute();

// Get one by id
const item = await db.phoneNumber.findOne({ id: '<UUID>', select: { id: true, ownerId: true, cc: true, number: true, isVerified: true, isPrimary: true, name: true, createdAt: true, updatedAt: true } }).execute();

// Create
const created = await db.phoneNumber.create({ data: { ownerId: '<UUID>', cc: '<String>', number: '<String>', isVerified: '<Boolean>', isPrimary: '<Boolean>', name: '<String>' }, select: { id: true } }).execute();

// Update
const updated = await db.phoneNumber.update({ where: { id: '<UUID>' }, data: { ownerId: '<UUID>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.phoneNumber.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.webauthnCredential`

CRUD operations for WebauthnCredential records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `ownerId` | UUID | Yes |
| `credentialId` | String | Yes |
| `publicKey` | Base64EncodedBinary | Yes |
| `signCount` | BigInt | Yes |
| `webauthnUserId` | String | Yes |
| `transports` | String | Yes |
| `credentialDeviceType` | String | Yes |
| `backupEligible` | Boolean | Yes |
| `backupState` | Boolean | Yes |
| `name` | String | Yes |
| `lastUsedAt` | Datetime | Yes |
| `createdAt` | Datetime | No |
| `updatedAt` | Datetime | No |

**Operations:**

```typescript
// List all webauthnCredential records
const items = await db.webauthnCredential.findMany({ select: { id: true, ownerId: true, credentialId: true, publicKey: true, signCount: true, webauthnUserId: true, transports: true, credentialDeviceType: true, backupEligible: true, backupState: true, name: true, lastUsedAt: true, createdAt: true, updatedAt: true } }).execute();

// Get one by id
const item = await db.webauthnCredential.findOne({ id: '<UUID>', select: { id: true, ownerId: true, credentialId: true, publicKey: true, signCount: true, webauthnUserId: true, transports: true, credentialDeviceType: true, backupEligible: true, backupState: true, name: true, lastUsedAt: true, createdAt: true, updatedAt: true } }).execute();

// Create
const created = await db.webauthnCredential.create({ data: { ownerId: '<UUID>', credentialId: '<String>', publicKey: '<Base64EncodedBinary>', signCount: '<BigInt>', webauthnUserId: '<String>', transports: '<String>', credentialDeviceType: '<String>', backupEligible: '<Boolean>', backupState: '<Boolean>', name: '<String>', lastUsedAt: '<Datetime>' }, select: { id: true } }).execute();

// Update
const updated = await db.webauthnCredential.update({ where: { id: '<UUID>' }, data: { ownerId: '<UUID>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.webauthnCredential.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.appClaimedInvite`

CRUD operations for AppClaimedInvite records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `data` | JSON | Yes |
| `senderId` | UUID | Yes |
| `receiverId` | UUID | Yes |
| `createdAt` | Datetime | No |
| `updatedAt` | Datetime | No |

**Operations:**

```typescript
// List all appClaimedInvite records
const items = await db.appClaimedInvite.findMany({ select: { id: true, data: true, senderId: true, receiverId: true, createdAt: true, updatedAt: true } }).execute();

// Get one by id
const item = await db.appClaimedInvite.findOne({ id: '<UUID>', select: { id: true, data: true, senderId: true, receiverId: true, createdAt: true, updatedAt: true } }).execute();

// Create
const created = await db.appClaimedInvite.create({ data: { data: '<JSON>', senderId: '<UUID>', receiverId: '<UUID>' }, select: { id: true } }).execute();

// Update
const updated = await db.appClaimedInvite.update({ where: { id: '<UUID>' }, data: { data: '<JSON>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.appClaimedInvite.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.orgClaimedInvite`

CRUD operations for OrgClaimedInvite records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `data` | JSON | Yes |
| `senderId` | UUID | Yes |
| `receiverId` | UUID | Yes |
| `createdAt` | Datetime | No |
| `updatedAt` | Datetime | No |
| `entityId` | UUID | Yes |

**Operations:**

```typescript
// List all orgClaimedInvite records
const items = await db.orgClaimedInvite.findMany({ select: { id: true, data: true, senderId: true, receiverId: true, createdAt: true, updatedAt: true, entityId: true } }).execute();

// Get one by id
const item = await db.orgClaimedInvite.findOne({ id: '<UUID>', select: { id: true, data: true, senderId: true, receiverId: true, createdAt: true, updatedAt: true, entityId: true } }).execute();

// Create
const created = await db.orgClaimedInvite.create({ data: { data: '<JSON>', senderId: '<UUID>', receiverId: '<UUID>', entityId: '<UUID>' }, select: { id: true } }).execute();

// Update
const updated = await db.orgClaimedInvite.update({ where: { id: '<UUID>' }, data: { data: '<JSON>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.orgClaimedInvite.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.auditLogAuth`

CRUD operations for AuditLogAuth records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `createdAt` | Datetime | No |
| `id` | UUID | No |
| `event` | String | Yes |
| `actorId` | UUID | Yes |
| `origin` | ConstructiveInternalTypeOrigin | Yes |
| `userAgent` | String | Yes |
| `ipAddress` | InternetAddress | Yes |
| `success` | Boolean | Yes |

**Operations:**

```typescript
// List all auditLogAuth records
const items = await db.auditLogAuth.findMany({ select: { createdAt: true, id: true, event: true, actorId: true, origin: true, userAgent: true, ipAddress: true, success: true } }).execute();

// Get one by id
const item = await db.auditLogAuth.findOne({ id: '<UUID>', select: { createdAt: true, id: true, event: true, actorId: true, origin: true, userAgent: true, ipAddress: true, success: true } }).execute();

// Create
const created = await db.auditLogAuth.create({ data: { event: '<String>', actorId: '<UUID>', origin: '<Origin>', userAgent: '<String>', ipAddress: '<InternetAddress>', success: '<Boolean>' }, select: { id: true } }).execute();

// Update
const updated = await db.auditLogAuth.update({ where: { id: '<UUID>' }, data: { event: '<String>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.auditLogAuth.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.orgPermission`

CRUD operations for OrgPermission records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `name` | String | Yes |
| `bitnum` | Int | Yes |
| `bitstr` | BitString | Yes |
| `description` | String | Yes |

**Operations:**

```typescript
// List all orgPermission records
const items = await db.orgPermission.findMany({ select: { id: true, name: true, bitnum: true, bitstr: true, description: true } }).execute();

// Get one by id
const item = await db.orgPermission.findOne({ id: '<UUID>', select: { id: true, name: true, bitnum: true, bitstr: true, description: true } }).execute();

// Create
const created = await db.orgPermission.create({ data: { name: '<String>', bitnum: '<Int>', bitstr: '<BitString>', description: '<String>' }, select: { id: true } }).execute();

// Update
const updated = await db.orgPermission.update({ where: { id: '<UUID>' }, data: { name: '<String>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.orgPermission.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.identityProvider`

CRUD operations for IdentityProvider records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `slug` | String | Yes |
| `kind` | String | Yes |
| `displayName` | String | Yes |
| `enabled` | Boolean | Yes |

**Operations:**

```typescript
// List all identityProvider records
const items = await db.identityProvider.findMany({ select: { slug: true, kind: true, displayName: true, enabled: true } }).execute();

// Get one by id
const item = await db.identityProvider.findOne({ id: '<UUID>', select: { slug: true, kind: true, displayName: true, enabled: true } }).execute();

// Create
const created = await db.identityProvider.create({ data: { slug: '<String>', kind: '<String>', displayName: '<String>', enabled: '<Boolean>' }, select: { id: true } }).execute();

// Update
const updated = await db.identityProvider.update({ where: { id: '<UUID>' }, data: { slug: '<String>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.identityProvider.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.appPermissionDefaultPermission`

CRUD operations for AppPermissionDefaultPermission records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `permissionId` | UUID | Yes |
| `createdAt` | Datetime | No |
| `updatedAt` | Datetime | No |

**Operations:**

```typescript
// List all appPermissionDefaultPermission records
const items = await db.appPermissionDefaultPermission.findMany({ select: { id: true, permissionId: true, createdAt: true, updatedAt: true } }).execute();

// Get one by id
const item = await db.appPermissionDefaultPermission.findOne({ id: '<UUID>', select: { id: true, permissionId: true, createdAt: true, updatedAt: true } }).execute();

// Create
const created = await db.appPermissionDefaultPermission.create({ data: { permissionId: '<UUID>' }, select: { id: true } }).execute();

// Update
const updated = await db.appPermissionDefaultPermission.update({ where: { id: '<UUID>' }, data: { permissionId: '<UUID>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.appPermissionDefaultPermission.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.appPermissionDefault`

CRUD operations for AppPermissionDefault records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `permissions` | BitString | Yes |

**Operations:**

```typescript
// List all appPermissionDefault records
const items = await db.appPermissionDefault.findMany({ select: { id: true, permissions: true } }).execute();

// Get one by id
const item = await db.appPermissionDefault.findOne({ id: '<UUID>', select: { id: true, permissions: true } }).execute();

// Create
const created = await db.appPermissionDefault.create({ data: { permissions: '<BitString>' }, select: { id: true } }).execute();

// Update
const updated = await db.appPermissionDefault.update({ where: { id: '<UUID>' }, data: { permissions: '<BitString>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.appPermissionDefault.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.roleType`

CRUD operations for RoleType records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | Int | No |
| `name` | String | Yes |

**Operations:**

```typescript
// List all roleType records
const items = await db.roleType.findMany({ select: { id: true, name: true } }).execute();

// Get one by id
const item = await db.roleType.findOne({ id: '<Int>', select: { id: true, name: true } }).execute();

// Create
const created = await db.roleType.create({ data: { name: '<String>' }, select: { id: true } }).execute();

// Update
const updated = await db.roleType.update({ where: { id: '<Int>' }, data: { name: '<String>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.roleType.delete({ where: { id: '<Int>' } }).execute();
```

### `db.appMembershipDefault`

CRUD operations for AppMembershipDefault records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `createdAt` | Datetime | No |
| `updatedAt` | Datetime | No |
| `createdBy` | UUID | Yes |
| `updatedBy` | UUID | Yes |
| `isApproved` | Boolean | Yes |
| `isVerified` | Boolean | Yes |

**Operations:**

```typescript
// List all appMembershipDefault records
const items = await db.appMembershipDefault.findMany({ select: { id: true, createdAt: true, updatedAt: true, createdBy: true, updatedBy: true, isApproved: true, isVerified: true } }).execute();

// Get one by id
const item = await db.appMembershipDefault.findOne({ id: '<UUID>', select: { id: true, createdAt: true, updatedAt: true, createdBy: true, updatedBy: true, isApproved: true, isVerified: true } }).execute();

// Create
const created = await db.appMembershipDefault.create({ data: { createdBy: '<UUID>', updatedBy: '<UUID>', isApproved: '<Boolean>', isVerified: '<Boolean>' }, select: { id: true } }).execute();

// Update
const updated = await db.appMembershipDefault.update({ where: { id: '<UUID>' }, data: { createdBy: '<UUID>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.appMembershipDefault.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.orgMembershipDefault`

CRUD operations for OrgMembershipDefault records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `createdAt` | Datetime | No |
| `updatedAt` | Datetime | No |
| `createdBy` | UUID | Yes |
| `updatedBy` | UUID | Yes |
| `isApproved` | Boolean | Yes |
| `entityId` | UUID | Yes |

**Operations:**

```typescript
// List all orgMembershipDefault records
const items = await db.orgMembershipDefault.findMany({ select: { id: true, createdAt: true, updatedAt: true, createdBy: true, updatedBy: true, isApproved: true, entityId: true } }).execute();

// Get one by id
const item = await db.orgMembershipDefault.findOne({ id: '<UUID>', select: { id: true, createdAt: true, updatedAt: true, createdBy: true, updatedBy: true, isApproved: true, entityId: true } }).execute();

// Create
const created = await db.orgMembershipDefault.create({ data: { createdBy: '<UUID>', updatedBy: '<UUID>', isApproved: '<Boolean>', entityId: '<UUID>' }, select: { id: true } }).execute();

// Update
const updated = await db.orgMembershipDefault.update({ where: { id: '<UUID>' }, data: { createdBy: '<UUID>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.orgMembershipDefault.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.appLimitCapsDefault`

CRUD operations for AppLimitCapsDefault records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `name` | String | Yes |
| `max` | BigInt | Yes |

**Operations:**

```typescript
// List all appLimitCapsDefault records
const items = await db.appLimitCapsDefault.findMany({ select: { id: true, name: true, max: true } }).execute();

// Get one by id
const item = await db.appLimitCapsDefault.findOne({ id: '<UUID>', select: { id: true, name: true, max: true } }).execute();

// Create
const created = await db.appLimitCapsDefault.create({ data: { name: '<String>', max: '<BigInt>' }, select: { id: true } }).execute();

// Update
const updated = await db.appLimitCapsDefault.update({ where: { id: '<UUID>' }, data: { name: '<String>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.appLimitCapsDefault.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.orgLimitCapsDefault`

CRUD operations for OrgLimitCapsDefault records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `name` | String | Yes |
| `max` | BigInt | Yes |

**Operations:**

```typescript
// List all orgLimitCapsDefault records
const items = await db.orgLimitCapsDefault.findMany({ select: { id: true, name: true, max: true } }).execute();

// Get one by id
const item = await db.orgLimitCapsDefault.findOne({ id: '<UUID>', select: { id: true, name: true, max: true } }).execute();

// Create
const created = await db.orgLimitCapsDefault.create({ data: { name: '<String>', max: '<BigInt>' }, select: { id: true } }).execute();

// Update
const updated = await db.orgLimitCapsDefault.update({ where: { id: '<UUID>' }, data: { name: '<String>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.orgLimitCapsDefault.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.appLimitCap`

CRUD operations for AppLimitCap records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `name` | String | Yes |
| `entityId` | UUID | Yes |
| `max` | BigInt | Yes |

**Operations:**

```typescript
// List all appLimitCap records
const items = await db.appLimitCap.findMany({ select: { id: true, name: true, entityId: true, max: true } }).execute();

// Get one by id
const item = await db.appLimitCap.findOne({ id: '<UUID>', select: { id: true, name: true, entityId: true, max: true } }).execute();

// Create
const created = await db.appLimitCap.create({ data: { name: '<String>', entityId: '<UUID>', max: '<BigInt>' }, select: { id: true } }).execute();

// Update
const updated = await db.appLimitCap.update({ where: { id: '<UUID>' }, data: { name: '<String>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.appLimitCap.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.orgLimitCap`

CRUD operations for OrgLimitCap records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `name` | String | Yes |
| `entityId` | UUID | Yes |
| `max` | BigInt | Yes |

**Operations:**

```typescript
// List all orgLimitCap records
const items = await db.orgLimitCap.findMany({ select: { id: true, name: true, entityId: true, max: true } }).execute();

// Get one by id
const item = await db.orgLimitCap.findOne({ id: '<UUID>', select: { id: true, name: true, entityId: true, max: true } }).execute();

// Create
const created = await db.orgLimitCap.create({ data: { name: '<String>', entityId: '<UUID>', max: '<BigInt>' }, select: { id: true } }).execute();

// Update
const updated = await db.orgLimitCap.update({ where: { id: '<UUID>' }, data: { name: '<String>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.orgLimitCap.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.userConnectedAccount`

CRUD operations for UserConnectedAccount records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `ownerId` | UUID | Yes |
| `service` | String | Yes |
| `identifier` | String | Yes |
| `details` | JSON | Yes |
| `isVerified` | Boolean | Yes |
| `createdAt` | Datetime | No |
| `updatedAt` | Datetime | No |

**Operations:**

```typescript
// List all userConnectedAccount records
const items = await db.userConnectedAccount.findMany({ select: { id: true, ownerId: true, service: true, identifier: true, details: true, isVerified: true, createdAt: true, updatedAt: true } }).execute();

// Get one by id
const item = await db.userConnectedAccount.findOne({ id: '<UUID>', select: { id: true, ownerId: true, service: true, identifier: true, details: true, isVerified: true, createdAt: true, updatedAt: true } }).execute();

// Create
const created = await db.userConnectedAccount.create({ data: { ownerId: '<UUID>', service: '<String>', identifier: '<String>', details: '<JSON>', isVerified: '<Boolean>' }, select: { id: true } }).execute();

// Update
const updated = await db.userConnectedAccount.update({ where: { id: '<UUID>' }, data: { ownerId: '<UUID>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.userConnectedAccount.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.appLimitDefault`

CRUD operations for AppLimitDefault records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `name` | String | Yes |
| `max` | BigInt | Yes |
| `softMax` | BigInt | Yes |

**Operations:**

```typescript
// List all appLimitDefault records
const items = await db.appLimitDefault.findMany({ select: { id: true, name: true, max: true, softMax: true } }).execute();

// Get one by id
const item = await db.appLimitDefault.findOne({ id: '<UUID>', select: { id: true, name: true, max: true, softMax: true } }).execute();

// Create
const created = await db.appLimitDefault.create({ data: { name: '<String>', max: '<BigInt>', softMax: '<BigInt>' }, select: { id: true } }).execute();

// Update
const updated = await db.appLimitDefault.update({ where: { id: '<UUID>' }, data: { name: '<String>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.appLimitDefault.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.orgLimitDefault`

CRUD operations for OrgLimitDefault records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `name` | String | Yes |
| `max` | BigInt | Yes |
| `softMax` | BigInt | Yes |

**Operations:**

```typescript
// List all orgLimitDefault records
const items = await db.orgLimitDefault.findMany({ select: { id: true, name: true, max: true, softMax: true } }).execute();

// Get one by id
const item = await db.orgLimitDefault.findOne({ id: '<UUID>', select: { id: true, name: true, max: true, softMax: true } }).execute();

// Create
const created = await db.orgLimitDefault.create({ data: { name: '<String>', max: '<BigInt>', softMax: '<BigInt>' }, select: { id: true } }).execute();

// Update
const updated = await db.orgLimitDefault.update({ where: { id: '<UUID>' }, data: { name: '<String>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.orgLimitDefault.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.appLimitCreditCode`

CRUD operations for AppLimitCreditCode records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `code` | String | Yes |
| `maxRedemptions` | Int | Yes |
| `currentRedemptions` | Int | Yes |
| `expiresAt` | Datetime | Yes |

**Operations:**

```typescript
// List all appLimitCreditCode records
const items = await db.appLimitCreditCode.findMany({ select: { id: true, code: true, maxRedemptions: true, currentRedemptions: true, expiresAt: true } }).execute();

// Get one by id
const item = await db.appLimitCreditCode.findOne({ id: '<UUID>', select: { id: true, code: true, maxRedemptions: true, currentRedemptions: true, expiresAt: true } }).execute();

// Create
const created = await db.appLimitCreditCode.create({ data: { code: '<String>', maxRedemptions: '<Int>', currentRedemptions: '<Int>', expiresAt: '<Datetime>' }, select: { id: true } }).execute();

// Update
const updated = await db.appLimitCreditCode.update({ where: { id: '<UUID>' }, data: { code: '<String>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.appLimitCreditCode.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.appLimitWarning`

CRUD operations for AppLimitWarning records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `name` | String | Yes |
| `warningType` | String | Yes |
| `thresholdValue` | BigInt | Yes |
| `taskIdentifier` | String | Yes |

**Operations:**

```typescript
// List all appLimitWarning records
const items = await db.appLimitWarning.findMany({ select: { id: true, name: true, warningType: true, thresholdValue: true, taskIdentifier: true } }).execute();

// Get one by id
const item = await db.appLimitWarning.findOne({ id: '<UUID>', select: { id: true, name: true, warningType: true, thresholdValue: true, taskIdentifier: true } }).execute();

// Create
const created = await db.appLimitWarning.create({ data: { name: '<String>', warningType: '<String>', thresholdValue: '<BigInt>', taskIdentifier: '<String>' }, select: { id: true } }).execute();

// Update
const updated = await db.appLimitWarning.update({ where: { id: '<UUID>' }, data: { name: '<String>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.appLimitWarning.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.membershipType`

CRUD operations for MembershipType records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | Int | No |
| `name` | String | Yes |
| `description` | String | Yes |
| `scope` | String | Yes |
| `parentMembershipType` | Int | Yes |
| `hasUsersTableEntry` | Boolean | Yes |

**Operations:**

```typescript
// List all membershipType records
const items = await db.membershipType.findMany({ select: { id: true, name: true, description: true, scope: true, parentMembershipType: true, hasUsersTableEntry: true } }).execute();

// Get one by id
const item = await db.membershipType.findOne({ id: '<Int>', select: { id: true, name: true, description: true, scope: true, parentMembershipType: true, hasUsersTableEntry: true } }).execute();

// Create
const created = await db.membershipType.create({ data: { name: '<String>', description: '<String>', scope: '<String>', parentMembershipType: '<Int>', hasUsersTableEntry: '<Boolean>' }, select: { id: true } }).execute();

// Update
const updated = await db.membershipType.update({ where: { id: '<Int>' }, data: { name: '<String>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.membershipType.delete({ where: { id: '<Int>' } }).execute();
```

### `db.appInternalSecret`

CRUD operations for AppInternalSecret records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `name` | String | Yes |
| `namespaceId` | UUID | Yes |
| `description` | String | Yes |
| `labels` | JSON | Yes |
| `annotations` | JSON | Yes |
| `createdAt` | Datetime | No |
| `updatedAt` | Datetime | No |
| `rotatedAt` | Datetime | Yes |
| `retiredAt` | Datetime | Yes |

**Operations:**

```typescript
// List all appInternalSecret records
const items = await db.appInternalSecret.findMany({ select: { id: true, name: true, namespaceId: true, description: true, labels: true, annotations: true, createdAt: true, updatedAt: true, rotatedAt: true, retiredAt: true } }).execute();

// Get one by id
const item = await db.appInternalSecret.findOne({ id: '<UUID>', select: { id: true, name: true, namespaceId: true, description: true, labels: true, annotations: true, createdAt: true, updatedAt: true, rotatedAt: true, retiredAt: true } }).execute();

// Create
const created = await db.appInternalSecret.create({ data: { name: '<String>', namespaceId: '<UUID>', description: '<String>', labels: '<JSON>', annotations: '<JSON>', rotatedAt: '<Datetime>', retiredAt: '<Datetime>' }, select: { id: true } }).execute();

// Update
const updated = await db.appInternalSecret.update({ where: { id: '<UUID>' }, data: { name: '<String>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.appInternalSecret.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.appProfileTemplate`

CRUD operations for AppProfileTemplate records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `name` | String | Yes |
| `slug` | String | Yes |
| `description` | String | Yes |
| `permissions` | BitString | Yes |
| `isDefault` | Boolean | Yes |
| `createdAt` | Datetime | No |
| `updatedAt` | Datetime | No |

**Operations:**

```typescript
// List all appProfileTemplate records
const items = await db.appProfileTemplate.findMany({ select: { id: true, name: true, slug: true, description: true, permissions: true, isDefault: true, createdAt: true, updatedAt: true } }).execute();

// Get one by id
const item = await db.appProfileTemplate.findOne({ id: '<UUID>', select: { id: true, name: true, slug: true, description: true, permissions: true, isDefault: true, createdAt: true, updatedAt: true } }).execute();

// Create
const created = await db.appProfileTemplate.create({ data: { name: '<String>', slug: '<String>', description: '<String>', permissions: '<BitString>', isDefault: '<Boolean>' }, select: { id: true } }).execute();

// Update
const updated = await db.appProfileTemplate.update({ where: { id: '<UUID>' }, data: { name: '<String>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.appProfileTemplate.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.orgProfileTemplate`

CRUD operations for OrgProfileTemplate records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `name` | String | Yes |
| `slug` | String | Yes |
| `description` | String | Yes |
| `permissions` | BitString | Yes |
| `isDefault` | Boolean | Yes |
| `createdAt` | Datetime | No |
| `updatedAt` | Datetime | No |

**Operations:**

```typescript
// List all orgProfileTemplate records
const items = await db.orgProfileTemplate.findMany({ select: { id: true, name: true, slug: true, description: true, permissions: true, isDefault: true, createdAt: true, updatedAt: true } }).execute();

// Get one by id
const item = await db.orgProfileTemplate.findOne({ id: '<UUID>', select: { id: true, name: true, slug: true, description: true, permissions: true, isDefault: true, createdAt: true, updatedAt: true } }).execute();

// Create
const created = await db.orgProfileTemplate.create({ data: { name: '<String>', slug: '<String>', description: '<String>', permissions: '<BitString>', isDefault: '<Boolean>' }, select: { id: true } }).execute();

// Update
const updated = await db.orgProfileTemplate.update({ where: { id: '<UUID>' }, data: { name: '<String>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.orgProfileTemplate.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.orgApiKeyList`

CRUD operations for OrgApiKeyList records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `keyId` | String | Yes |
| `name` | String | Yes |
| `principalId` | UUID | Yes |
| `orgId` | UUID | Yes |
| `expiresAt` | Datetime | Yes |
| `revokedAt` | Datetime | Yes |
| `lastUsedAt` | Datetime | Yes |
| `mfaLevel` | String | Yes |
| `accessLevel` | String | Yes |
| `createdAt` | Datetime | No |
| `updatedAt` | Datetime | No |

**Operations:**

```typescript
// List all orgApiKeyList records
const items = await db.orgApiKeyList.findMany({ select: { id: true, keyId: true, name: true, principalId: true, orgId: true, expiresAt: true, revokedAt: true, lastUsedAt: true, mfaLevel: true, accessLevel: true, createdAt: true, updatedAt: true } }).execute();

// Get one by id
const item = await db.orgApiKeyList.findOne({ id: '<UUID>', select: { id: true, keyId: true, name: true, principalId: true, orgId: true, expiresAt: true, revokedAt: true, lastUsedAt: true, mfaLevel: true, accessLevel: true, createdAt: true, updatedAt: true } }).execute();

// Create
const created = await db.orgApiKeyList.create({ data: { keyId: '<String>', name: '<String>', principalId: '<UUID>', orgId: '<UUID>', expiresAt: '<Datetime>', revokedAt: '<Datetime>', lastUsedAt: '<Datetime>', mfaLevel: '<String>', accessLevel: '<String>' }, select: { id: true } }).execute();

// Update
const updated = await db.orgApiKeyList.update({ where: { id: '<UUID>' }, data: { keyId: '<String>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.orgApiKeyList.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.appProfile`

CRUD operations for AppProfile records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `name` | String | Yes |
| `slug` | String | Yes |
| `description` | String | Yes |
| `permissions` | BitString | Yes |
| `isSystem` | Boolean | Yes |
| `isDefault` | Boolean | Yes |
| `createdAt` | Datetime | No |
| `updatedAt` | Datetime | No |

**Operations:**

```typescript
// List all appProfile records
const items = await db.appProfile.findMany({ select: { id: true, name: true, slug: true, description: true, permissions: true, isSystem: true, isDefault: true, createdAt: true, updatedAt: true } }).execute();

// Get one by id
const item = await db.appProfile.findOne({ id: '<UUID>', select: { id: true, name: true, slug: true, description: true, permissions: true, isSystem: true, isDefault: true, createdAt: true, updatedAt: true } }).execute();

// Create
const created = await db.appProfile.create({ data: { name: '<String>', slug: '<String>', description: '<String>', permissions: '<BitString>', isSystem: '<Boolean>', isDefault: '<Boolean>' }, select: { id: true } }).execute();

// Update
const updated = await db.appProfile.update({ where: { id: '<UUID>' }, data: { name: '<String>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.appProfile.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.appBucket`

CRUD operations for AppBucket records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `createdAt` | Datetime | No |
| `updatedAt` | Datetime | No |
| `key` | String | Yes |
| `type` | String | Yes |
| `physicalName` | String | Yes |
| `isPublic` | Boolean | Yes |
| `description` | String | Yes |
| `actorId` | UUID | Yes |
| `maxFileSize` | BigInt | Yes |
| `allowedMimeTypes` | String | Yes |
| `allowedOrigins` | String | Yes |
| `allowCustomKeys` | Boolean | Yes |

**Operations:**

```typescript
// List all appBucket records
const items = await db.appBucket.findMany({ select: { id: true, createdAt: true, updatedAt: true, key: true, type: true, physicalName: true, isPublic: true, description: true, actorId: true, maxFileSize: true, allowedMimeTypes: true, allowedOrigins: true, allowCustomKeys: true } }).execute();

// Get one by id
const item = await db.appBucket.findOne({ id: '<UUID>', select: { id: true, createdAt: true, updatedAt: true, key: true, type: true, physicalName: true, isPublic: true, description: true, actorId: true, maxFileSize: true, allowedMimeTypes: true, allowedOrigins: true, allowCustomKeys: true } }).execute();

// Create
const created = await db.appBucket.create({ data: { key: '<String>', type: '<String>', physicalName: '<String>', isPublic: '<Boolean>', description: '<String>', actorId: '<UUID>', maxFileSize: '<BigInt>', allowedMimeTypes: '<String>', allowedOrigins: '<String>', allowCustomKeys: '<Boolean>' }, select: { id: true } }).execute();

// Update
const updated = await db.appBucket.update({ where: { id: '<UUID>' }, data: { key: '<String>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.appBucket.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.appFile`

CRUD operations for AppFile records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `filePath` | String | Yes |
| `id` | UUID | No |
| `createdAt` | Datetime | No |
| `updatedAt` | Datetime | No |
| `key` | String | Yes |
| `contentHash` | String | Yes |
| `bucketId` | UUID | Yes |
| `actorId` | UUID | Yes |
| `isPublic` | Boolean | Yes |
| `mimeType` | String | Yes |
| `size` | BigInt | Yes |
| `description` | String | Yes |
| `tags` | String | Yes |
| `filename` | String | Yes |
| `status` | FileStatus | Yes |
| `upload` | ConstructiveInternalTypeUpload | Yes |
| `downloadUrl` | String | Yes |

**Operations:**

```typescript
// List all appFile records
const items = await db.appFile.findMany({ select: { filePath: true, id: true, createdAt: true, updatedAt: true, key: true, contentHash: true, bucketId: true, actorId: true, isPublic: true, mimeType: true, size: true, description: true, tags: true, filename: true, status: true, upload: true, downloadUrl: true } }).execute();

// Get one by id
const item = await db.appFile.findOne({ id: '<UUID>', select: { filePath: true, id: true, createdAt: true, updatedAt: true, key: true, contentHash: true, bucketId: true, actorId: true, isPublic: true, mimeType: true, size: true, description: true, tags: true, filename: true, status: true, upload: true, downloadUrl: true } }).execute();

// Create
const created = await db.appFile.create({ data: { filePath: '<String>', key: '<String>', contentHash: '<String>', bucketId: '<UUID>', actorId: '<UUID>', isPublic: '<Boolean>', mimeType: '<String>', size: '<BigInt>', description: '<String>', tags: '<String>', filename: '<String>', status: '<FileStatus>', upload: '<Upload>', downloadUrl: '<String>' }, select: { id: true } }).execute();

// Update
const updated = await db.appFile.update({ where: { id: '<UUID>' }, data: { filePath: '<String>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.appFile.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.orgMembershipSetting`

CRUD operations for OrgMembershipSetting records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `createdAt` | Datetime | No |
| `updatedAt` | Datetime | No |
| `createdBy` | UUID | Yes |
| `updatedBy` | UUID | Yes |
| `entityId` | UUID | Yes |
| `deleteMemberCascadeChildren` | Boolean | Yes |
| `createChildCascadeOwners` | Boolean | Yes |
| `createChildCascadeAdmins` | Boolean | Yes |
| `createChildCascadeMembers` | Boolean | Yes |
| `allowExternalMembers` | Boolean | Yes |
| `inviteProfileAssignmentMode` | String | Yes |
| `populateMemberEmail` | Boolean | Yes |
| `limitAllocationMode` | String | Yes |

**Operations:**

```typescript
// List all orgMembershipSetting records
const items = await db.orgMembershipSetting.findMany({ select: { id: true, createdAt: true, updatedAt: true, createdBy: true, updatedBy: true, entityId: true, deleteMemberCascadeChildren: true, createChildCascadeOwners: true, createChildCascadeAdmins: true, createChildCascadeMembers: true, allowExternalMembers: true, inviteProfileAssignmentMode: true, populateMemberEmail: true, limitAllocationMode: true } }).execute();

// Get one by id
const item = await db.orgMembershipSetting.findOne({ id: '<UUID>', select: { id: true, createdAt: true, updatedAt: true, createdBy: true, updatedBy: true, entityId: true, deleteMemberCascadeChildren: true, createChildCascadeOwners: true, createChildCascadeAdmins: true, createChildCascadeMembers: true, allowExternalMembers: true, inviteProfileAssignmentMode: true, populateMemberEmail: true, limitAllocationMode: true } }).execute();

// Create
const created = await db.orgMembershipSetting.create({ data: { createdBy: '<UUID>', updatedBy: '<UUID>', entityId: '<UUID>', deleteMemberCascadeChildren: '<Boolean>', createChildCascadeOwners: '<Boolean>', createChildCascadeAdmins: '<Boolean>', createChildCascadeMembers: '<Boolean>', allowExternalMembers: '<Boolean>', inviteProfileAssignmentMode: '<String>', populateMemberEmail: '<Boolean>', limitAllocationMode: '<String>' }, select: { id: true } }).execute();

// Update
const updated = await db.orgMembershipSetting.update({ where: { id: '<UUID>' }, data: { createdBy: '<UUID>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.orgMembershipSetting.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.appLimitEvent`

CRUD operations for AppLimitEvent records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `createdAt` | Datetime | No |
| `id` | UUID | No |
| `name` | String | Yes |
| `actorId` | UUID | Yes |
| `entityId` | UUID | Yes |
| `organizationId` | UUID | Yes |
| `entityType` | String | Yes |
| `eventType` | String | Yes |
| `delta` | BigInt | Yes |
| `numBefore` | BigInt | Yes |
| `numAfter` | BigInt | Yes |
| `maxAtEvent` | BigInt | Yes |
| `reason` | String | Yes |

**Operations:**

```typescript
// List all appLimitEvent records
const items = await db.appLimitEvent.findMany({ select: { createdAt: true, id: true, name: true, actorId: true, entityId: true, organizationId: true, entityType: true, eventType: true, delta: true, numBefore: true, numAfter: true, maxAtEvent: true, reason: true } }).execute();

// Get one by id
const item = await db.appLimitEvent.findOne({ id: '<UUID>', select: { createdAt: true, id: true, name: true, actorId: true, entityId: true, organizationId: true, entityType: true, eventType: true, delta: true, numBefore: true, numAfter: true, maxAtEvent: true, reason: true } }).execute();

// Create
const created = await db.appLimitEvent.create({ data: { name: '<String>', actorId: '<UUID>', entityId: '<UUID>', organizationId: '<UUID>', entityType: '<String>', eventType: '<String>', delta: '<BigInt>', numBefore: '<BigInt>', numAfter: '<BigInt>', maxAtEvent: '<BigInt>', reason: '<String>' }, select: { id: true } }).execute();

// Update
const updated = await db.appLimitEvent.update({ where: { id: '<UUID>' }, data: { name: '<String>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.appLimitEvent.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.orgLimitEvent`

CRUD operations for OrgLimitEvent records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `createdAt` | Datetime | No |
| `id` | UUID | No |
| `name` | String | Yes |
| `actorId` | UUID | Yes |
| `entityId` | UUID | Yes |
| `organizationId` | UUID | Yes |
| `entityType` | String | Yes |
| `eventType` | String | Yes |
| `delta` | BigInt | Yes |
| `numBefore` | BigInt | Yes |
| `numAfter` | BigInt | Yes |
| `maxAtEvent` | BigInt | Yes |
| `reason` | String | Yes |

**Operations:**

```typescript
// List all orgLimitEvent records
const items = await db.orgLimitEvent.findMany({ select: { createdAt: true, id: true, name: true, actorId: true, entityId: true, organizationId: true, entityType: true, eventType: true, delta: true, numBefore: true, numAfter: true, maxAtEvent: true, reason: true } }).execute();

// Get one by id
const item = await db.orgLimitEvent.findOne({ id: '<UUID>', select: { createdAt: true, id: true, name: true, actorId: true, entityId: true, organizationId: true, entityType: true, eventType: true, delta: true, numBefore: true, numAfter: true, maxAtEvent: true, reason: true } }).execute();

// Create
const created = await db.orgLimitEvent.create({ data: { name: '<String>', actorId: '<UUID>', entityId: '<UUID>', organizationId: '<UUID>', entityType: '<String>', eventType: '<String>', delta: '<BigInt>', numBefore: '<BigInt>', numAfter: '<BigInt>', maxAtEvent: '<BigInt>', reason: '<String>' }, select: { id: true } }).execute();

// Update
const updated = await db.orgLimitEvent.update({ where: { id: '<UUID>' }, data: { name: '<String>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.orgLimitEvent.delete({ where: { id: '<UUID>' } }).execute();
```

### `db.user`

CRUD operations for User records.

**Fields:**

| Field | Type | Editable |
|-------|------|----------|
| `id` | UUID | No |
| `username` | String | Yes |
| `displayName` | String | Yes |
| `profilePicture` | ConstructiveInternalTypeImage | Yes |
| `searchTsv` | FullText | Yes |
| `type` | Int | Yes |
| `createdAt` | Datetime | No |
| `updatedAt` | Datetime | No |
| `searchTsvRank` | Float | Yes |
| `displayNameTrgmSimilarity` | Float | Yes |
| `searchScore` | Float | Yes |

**Operations:**

```typescript
// List all user records
const items = await db.user.findMany({ select: { id: true, username: true, displayName: true, profilePicture: true, searchTsv: true, type: true, createdAt: true, updatedAt: true, searchTsvRank: true, displayNameTrgmSimilarity: true, searchScore: true } }).execute();

// Get one by id
const item = await db.user.findOne({ id: '<UUID>', select: { id: true, username: true, displayName: true, profilePicture: true, searchTsv: true, type: true, createdAt: true, updatedAt: true, searchTsvRank: true, displayNameTrgmSimilarity: true, searchScore: true } }).execute();

// Create
const created = await db.user.create({ data: { username: '<String>', displayName: '<String>', profilePicture: '<Image>', searchTsv: '<FullText>', type: '<Int>', searchTsvRank: '<Float>', displayNameTrgmSimilarity: '<Float>', searchScore: '<Float>' }, select: { id: true } }).execute();

// Update
const updated = await db.user.update({ where: { id: '<UUID>' }, data: { username: '<String>' }, select: { id: true } }).execute();

// Delete
const deleted = await db.user.delete({ where: { id: '<UUID>' } }).execute();
```

> **Unified Search API fields:** `searchTsv`
> Fields provided by the Unified Search plugin. Includes full-text search (tsvector/BM25), trigram similarity scores, and the combined searchScore. Computed fields are read-only and cannot be set in create/update operations.

## Custom Operations

### `db.query.currentUserId`

currentUserId

- **Type:** query
- **Arguments:** none

```typescript
const result = await db.query.currentUserId().execute();
```

### `db.query.currentUserAgent`

currentUserAgent

- **Type:** query
- **Arguments:** none

```typescript
const result = await db.query.currentUserAgent().execute();
```

### `db.query.currentIpAddress`

currentIpAddress

- **Type:** query
- **Arguments:** none

```typescript
const result = await db.query.currentIpAddress().execute();
```

### `db.query.requireStepUp`

requireStepUp

- **Type:** query
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `stepUpType` | String |

```typescript
const result = await db.query.requireStepUp({ stepUpType: '<String>' }).execute();
```

### `db.query.appPermissionsGetPaddedMask`

appPermissionsGetPaddedMask

- **Type:** query
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `mask` | BitString |

```typescript
const result = await db.query.appPermissionsGetPaddedMask({ mask: '<BitString>' }).execute();
```

### `db.query.orgPermissionsGetPaddedMask`

orgPermissionsGetPaddedMask

- **Type:** query
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `mask` | BitString |

```typescript
const result = await db.query.orgPermissionsGetPaddedMask({ mask: '<BitString>' }).execute();
```

### `db.query.orgIsManagerOf`

orgIsManagerOf

- **Type:** query
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `targetEntityId` | UUID |
  | `managerId` | UUID |
  | `userId` | UUID |
  | `maxDepth` | Int |

```typescript
const result = await db.query.orgIsManagerOf({ targetEntityId: '<UUID>', managerId: '<UUID>', userId: '<UUID>', maxDepth: '<Int>' }).execute();
```

### `db.query.appPermissionsGetMask`

appPermissionsGetMask

- **Type:** query
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `ids` | [UUID] |

```typescript
const result = await db.query.appPermissionsGetMask({ ids: '<UUID>' }).execute();
```

### `db.query.orgPermissionsGetMask`

orgPermissionsGetMask

- **Type:** query
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `ids` | [UUID] |

```typescript
const result = await db.query.orgPermissionsGetMask({ ids: '<UUID>' }).execute();
```

### `db.query.appPermissionsGetMaskByNames`

appPermissionsGetMaskByNames

- **Type:** query
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `names` | [String] |

```typescript
const result = await db.query.appPermissionsGetMaskByNames({ names: '<String>' }).execute();
```

### `db.query.orgPermissionsGetMaskByNames`

orgPermissionsGetMaskByNames

- **Type:** query
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `names` | [String] |

```typescript
const result = await db.query.orgPermissionsGetMaskByNames({ names: '<String>' }).execute();
```

### `db.query.appPermissionsGetByMask`

Reads and enables pagination through a set of `AppPermission`.

- **Type:** query
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `mask` | BitString |
  | `first` | Int |
  | `offset` | Int |
  | `after` | Cursor |

```typescript
const result = await db.query.appPermissionsGetByMask({ mask: '<BitString>', first: '<Int>', offset: '<Int>', after: '<Cursor>' }).execute();
```

### `db.query.orgPermissionsGetByMask`

Reads and enables pagination through a set of `OrgPermission`.

- **Type:** query
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `mask` | BitString |
  | `first` | Int |
  | `offset` | Int |
  | `after` | Cursor |

```typescript
const result = await db.query.orgPermissionsGetByMask({ mask: '<BitString>', first: '<Int>', offset: '<Int>', after: '<Cursor>' }).execute();
```

### `db.query.currentUser`

currentUser

- **Type:** query
- **Arguments:** none

```typescript
const result = await db.query.currentUser().execute();
```

### `db.mutation.sendAccountDeletionEmail`

sendAccountDeletionEmail

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | SendAccountDeletionEmailInput (required) |

```typescript
const result = await db.mutation.sendAccountDeletionEmail({ input: '<SendAccountDeletionEmailInput>' }).execute();
```

### `db.mutation.signOut`

signOut

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | SignOutInput (required) |

```typescript
const result = await db.mutation.signOut({ input: '<SignOutInput>' }).execute();
```

### `db.mutation.approveDevice`

approveDevice

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | ApproveDeviceInput (required) |

```typescript
const result = await db.mutation.approveDevice({ input: { approvalToken: '<String>' } }).execute();
```

### `db.mutation.deleteOrgPrincipal`

deleteOrgPrincipal

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | DeleteOrgPrincipalInput (required) |

```typescript
const result = await db.mutation.deleteOrgPrincipal({ input: { principalId: '<UUID>' } }).execute();
```

### `db.mutation.disconnectAccount`

disconnectAccount

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | DisconnectAccountInput (required) |

```typescript
const result = await db.mutation.disconnectAccount({ input: { accountId: '<UUID>' } }).execute();
```

### `db.mutation.revokeApiKey`

revokeApiKey

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | RevokeApiKeyInput (required) |

```typescript
const result = await db.mutation.revokeApiKey({ input: { keyId: '<UUID>' } }).execute();
```

### `db.mutation.revokeSession`

revokeSession

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | RevokeSessionInput (required) |

```typescript
const result = await db.mutation.revokeSession({ input: { sessionId: '<UUID>' } }).execute();
```

### `db.mutation.verifyPassword`

verifyPassword

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | VerifyPasswordInput (required) |

```typescript
const result = await db.mutation.verifyPassword({ input: { password: '<String>' } }).execute();
```

### `db.mutation.verifyTotp`

verifyTotp

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | VerifyTotpInput (required) |

```typescript
const result = await db.mutation.verifyTotp({ input: { totpValue: '<String>' } }).execute();
```

### `db.mutation.submitAppInviteCode`

submitAppInviteCode

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | SubmitAppInviteCodeInput (required) |

```typescript
const result = await db.mutation.submitAppInviteCode({ input: { token: '<String>' } }).execute();
```

### `db.mutation.submitOrgInviteCode`

submitOrgInviteCode

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | SubmitOrgInviteCodeInput (required) |

```typescript
const result = await db.mutation.submitOrgInviteCode({ input: { token: '<String>' } }).execute();
```

### `db.mutation.checkPassword`

checkPassword

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | CheckPasswordInput (required) |

```typescript
const result = await db.mutation.checkPassword({ input: { password: '<String>' } }).execute();
```

### `db.mutation.provisionNewUser`

provisionNewUser

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | ProvisionNewUserInput (required) |

```typescript
const result = await db.mutation.provisionNewUser({ input: { email: '<String>', password: '<String>' } }).execute();
```

### `db.mutation.confirmDeleteAccount`

confirmDeleteAccount

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | ConfirmDeleteAccountInput (required) |

```typescript
const result = await db.mutation.confirmDeleteAccount({ input: { userId: '<UUID>', token: '<String>' } }).execute();
```

### `db.mutation.revokeOrgApiKey`

revokeOrgApiKey

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | RevokeOrgApiKeyInput (required) |

```typescript
const result = await db.mutation.revokeOrgApiKey({ input: { keyId: '<UUID>', orgId: '<UUID>' } }).execute();
```

### `db.mutation.setPassword`

setPassword

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | SetPasswordInput (required) |

```typescript
const result = await db.mutation.setPassword({ input: { currentPassword: '<String>', newPassword: '<String>' } }).execute();
```

### `db.mutation.verifyEmail`

verifyEmail

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | VerifyEmailInput (required) |

```typescript
const result = await db.mutation.verifyEmail({ input: { emailId: '<UUID>', token: '<String>' } }).execute();
```

### `db.mutation.appInternalSecretsDel`

appInternalSecretsDel

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | AppInternalSecretsDelInput (required) |

```typescript
const result = await db.mutation.appInternalSecretsDel({ input: { secretName: '<String>', namespaceId: '<UUID>' } }).execute();
```

### `db.mutation.resetPassword`

resetPassword

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | ResetPasswordInput (required) |

```typescript
const result = await db.mutation.resetPassword({ input: { roleId: '<UUID>', resetToken: '<String>', newPassword: '<String>' } }).execute();
```

### `db.mutation.appInternalSecretsRotate`

appInternalSecretsRotate

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | AppInternalSecretsRotateInput (required) |

```typescript
const result = await db.mutation.appInternalSecretsRotate({ input: { secretName: '<String>', secretValue: '<String>', namespaceId: '<UUID>', algo: '<String>' } }).execute();
```

### `db.mutation.appInternalSecretsSet`

appInternalSecretsSet

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | AppInternalSecretsSetInput (required) |

```typescript
const result = await db.mutation.appInternalSecretsSet({ input: { secretName: '<String>', secretValue: '<String>', secretNamespaceId: '<UUID>', algo: '<String>' } }).execute();
```

### `db.mutation.createOrgPrincipal`

createOrgPrincipal

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | CreateOrgPrincipalInput (required) |

```typescript
const result = await db.mutation.createOrgPrincipal({ input: { name: '<String>', orgId: '<UUID>', useAdminOwner: '<Boolean>', isReadOnly: '<Boolean>', bypassStepUp: '<Boolean>' } }).execute();
```

### `db.mutation.signInCrossOrigin`

signInCrossOrigin

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | SignInCrossOriginInput (required) |

```typescript
const result = await db.mutation.signInCrossOrigin({ input: { token: '<String>', credentialKind: '<String>' } }).execute();
```

### `db.mutation.signUpSms`

signUpSms

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | SignUpSmsInput (required) |

```typescript
const result = await db.mutation.signUpSms({ input: { phone: '<String>', code: '<String>', credentialKind: '<String>', rememberMe: '<Boolean>', deviceToken: '<String>' } }).execute();
```

### `db.mutation.signInSmsOtp`

signInSmsOtp

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | SignInSmsOtpInput (required) |

```typescript
const result = await db.mutation.signInSmsOtp({ input: { phone: '<String>', code: '<String>', credentialKind: '<String>', rememberMe: '<Boolean>', deviceToken: '<String>' } }).execute();
```

### `db.mutation.signUp`

signUp

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | SignUpInput (required) |

```typescript
const result = await db.mutation.signUp({ input: '<SignUpInput>' }).execute();
```

### `db.mutation.signIn`

signIn

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | SignInInput (required) |

```typescript
const result = await db.mutation.signIn({ input: '<SignInInput>' }).execute();
```

### `db.mutation.seedAppLimitCapsDefaults`

seedAppLimitCapsDefaults

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | SeedAppLimitCapsDefaultsInput (required) |

```typescript
const result = await db.mutation.seedAppLimitCapsDefaults({ input: { defaults: '<JSON>' } }).execute();
```

### `db.mutation.seedAppLimitDefaults`

seedAppLimitDefaults

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | SeedAppLimitDefaultsInput (required) |

```typescript
const result = await db.mutation.seedAppLimitDefaults({ input: { defaults: '<JSON>' } }).execute();
```

### `db.mutation.seedOrgLimitCapsDefaults`

seedOrgLimitCapsDefaults

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | SeedOrgLimitCapsDefaultsInput (required) |

```typescript
const result = await db.mutation.seedOrgLimitCapsDefaults({ input: { defaults: '<JSON>' } }).execute();
```

### `db.mutation.seedOrgLimitDefaults`

seedOrgLimitDefaults

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | SeedOrgLimitDefaultsInput (required) |

```typescript
const result = await db.mutation.seedOrgLimitDefaults({ input: { defaults: '<JSON>' } }).execute();
```

### `db.mutation.linkIdentity`

linkIdentity

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | LinkIdentityInput (required) |

```typescript
const result = await db.mutation.linkIdentity({ input: { service: '<String>', identifier: '<String>', details: '<JSON>' } }).execute();
```

### `db.mutation.appInternalSecretsRemoveArray`

appInternalSecretsRemoveArray

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | AppInternalSecretsRemoveArrayInput (required) |

```typescript
const result = await db.mutation.appInternalSecretsRemoveArray({ input: { secretNames: '<String>', namespaceId: '<UUID>' } }).execute();
```

### `db.mutation.extendTokenExpires`

extendTokenExpires

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | ExtendTokenExpiresInput (required) |

```typescript
const result = await db.mutation.extendTokenExpires({ input: { amount: '<IntervalInput>' } }).execute();
```

### `db.mutation.createOrgApiKey`

createOrgApiKey

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | CreateOrgApiKeyInput (required) |

```typescript
const result = await db.mutation.createOrgApiKey({ input: '<CreateOrgApiKeyInput>' }).execute();
```

### `db.mutation.createApiKey`

createApiKey

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | CreateApiKeyInput (required) |

```typescript
const result = await db.mutation.createApiKey({ input: { keyName: '<String>', accessLevel: '<String>', mfaLevel: '<String>', expiresIn: '<IntervalInput>', principalId: '<UUID>' } }).execute();
```

### `db.mutation.requestCrossOriginToken`

requestCrossOriginToken

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | RequestCrossOriginTokenInput (required) |

```typescript
const result = await db.mutation.requestCrossOriginToken({ input: { email: '<String>', password: '<String>', origin: '<Origin>', rememberMe: '<Boolean>' } }).execute();
```

### `db.mutation.sendVerificationEmail`

sendVerificationEmail

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | SendVerificationEmailInput (required) |

```typescript
const result = await db.mutation.sendVerificationEmail({ input: { email: '<Email>' } }).execute();
```

### `db.mutation.forgotPassword`

forgotPassword

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | ForgotPasswordInput (required) |

```typescript
const result = await db.mutation.forgotPassword({ input: { email: '<Email>' } }).execute();
```

### `db.mutation.appFilesRename`

appFilesRename

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | AppFilesRenameInput (required) |

```typescript
const result = await db.mutation.appFilesRename({ input: { fileId: '<UUID>', newFilename: '<String>' } }).execute();
```

### `db.mutation.uploadAppFile`

Upload a file: resolves the bucket by key, creates the file row, and returns a presigned PUT URL.

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | UploadAppFileInput (required) |

```typescript
const result = await db.mutation.uploadAppFile({ input: '<UploadAppFileInput>' }).execute();
```

### `db.mutation.uploadAppFiles`

Upload multiple files: resolves the bucket by key, creates file rows, and returns presigned PUT URLs for each.

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | UploadAppFileBulkInput (required) |

```typescript
const result = await db.mutation.uploadAppFiles({ input: { bucketKey: '<String>', files: '<UploadAppFileBulkFileInput>' } }).execute();
```

### `db.mutation.provisionBucket`

Provision an S3 bucket for a logical bucket in the database.
Reads the bucket config via RLS, then creates and configures
the S3 bucket with the appropriate privacy policies, CORS rules,
and lifecycle settings.

- **Type:** mutation
- **Arguments:**

  | Argument | Type |
  |----------|------|
  | `input` | ProvisionBucketInput (required) |

```typescript
const result = await db.mutation.provisionBucket({ input: { bucketKey: '<String>', ownerId: '<UUID>' } }).execute();
```

---

Built by the [Constructive](https://constructive.io) team.

## Disclaimer

AS DESCRIBED IN THE LICENSES, THE SOFTWARE IS PROVIDED "AS IS", AT YOUR OWN RISK, AND WITHOUT WARRANTIES OF ANY KIND.

No developer or entity involved in creating this software will be liable for any claims or damages whatsoever associated with your use, inability to use, or your interaction with other users of the code, including any direct, indirect, incidental, special, exemplary, punitive or consequential damages, or loss of profits, cryptocurrencies, tokens, or anything else of value.
