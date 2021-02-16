import 'package:firestore_ref/firestore_ref.dart';
import 'package:meta/meta.dart';

@immutable
class Document<E> {
  const Document(
    this.ref,
    this.entity,
  );

  final DocumentRef<E, Document<E>>? ref;
  final E entity;
  String? get id => ref?.ref.id;

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

  Document<E> copyWith(E entity) {
    return Document<E>(
      ref,
      entity ?? this.entity,
    );
  }
}
