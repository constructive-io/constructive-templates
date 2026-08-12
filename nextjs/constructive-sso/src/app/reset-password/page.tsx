'use client';

import { Suspense } from 'react';

import { ResetPasswordCard } from '@/blocks/auth/reset-password-card/reset-password-card';
import { AuthScreenLayout } from '@/components/auth/auth-screen-layout';
import { useResetPassword } from '@/lib/gql/hooks/auth';

function ResetPasswordPageContent() {
	const resetPasswordMutation = useResetPassword();

	return (
		<AuthScreenLayout>
			{/* The block reads roleId + reset_token from URL searchParams itself. */}
			<ResetPasswordCard
				signInPath='/login'
				onSubmit={async (vars) => {
					// Bridge: the block owns form/state UI; the app's reset hook
					// owns the network call.
					await resetPasswordMutation.mutateAsync({
						roleId: vars.roleId,
						resetToken: vars.resetToken,
						newPassword: vars.newPassword
					});
					return true;
				}}
			/>
		</AuthScreenLayout>
	);
}

export default function ResetPasswordPage() {
	return (
		<Suspense
			fallback={
				<AuthScreenLayout>
					<div className='flex justify-center py-8'>Loading...</div>
				</AuthScreenLayout>
			}
		>
			<ResetPasswordPageContent />
		</Suspense>
	);
}
