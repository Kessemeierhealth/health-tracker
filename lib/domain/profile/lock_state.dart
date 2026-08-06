import '../../core/errors/constraint_type.dart';
import '../../core/errors/domain_message.dart';
import '../../core/errors/domain_result.dart';
import '../../core/errors/error_code.dart';
import '../../core/errors/field_reference.dart';
import '../../core/errors/message_category.dart';
import '../../core/errors/message_key.dart';
import '../../core/errors/message_severity.dart';
import 'profile_lock_status.dart';
import 'timestamp.dart';

final class LockState {
  const LockState._(this.status, this.lockedAt, this.unlockedAt);

  final ProfileLockStatus status;
  final Timestamp? lockedAt;
  final Timestamp? unlockedAt;

  bool get isLocked => status == ProfileLockStatus.locked;
  bool get isUnlocked => status == ProfileLockStatus.unlocked;

  static DomainResult<LockState> createLocked(Timestamp? lockedAt) =>
      reconstruct(ProfileLockStatus.locked, lockedAt, null);

  static DomainResult<LockState> createUnlocked(Timestamp? unlockedAt) =>
      reconstruct(ProfileLockStatus.unlocked, null, unlockedAt);

  static DomainResult<LockState> reconstruct(
    ProfileLockStatus? status,
    Timestamp? lockedAt,
    Timestamp? unlockedAt,
  ) {
    if (status == null) {
      return DomainResult<LockState>.fromError(
        _error('PRO-VAL-LSTATE-001', 'validation.lockState.status.required',
            'status', ConstraintType.required),
      );
    }
    final errors = <DomainError>[];
    if (status == ProfileLockStatus.locked) {
      if (lockedAt == null) {
        errors.add(_error(
          'PRO-VAL-LSTATE-002',
          'validation.lockState.lockedAt.required',
          'lockedAt',
          ConstraintType.required,
          const {'requiredForStatus': 'locked'},
        ));
      }
      if (unlockedAt != null) {
        errors.add(_error(
          'PRO-VAL-LSTATE-005',
          'validation.lockState.unlockedAt.forbidden',
          'unlockedAt',
          ConstraintType.forbidden,
          const {'forbiddenForStatus': 'locked'},
        ));
      }
    } else {
      if (unlockedAt == null) {
        errors.add(_error(
          'PRO-VAL-LSTATE-003',
          'validation.lockState.unlockedAt.required',
          'unlockedAt',
          ConstraintType.required,
          const {'requiredForStatus': 'unlocked'},
        ));
      }
      if (lockedAt != null) {
        errors.add(_error(
          'PRO-VAL-LSTATE-004',
          'validation.lockState.lockedAt.forbidden',
          'lockedAt',
          ConstraintType.forbidden,
          const {'forbiddenForStatus': 'unlocked'},
        ));
      }
    }
    if (errors.isNotEmpty) return DomainResult<LockState>.failure(errors);
    return DomainResult<LockState>.success(
        LockState._(status, lockedAt, unlockedAt));
  }

  DomainResult<LockState> lock(Timestamp? now) =>
      isLocked ? DomainResult<LockState>.success(this) : createLocked(now);

  DomainResult<LockState> unlock(Timestamp? now) =>
      isUnlocked ? DomainResult<LockState>.success(this) : createUnlocked(now);

  static DomainError _error(
          String code, String key, String field, ConstraintType constraint,
          [Map<String, Object> parameters = const {}]) =>
      DomainError(
        code: ErrorCode.create(code)!,
        messageKey: MessageKey.create(key)!,
        severity: MessageSeverity.error,
        category: MessageCategory.validation,
        parameters: parameters,
        field: FieldReference.create(field),
        constraint: constraint,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LockState &&
          status == other.status &&
          lockedAt == other.lockedAt &&
          unlockedAt == other.unlockedAt;

  @override
  int get hashCode => Object.hash(status, lockedAt, unlockedAt);

  @override
  String toString() =>
      'LockState(status: $status, lockedAt: $lockedAt, unlockedAt: $unlockedAt)';
}
