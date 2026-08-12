export type SocialProvidersGridMessages = {
  /** Divider label between the social buttons and other page content */
  dividerText: string;
  /** Badge label for the previously-used provider */
  lastUsedBadge: string;
  /** "Sign in with {{provider}}" — passed to auth-social-buttons when mode='sign-in' */
  signInWith: string;
  /** "Sign up with {{provider}}" — passed to auth-social-buttons when mode='sign-up' */
  signUpWith: string;
  /** Backend error codes (UPPER_SNAKE_CASE) — passed to parseGraphQLError */
  errors: {
    UNKNOWN_ERROR: string;
  };
};

/**
 * Deep-partial override type: top-level keys are shallow-optional; the `errors`
 * sub-map is itself partial, letting a host localise a single error code without
 * restating the entire catalog.
 */
export type SocialProvidersGridMessageOverrides = Partial<Omit<SocialProvidersGridMessages, 'errors'>> & {
  errors?: Partial<SocialProvidersGridMessages['errors']>;
};

export const defaultSocialProvidersGridMessages: SocialProvidersGridMessages = {
  dividerText: 'or',
  lastUsedBadge: 'Last used',
  signInWith: 'Sign in with {{provider}}',
  signUpWith: 'Sign up with {{provider}}',
  errors: {
    UNKNOWN_ERROR: 'Something went wrong. Please try again.'
  }
};
