//
//  Generated code. Do not modify.
//  source: todo.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use emptyDescriptor instead')
const Empty$json = {
  '1': 'Empty',
};

/// Descriptor for `Empty`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emptyDescriptor = $convert.base64Decode(
    'CgVFbXB0eQ==');

@$core.Deprecated('Use todoListDescriptor instead')
const TodoList$json = {
  '1': 'TodoList',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'count', '3': 3, '4': 1, '5': 5, '10': 'count'},
    {'1': 'cost', '3': 4, '4': 1, '5': 5, '10': 'cost'},
    {'1': 'time', '3': 5, '4': 1, '5': 5, '10': 'time'},
    {'1': 'action', '3': 6, '4': 1, '5': 9, '9': 0, '10': 'action', '17': true},
  ],
  '8': [
    {'1': '_action'},
  ],
};

/// Descriptor for `TodoList`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List todoListDescriptor = $convert.base64Decode(
    'CghUb2RvTGlzdBIOCgJpZBgBIAEoBVICaWQSFAoFdGl0bGUYAiABKAlSBXRpdGxlEhQKBWNvdW'
    '50GAMgASgFUgVjb3VudBISCgRjb3N0GAQgASgFUgRjb3N0EhIKBHRpbWUYBSABKAVSBHRpbWUS'
    'GwoGYWN0aW9uGAYgASgJSABSBmFjdGlvbogBAUIJCgdfYWN0aW9u');

@$core.Deprecated('Use todoListsDescriptor instead')
const TodoLists$json = {
  '1': 'TodoLists',
  '2': [
    {'1': 'todolists', '3': 1, '4': 3, '5': 11, '6': '.TodoList', '10': 'todolists'},
  ],
};

/// Descriptor for `TodoLists`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List todoListsDescriptor = $convert.base64Decode(
    'CglUb2RvTGlzdHMSJwoJdG9kb2xpc3RzGAEgAygLMgkuVG9kb0xpc3RSCXRvZG9saXN0cw==');

