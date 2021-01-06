// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'key_detail_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$KeyDetailData extends KeyDetailData {
  @override
  final String panelUUID;
  @override
  final NewConnectionData connection;
  @override
  final BaseKeyDetail keyDetail;

  factory _$KeyDetailData([void Function(KeyDetailDataBuilder) updates]) =>
      (new KeyDetailDataBuilder()..update(updates)).build();

  _$KeyDetailData._({this.panelUUID, this.connection, this.keyDetail})
      : super._();

  @override
  KeyDetailData rebuild(void Function(KeyDetailDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  KeyDetailDataBuilder toBuilder() => new KeyDetailDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is KeyDetailData &&
        panelUUID == other.panelUUID &&
        connection == other.connection &&
        keyDetail == other.keyDetail;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, panelUUID.hashCode), connection.hashCode),
        keyDetail.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('KeyDetailData')
          ..add('panelUUID', panelUUID)
          ..add('connection', connection)
          ..add('keyDetail', keyDetail))
        .toString();
  }
}

class KeyDetailDataBuilder
    implements Builder<KeyDetailData, KeyDetailDataBuilder> {
  _$KeyDetailData _$v;

  String _panelUUID;
  String get panelUUID => _$this._panelUUID;
  set panelUUID(String panelUUID) => _$this._panelUUID = panelUUID;

  NewConnectionDataBuilder _connection;
  NewConnectionDataBuilder get connection =>
      _$this._connection ??= new NewConnectionDataBuilder();
  set connection(NewConnectionDataBuilder connection) =>
      _$this._connection = connection;

  BaseKeyDetail _keyDetail;
  BaseKeyDetail get keyDetail => _$this._keyDetail;
  set keyDetail(BaseKeyDetail keyDetail) => _$this._keyDetail = keyDetail;

  KeyDetailDataBuilder();

  KeyDetailDataBuilder get _$this {
    if (_$v != null) {
      _panelUUID = _$v.panelUUID;
      _connection = _$v.connection?.toBuilder();
      _keyDetail = _$v.keyDetail;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(KeyDetailData other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$KeyDetailData;
  }

  @override
  void update(void Function(KeyDetailDataBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$KeyDetailData build() {
    _$KeyDetailData _$result;
    try {
      _$result = _$v ??
          new _$KeyDetailData._(
              panelUUID: panelUUID,
              connection: _connection?.build(),
              keyDetail: keyDetail);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'connection';
        _connection?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'KeyDetailData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$StringKeyDetail extends StringKeyDetail {
  @override
  final String value;
  @override
  final String key;
  @override
  final String type;
  @override
  final int ttl;

  factory _$StringKeyDetail([void Function(StringKeyDetailBuilder) updates]) =>
      (new StringKeyDetailBuilder()..update(updates)).build();

  _$StringKeyDetail._({this.value, this.key, this.type, this.ttl}) : super._();

  @override
  StringKeyDetail rebuild(void Function(StringKeyDetailBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StringKeyDetailBuilder toBuilder() =>
      new StringKeyDetailBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StringKeyDetail &&
        value == other.value &&
        key == other.key &&
        type == other.type &&
        ttl == other.ttl;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, value.hashCode), key.hashCode), type.hashCode),
        ttl.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('StringKeyDetail')
          ..add('value', value)
          ..add('key', key)
          ..add('type', type)
          ..add('ttl', ttl))
        .toString();
  }
}

class StringKeyDetailBuilder
    implements Builder<StringKeyDetail, StringKeyDetailBuilder> {
  _$StringKeyDetail _$v;

  String _value;
  String get value => _$this._value;
  set value(String value) => _$this._value = value;

  String _key;
  String get key => _$this._key;
  set key(String key) => _$this._key = key;

  String _type;
  String get type => _$this._type;
  set type(String type) => _$this._type = type;

  int _ttl;
  int get ttl => _$this._ttl;
  set ttl(int ttl) => _$this._ttl = ttl;

  StringKeyDetailBuilder();

  StringKeyDetailBuilder get _$this {
    if (_$v != null) {
      _value = _$v.value;
      _key = _$v.key;
      _type = _$v.type;
      _ttl = _$v.ttl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StringKeyDetail other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$StringKeyDetail;
  }

  @override
  void update(void Function(StringKeyDetailBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$StringKeyDetail build() {
    final _$result = _$v ??
        new _$StringKeyDetail._(value: value, key: key, type: type, ttl: ttl);
    replace(_$result);
    return _$result;
  }
}

class _$HashKeyDetail extends HashKeyDetail {
  @override
  final String key;
  @override
  final String type;
  @override
  final int ttl;

  factory _$HashKeyDetail([void Function(HashKeyDetailBuilder) updates]) =>
      (new HashKeyDetailBuilder()..update(updates)).build();

  _$HashKeyDetail._({this.key, this.type, this.ttl}) : super._();

  @override
  HashKeyDetail rebuild(void Function(HashKeyDetailBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HashKeyDetailBuilder toBuilder() => new HashKeyDetailBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HashKeyDetail &&
        key == other.key &&
        type == other.type &&
        ttl == other.ttl;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, key.hashCode), type.hashCode), ttl.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('HashKeyDetail')
          ..add('key', key)
          ..add('type', type)
          ..add('ttl', ttl))
        .toString();
  }
}

class HashKeyDetailBuilder
    implements Builder<HashKeyDetail, HashKeyDetailBuilder> {
  _$HashKeyDetail _$v;

  String _key;
  String get key => _$this._key;
  set key(String key) => _$this._key = key;

  String _type;
  String get type => _$this._type;
  set type(String type) => _$this._type = type;

  int _ttl;
  int get ttl => _$this._ttl;
  set ttl(int ttl) => _$this._ttl = ttl;

  HashKeyDetailBuilder();

  HashKeyDetailBuilder get _$this {
    if (_$v != null) {
      _key = _$v.key;
      _type = _$v.type;
      _ttl = _$v.ttl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HashKeyDetail other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$HashKeyDetail;
  }

  @override
  void update(void Function(HashKeyDetailBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$HashKeyDetail build() {
    final _$result =
        _$v ?? new _$HashKeyDetail._(key: key, type: type, ttl: ttl);
    replace(_$result);
    return _$result;
  }
}

class _$ListKeyDetail extends ListKeyDetail {
  @override
  final String key;
  @override
  final String type;
  @override
  final int ttl;

  factory _$ListKeyDetail([void Function(ListKeyDetailBuilder) updates]) =>
      (new ListKeyDetailBuilder()..update(updates)).build();

  _$ListKeyDetail._({this.key, this.type, this.ttl}) : super._();

  @override
  ListKeyDetail rebuild(void Function(ListKeyDetailBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ListKeyDetailBuilder toBuilder() => new ListKeyDetailBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ListKeyDetail &&
        key == other.key &&
        type == other.type &&
        ttl == other.ttl;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, key.hashCode), type.hashCode), ttl.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ListKeyDetail')
          ..add('key', key)
          ..add('type', type)
          ..add('ttl', ttl))
        .toString();
  }
}

class ListKeyDetailBuilder
    implements Builder<ListKeyDetail, ListKeyDetailBuilder> {
  _$ListKeyDetail _$v;

  String _key;
  String get key => _$this._key;
  set key(String key) => _$this._key = key;

  String _type;
  String get type => _$this._type;
  set type(String type) => _$this._type = type;

  int _ttl;
  int get ttl => _$this._ttl;
  set ttl(int ttl) => _$this._ttl = ttl;

  ListKeyDetailBuilder();

  ListKeyDetailBuilder get _$this {
    if (_$v != null) {
      _key = _$v.key;
      _type = _$v.type;
      _ttl = _$v.ttl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ListKeyDetail other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ListKeyDetail;
  }

  @override
  void update(void Function(ListKeyDetailBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ListKeyDetail build() {
    final _$result =
        _$v ?? new _$ListKeyDetail._(key: key, type: type, ttl: ttl);
    replace(_$result);
    return _$result;
  }
}

class _$SetKeyDetail extends SetKeyDetail {
  @override
  final String key;
  @override
  final String type;
  @override
  final int ttl;

  factory _$SetKeyDetail([void Function(SetKeyDetailBuilder) updates]) =>
      (new SetKeyDetailBuilder()..update(updates)).build();

  _$SetKeyDetail._({this.key, this.type, this.ttl}) : super._();

  @override
  SetKeyDetail rebuild(void Function(SetKeyDetailBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SetKeyDetailBuilder toBuilder() => new SetKeyDetailBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SetKeyDetail &&
        key == other.key &&
        type == other.type &&
        ttl == other.ttl;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, key.hashCode), type.hashCode), ttl.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SetKeyDetail')
          ..add('key', key)
          ..add('type', type)
          ..add('ttl', ttl))
        .toString();
  }
}

class SetKeyDetailBuilder
    implements Builder<SetKeyDetail, SetKeyDetailBuilder> {
  _$SetKeyDetail _$v;

  String _key;
  String get key => _$this._key;
  set key(String key) => _$this._key = key;

  String _type;
  String get type => _$this._type;
  set type(String type) => _$this._type = type;

  int _ttl;
  int get ttl => _$this._ttl;
  set ttl(int ttl) => _$this._ttl = ttl;

  SetKeyDetailBuilder();

  SetKeyDetailBuilder get _$this {
    if (_$v != null) {
      _key = _$v.key;
      _type = _$v.type;
      _ttl = _$v.ttl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SetKeyDetail other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SetKeyDetail;
  }

  @override
  void update(void Function(SetKeyDetailBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SetKeyDetail build() {
    final _$result =
        _$v ?? new _$SetKeyDetail._(key: key, type: type, ttl: ttl);
    replace(_$result);
    return _$result;
  }
}

class _$ZSetKeyDetail extends ZSetKeyDetail {
  @override
  final String key;
  @override
  final String type;
  @override
  final int ttl;

  factory _$ZSetKeyDetail([void Function(ZSetKeyDetailBuilder) updates]) =>
      (new ZSetKeyDetailBuilder()..update(updates)).build();

  _$ZSetKeyDetail._({this.key, this.type, this.ttl}) : super._();

  @override
  ZSetKeyDetail rebuild(void Function(ZSetKeyDetailBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ZSetKeyDetailBuilder toBuilder() => new ZSetKeyDetailBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ZSetKeyDetail &&
        key == other.key &&
        type == other.type &&
        ttl == other.ttl;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, key.hashCode), type.hashCode), ttl.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ZSetKeyDetail')
          ..add('key', key)
          ..add('type', type)
          ..add('ttl', ttl))
        .toString();
  }
}

class ZSetKeyDetailBuilder
    implements Builder<ZSetKeyDetail, ZSetKeyDetailBuilder> {
  _$ZSetKeyDetail _$v;

  String _key;
  String get key => _$this._key;
  set key(String key) => _$this._key = key;

  String _type;
  String get type => _$this._type;
  set type(String type) => _$this._type = type;

  int _ttl;
  int get ttl => _$this._ttl;
  set ttl(int ttl) => _$this._ttl = ttl;

  ZSetKeyDetailBuilder();

  ZSetKeyDetailBuilder get _$this {
    if (_$v != null) {
      _key = _$v.key;
      _type = _$v.type;
      _ttl = _$v.ttl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ZSetKeyDetail other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ZSetKeyDetail;
  }

  @override
  void update(void Function(ZSetKeyDetailBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ZSetKeyDetail build() {
    final _$result =
        _$v ?? new _$ZSetKeyDetail._(key: key, type: type, ttl: ttl);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
