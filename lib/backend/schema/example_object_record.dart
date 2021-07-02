import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'example_object_record.g.dart';

abstract class ExampleObjectRecord
    implements Built<ExampleObjectRecord, ExampleObjectRecordBuilder> {
  static Serializer<ExampleObjectRecord> get serializer =>
      _$exampleObjectRecordSerializer;

  @nullable
  String get title;

  @nullable
  @BuiltValueField(wireName: 'image_url')
  String get imageUrl;

  @nullable
  @BuiltValueField(wireName: 'created_at')
  DateTime get createdAt;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(ExampleObjectRecordBuilder builder) => builder
    ..title = ''
    ..imageUrl = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('example_object');

  static Stream<ExampleObjectRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  ExampleObjectRecord._();
  factory ExampleObjectRecord(
          [void Function(ExampleObjectRecordBuilder) updates]) =
      _$ExampleObjectRecord;

  static ExampleObjectRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(
          serializer, {...data, kDocumentReferenceField: reference});
}

Map<String, dynamic> createExampleObjectRecordData({
  String title,
  String imageUrl,
  DateTime createdAt,
}) =>
    serializers.toFirestore(
        ExampleObjectRecord.serializer,
        ExampleObjectRecord((e) => e
          ..title = title
          ..imageUrl = imageUrl
          ..createdAt = createdAt));
