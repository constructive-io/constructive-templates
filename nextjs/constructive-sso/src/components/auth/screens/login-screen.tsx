'use client';

import type { ReactNode } from 'react';
import type { LoginFormData } from '@/lib/auth/schemas';

import { AuthScreenHeader, type AuthBrandingProps } from '../auth-screen-header';
import { AuthScreenLayout } from '../auth-screen-layout';
import { LoginFormView } from '../login-form-view';

export interface LoginScreenProps extends AuthBrandingProps {
	onLogin: (credentials: LoginFormData) => Promise<void>;
	children?: ReactNode;
}

export function LoginScreen({ onLogin, logo, appName, showLogo, children }: LoginScreenProps) {
	return (
		<AuthScreenLayout logo={logo} appName={appName} showLogo={showLogo}>
			<AuthScreenHeader title='Welcome back' description='Sign in to your account' logo={logo} appName={appName} showLogo={showLogo} />
			{children}
			<LoginFormView onLogin={onLogin} />
		</AuthScreenLayout>
	);
}
