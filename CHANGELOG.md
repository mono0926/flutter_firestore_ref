## 0.14.1

- Upgrade cloud_firestore

## 0.14.0

- Delete JsonConveters
  - Use [json_converter_helper](https://pub.dev/packages/json_converter_helper) instead.

## 0.13.3

- Fix CollectionPagingController hasMore flicking

## 0.13.2

- Fix the error when CollectionPagingController is closed

## 0.13.1

- Enhance paging

## 0.13.0

- Upgrade cloud_firestore dependency to ">=3.0.0 <4.0.0" from ">=2.0.0 <3.0.0"

## 0.12.4+1

- Refactor ==/hashCode of DocumentRef

## 0.12.4

- Enhance hasMore of CollectionPagingController

## 0.12.3

- Fix hasMore of CollectionPagingController

## 0.12.2

- Change to `Future<D?>` from `Future<D>` of DocumentRef.get return value
- Refactor example

## 0.12.1

- Delete useFirestoreEmulator in favor of FirebaseFirestore.instance.useFirestoreEmulator

## 0.12.0

- Depend on Dart 2.13.0 to use non-function type aliases for JsonMap

## 0.11.3

- Change second type parameter of PassthroughConverter to `Object?` from `T` to suppress redundant cast and bug

## 0.11.2

- Update to firebase_core >=1.1.1 <2.0.0 and refactor hashCode of DocumentRef

## 0.11.1

- Update to rxdart 0.27.0

## 0.11.0

- Upgrade cloud_firestore to ">=2.0.0 <3.0.0"

## 0.10.0

- Migrate to null safety

## 0.9.2

- Add ISO8601Converter

## 0.9.1

- Support `GetOptions`

## 0.9.0

- Upgrade cloud_firestore to ^0.14.0
- There are some breaking changes to change DocumentRef to more strong typed

## 0.8.21

- Add `FirestoreOperationCounter`
  - If `recordFirestoreOperationCount`(default: false) is true, all operations is logged on memory and trace them.

## 0.8.20

- Add emptyCollectionIfNull to DocumentReferenceSetConverter/DocumentReferenceListConverter

## 0.8.19

- Make DocumentReferenceSetConverter to const

## 0.8.18

- Add == and hashCode to DocumentRef and CollectionRef

## 0.8.17

- Omit `createdAt` of `replacingTimestamp`

## 0.8.16

- Fix DocumentReferenceListConverter

## 0.8.15

- Add ColorConverter

## 0.8.14

- Rename to documentListResult and make it public

## 0.8.13

- Add map version of `documents`, which is updated efficiently same as list

## 0.8.12

- Support paging

## 0.8.11

- Fix a bug when `documents` is called multiple times

## 0.8.10

- Add `useFirestoreEmulator` function

## 0.8.9

- Fix `Document`'s `id` error when `ref` is null

## 0.8.8

- Add `deleteDocuments` function

## 0.8.7

- Some cleanup

## 0.8.3

- Change deleteAllDocuments return type to Future<List<DocumentReference>>

## 0.8.2

- Change deleteAllDocuments return type to Future<List<String>>, which is deleted document ids

## 0.8.1

- Add deleteAllDocuments to CollectionRef

## 0.8.0

- Use freezed at example
- Refactor encoder/decoder
- Support transaction
- Change Document id(String) to ref(DocumentReference)

## 0.7.0

- Delete helper methods in favor of cloud_firestore_web

## 0.6.0

- Split out HasTimestamp from Entity
- Change Entity to mixin from abstract class
- See: https://github.com/mono0926/flutter_firestore_ref/commit/45ff00de4ce6ec7502eaa4248b2dbf5084e09837

## 0.5.1

- Fix updateData
  - https://github.com/mono0926/flutter_firestore_ref/pull/2
  - Thanks to @takuyaohashi(https://github.com/takuyaohashi)

## 0.5.0

- Update dependencies

## 0.4.1

- Fix documentID bug

## 0.4.0

- Dart version: >=2.6.0-dev
- Use extension

## 0.3.0

- Update to firebase 6.0.0
- Support collection group query for web

## 0.2.2

- Set `configureFirestore`'s `persistenceEnabled` default value to `true`.

## 0.2.1

- Rename to data from json

## 0.2.0

- Support for web.

## 0.1.0

- Several enhancements.

## 0.0.3

- Support batch write.

## 0.0.2

- Add parseJson.

## 0.0.1

- Initial release.
