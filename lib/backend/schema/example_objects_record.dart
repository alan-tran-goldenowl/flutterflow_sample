import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'example_objects_record.g.dart';

abstract class ExampleObjectsRecord
    implements Built<ExampleObjectsRecord, ExampleObjectsRecordBuilder> {
  static Serializer<ExampleObjectsRecord> get serializer =>
      _$exampleObjectsRecordSerializer;

  @nullable
  String get title;

  @nullable
  @BuiltValueField(wireName: 'create_At')
  DateTime get createAt;

  @nullable
  @BuiltValueField(wireName: 'image_url')
  String get imageUrl;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(ExampleObjectsRecordBuilder builder) => builder
    ..title = ''
    ..imageUrl = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('example-objects');

  static Stream<ExampleObjectsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  ExampleObjectsRecord._();
  factory ExampleObjectsRecord(
          [void Function(ExampleObjectsRecordBuilder) updates]) =
      _$ExampleObjectsRecord;

  static ExampleObjectsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(
          serializer, {...data, kDocumentReferenceField: reference});
}

Map<String, dynamic> createExampleObjectsRecordData({
  String title,
  DateTime createAt,
  String imageUrl,
}) =>
    serializers.toFirestore(
        ExampleObjectsRecord.serializer,
        ExampleObjectsRecord((e) => e
          ..title = title
          ..createAt = createAt
          ..imageUrl = imageUrl));
