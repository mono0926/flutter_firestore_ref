import 'package:firestore_ref/firestore_ref.dart';
import 'package:meta/meta.dart';

@immutable
class Document<E> {
  const Document(
    this.ref,
    this.entity,
  );

  final DocumentReference ref;
  final E entity;
  String get id => ref?.id;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Document &&
          runtimeType == other.runtimeType &&
          ref == other.ref &&
          entity == other.entity;

  @override
  int get hashCode => ref.hashCode ^ entity.hashCode;

  @override
  String toString() {
    return '''
Document<$E>(
  ref: $ref, 
  entity: $entity
)''';
  }

  Document<E> copyWith({
    DocumentReference ref,
    E entity,
  }) {
    return Document<E>(
      ref ?? this.ref,
      entity ?? this.entity,
    );
  }
}
