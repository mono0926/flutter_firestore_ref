## [0.8.6]

- Rename to `deleteDocuments`

## [0.8.5]

- Add `deleteAllDocuments` function

## [0.8.4]

- Add `dryRun`(default: false) to `deleteAllDocuments`

## [0.8.3]

- Change deleteAllDocuments return type to Future<List<DocumentReference>>

## [0.8.2]

- Change deleteAllDocuments return type to Future<List<String>>, which is deleted document ids

## [0.8.1]

- Add deleteAllDocuments to CollectionRef

## [0.8.0]

- Use freezed at example
- Refactor encoder/decoder
- Support transaction
- Change Document id(String) to ref(DocumentReference)

## [0.7.0]

- Delete helper methods in favor of cloud_firestore_web

## [0.6.0]

- Split out HasTimestamp from Entity
- Change Entity to mixin from abstract class
- See: https://github.com/mono0926/flutter_firestore_ref/commit/45ff00de4ce6ec7502eaa4248b2dbf5084e09837

## [0.5.1]

- Fix updateData
    - https://github.com/mono0926/flutter_firestore_ref/pull/2
    - Thanks to [@takuyaohashi](https://github.com/takuyaohashi)

## [0.5.0]

- Update dependencies

## [0.4.1]

- Fix documentID bug

## [0.4.0]

- Dart version: >=2.6.0-dev
- Use extension

## [0.3.0]

- Update to firebase 6.0.0
- Support collection group query for web

## [0.2.2]

- Set `configureFirestore`'s `persistenceEnabled` default value to `true`.

## [0.2.1]

- Rename to data from json

## [0.2.0]

- Support for web.

## [0.1.0]

- Several enhancements.

## [0.0.3]

- Support batch write.

## [0.0.2] 

- Add parseJson.

## [0.0.1]

- Initial release.
