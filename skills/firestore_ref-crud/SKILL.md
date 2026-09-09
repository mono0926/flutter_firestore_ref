---
name: firestore_ref-crud
description: >-
  Use when performing type-safe Firestore CRUD operations, stream subscriptions,
  paging, or operation count tracking using firestore_ref.
---

# firestore_ref Type-Safe Firestore Operations Guide

`firestore_ref` wraps `cloud_firestore` with strong type safety, decoupling raw map dictionaries from typed entity models. It simplifies collection and document references, stream conversions, batch writes, and operation counts.

## Guidelines

- **Entity & Document Separation**:
  - Define your pure data model/entity class (e.g. `User`) without mixing Firestore document metadata into the model fields.
  - Wrap entities with `Document<T>` which provides `id`, `ref`, and typed `entity`.
- **Declaring Type-Safe References**:
  - Subclass `CollectionRef<Entity, Document>` or instantiate typed collection references.
  - Define document converters for converting Firestore Map snapshots into entity models.
- **Reading and Subscribing**:
  - Use `collectionRef.documents` or `documentRef.document` to stream typed `Document<T>` models directly rather than raw `QuerySnapshot`s.
  - For single-shot reads, call `documentRef.get()`.
- **Writing Documents**:
  - Call `collectionRef.add(entity)` or `documentRef.set(entity)`.
  - For atomic mutations, use `collectionRef.batch((batch) { ... })`.
- **Measuring Costs and Operations**:
  - Utilize `FirestoreOperationCounter` during debugging or integration tests to count exact document reads and writes.

## Examples

### 1. Defining Models and Collection References

```dart
import 'package:firestore_ref/firestore_ref.dart';

class Task {
  Task({required this.title, required this.isCompleted});

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        title: json['title'] as String,
        isCompleted: json['isCompleted'] as bool? ?? false,
      );

  final String title;
  final bool isCompleted;

  Map<String, dynamic> toJson() => {
        'title': title,
        'isCompleted': isCompleted,
      };
}

class TasksRef extends CollectionRef<Task, Document<Task>> {
  TasksRef()
      : super(
          FirebaseFirestore.instance.collection('tasks'),
          decoder: (snapshot, _) => Document(
            snapshot: snapshot,
            entity: Task.fromJson(snapshot.data()!),
          ),
          encoder: (task, _) => task.toJson(),
        );
}

final tasksRef = TasksRef();
```

### 2. Performing CRUD Operations

```dart
// CREATE
Future<Document<Task>> createTask(String title) async {
  return tasksRef.add(Task(title: title, isCompleted: false));
}

// READ (Stream of typed documents)
Stream<List<Document<Task>>> watchActiveTasks() {
  return tasksRef
      .where('isCompleted', isEqualTo: false)
      .orderBy('title')
      .documents;
}

// UPDATE
Future<void> completeTask(Document<Task> taskDoc) async {
  await taskDoc.ref.update({
    'isCompleted': true,
  });
}

// DELETE
Future<void> deleteTask(Document<Task> taskDoc) async {
  await taskDoc.ref.delete();
}
```

### 3. Tracking Read/Write Operations in Tests

```dart
void testFirestorePerformance() {
  final counter = FirestoreOperationCounter();

  counter.attach();

  // Run business workflow...

  print('Read operations: ${counter.readCount}');
  print('Write operations: ${counter.writeCount}');
  print('Delete operations: ${counter.deleteCount}');

  counter.detach();
}
```

## Common Pitfalls & Anti-Patterns

- ❌ **Anti-pattern**: Manually parsing `snapshot.docs.map((doc) => ...)` on every query listener, leading to boilerplate and lost document IDs.
  - ✔️ **Correct**: Use `collectionRef.documents` to get typed `Document<T>` models containing both the document ID and entity.
- ❌ **Anti-pattern**: Mutating document data without `batch` or typed references in multi-step transactions.
  - ✔️ **Correct**: Leverage `collectionRef.batch()` for consistent multi-document mutations.
