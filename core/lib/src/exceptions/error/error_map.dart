import 'error_type.dart';

const errorMap = {
  /// General
  'unavailable': (
    ErrorType.unavailable,
    'Firebase service unavailable',
    'Firebase',
  ),
  'internal': (ErrorType.internalError, 'Internal Firebase error', 'Firebase'),
  'data-loss': (ErrorType.dataLoss, 'Data loss or corruption', 'Firebase'),

  /// Firebase Auth
  'invalid-email': (
    ErrorType.invalidEmail,
    'The email address is not valid',
    'FirebaseAuth',
  ),
  'user-not-found': (
    ErrorType.userNotFound,
    'No user found for this email',
    'FirebaseAuth',
  ),
  'user-disabled': (
    ErrorType.userDisabled,
    'This user account is disabled',
    'FirebaseAuth',
  ),
  'email-already-in-use': (
    ErrorType.emailAlreadyInUse,
    'This email is already in use',
    'FirebaseAuth',
  ),
  'invalid-credential': (
    ErrorType.invalidCredential,
    'Invalid or expired credential',
    'FirebaseAuth',
  ),
  'account-exists-with-different-credential': (
    ErrorType.accountExistsWithDifferentCredential,
    'Account exists with a different sign-in method',
    'FirebaseAuth',
  ),
  'operation-not-allowed': (
    ErrorType.operationNotAllowed,
    'Google sign-in is disabled',
    'FirebaseAuth',
  ),
  'too-many-requests': (
    ErrorType.tooManyRequests,
    'Too many attempts, try again later',
    'FirebaseAuth',
  ),
  'network-request-failed': (
    ErrorType.networkError,
    'Network error, please check your connection',
    'FirebaseAuth',
  ),
  'requires-recent-login': (
    ErrorType.requiresRecentLogin,
    'Please sign in again to perform this action',
    'FirebaseAuth',
  ),
  'expired-action-code': (
    ErrorType.expiredActionCode,
    'The action code has expired',
    'FirebaseAuth',
  ),
  'invalid-action-code': (
    ErrorType.invalidActionCode,
    'The action code is invalid',
    'FirebaseAuth',
  ),

  /// Firestore
  'not-found': (
    ErrorType.documentNotFound,
    'Requested document not found',
    'Firestore',
  ),
  'already-exists': (
    ErrorType.documentAlreadyExists,
    'Document already exists',
    'Firestore',
  ),
  'permission-denied': (
    ErrorType.permissionDenied,
    'Permission denied for this operation',
    'Firestore',
  ),
  'resource-exhausted': (
    ErrorType.resourceExhausted,
    'Quota or resource limit exceeded',
    'Firestore',
  ),
  'unauthenticated': (
    ErrorType.unauthenticated,
    'User is not authenticated',
    'Firestore',
  ),
  'deadline-exceeded': (
    ErrorType.deadlineExceeded,
    'Operation timed out',
    'Firestore',
  ),
  'invalid-argument': (
    ErrorType.invalidArgument,
    'Invalid query or data provided',
    'Firestore',
  ),
  'aborted': (ErrorType.aborted, 'Operation was aborted', 'Firestore'),
  'out-of-range': (
    ErrorType.outOfRange,
    'Query parameters out of range',
    'Firestore',
  ),
  'failed-precondition': (
    ErrorType.failedPrecondition,
    'Operation failed due to invalid state',
    'Firestore',
  ),

  /// Storage
  'object-not-found': (
    ErrorType.objectNotFound,
    'File not found in storage',
    'Storage',
  ),
  'bucket-not-found': (
    ErrorType.bucketNotFound,
    'Storage bucket not found',
    'Storage',
  ),
  'unauthorized': (
    ErrorType.unauthorized,
    'Unauthorized access to storage',
    'Storage',
  ),
  'retry-limit-exceeded': (
    ErrorType.retryLimitExceeded,
    'Upload/download retry limit reached',
    'Storage',
  ),
  'quota-exceeded': (
    ErrorType.quotaExceeded,
    'Storage quota exceeded',
    'Storage',
  ),
  'project-not-found': (
    ErrorType.projectNotFound,
    'Firebase project not found',
    'Storage',
  ),
};
