import {
	getDefaultEndpoint,
	getEndpoints,
	getDbName,
	getAdminEndpoint,
	getAuthEndpoint,
	getAppEndpoint,
	type SchemaContext,
} from '@/lib/runtime/config-core';
import { createLogger } from '@/lib/logger';
import { useAppStore } from '@/store/app-store';
import type { AppState } from '@/store/app-store';

export type { SchemaContext } from '@/lib/runtime/config-core';
export { getDbName, getAdminEndpoint, getAuthEndpoint, getAppEndpoint };

const logger = createLogger({ scope: 'app-config' });

/**
 * Get the effective GraphQL endpoint for a context.
 *
 * Priority chain:
 * 1. UI override (from store/localStorage)
 * 2. Dynamic default (getDefaultEndpoint - reads from runtime config or env)
 */
export function getEndpoint(ctx: SchemaContext = 'admin'): string {
	let endpoint: string | null = null;
	let source = 'none';

	// 1. Check UI override (store)
	try {
		const state: AppState = useAppStore.getState();
		const o = state.env.endpointOverrides?.[ctx];
		if (o && o.trim().length) {
			endpoint = o.trim();
			source = 'ui-override';
		}
	} catch (e) {
		logger.debug('getEndpoint: Error accessing store', { error: String(e) });
	}

	// 2. Use dynamic getter
	if (!endpoint) {
		endpoint = getDefaultEndpoint(ctx);
		source = 'getDefaultEndpoint';
	}

	logger.debug('getEndpoint called', { context: ctx, endpoint, source });

	return endpoint;
}

export { getDefaultEndpoint };

/**
 * Get the FRONTEND app origin (Next.js dev server), e.g.
 * http://auth-myapp.localhost:3011
 *
 * Uses the auth endpoint's HOSTNAME (which has a routing_public binding the
 * OAuth middleware can resolve) with the port the app is actually served on.
 * NOT window.location.origin — that breaks when the user opens the app via
 * http://localhost:3011 (no route binding -> INVALID_REDIRECT_URI).
 */
export function getAppOrigin(): string {
	const authUrl = new URL(getEndpoint('auth'));
	const port = typeof window !== 'undefined' ? window.location.port : '3011';
	return `${authUrl.protocol}//${authUrl.hostname}:${port}`;
}

/** All contexts share the same home path in per-DB mode. */
export const HOME_PATH = '/';

export function getHomePath(_ctx?: SchemaContext): string {
	return HOME_PATH;
}

// Backward-compatible appConfig container
export const appConfig = {
	get endpoints() {
		return getEndpoints();
	},
} as const;
