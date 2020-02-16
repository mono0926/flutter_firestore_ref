import 'package:meta/meta.dart';

@immutable
class Document<E> {
  const Document(
    this.id,
    this.entity,
  );

  final String id;
  final E entity;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Document &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          entity == other.entity;

  @override
  int get hashCode => id.hashCode ^ entity.hashCode;
}
