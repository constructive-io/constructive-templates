export type SignOutButtonMessages = {
  buttonText: string;
  buttonPending: string;
  successMessage: string;
  errors: {
    UNKNOWN_ERROR: string;
  };
};

export const defaultSignOutButtonMessages: SignOutButtonMessages = {
  buttonText: 'Sign out',
  buttonPending: 'Signing out...',
  successMessage: 'You have been signed out.',
  errors: {
    UNKNOWN_ERROR: 'Failed to sign out. Please try again.'
  }
};
