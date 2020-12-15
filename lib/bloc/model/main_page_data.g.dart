// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_page_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MainPageData extends MainPageData {
  @override
  final bool connectionListOpen;

  factory _$MainPageData([void Function(MainPageDataBuilder) updates]) =>
      (new MainPageDataBuilder()..update(updates)).build();

  _$MainPageData._({this.connectionListOpen}) : super._();

  @override
  MainPageData rebuild(void Function(MainPageDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MainPageDataBuilder toBuilder() => new MainPageDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MainPageData &&
        connectionListOpen == other.connectionListOpen;
  }

  @override
  int get hashCode {
    return $jf($jc(0, connectionListOpen.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('MainPageData')
          ..add('connectionListOpen', connectionListOpen))
        .toString();
  }
}

class MainPageDataBuilder
    implements Builder<MainPageData, MainPageDataBuilder> {
  _$MainPageData _$v;

  bool _connectionListOpen;
  bool get connectionListOpen => _$this._connectionListOpen;
  set connectionListOpen(bool connectionListOpen) =>
      _$this._connectionListOpen = connectionListOpen;

  MainPageDataBuilder();

  MainPageDataBuilder get _$this {
    if (_$v != null) {
      _connectionListOpen = _$v.connectionListOpen;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MainPageData other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$MainPageData;
  }

  @override
  void update(void Function(MainPageDataBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$MainPageData build() {
    final _$result =
        _$v ?? new _$MainPageData._(connectionListOpen: connectionListOpen);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
