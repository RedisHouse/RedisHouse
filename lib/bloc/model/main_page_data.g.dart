// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_page_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MainPageData extends MainPageData {
  @override
  final bool redisListOpen;
  @override
  final bool logOpen;
  @override
  final BuiltMap<String, ConnectionDetail> connectedRedisMap;
  @override
  final BuiltList<PanelInfo> panelList;
  @override
  final int activePanelIndex;

  factory _$MainPageData([void Function(MainPageDataBuilder) updates]) =>
      (new MainPageDataBuilder()..update(updates)).build();

  _$MainPageData._(
      {this.redisListOpen,
      this.logOpen,
      this.connectedRedisMap,
      this.panelList,
      this.activePanelIndex})
      : super._();

  @override
  MainPageData rebuild(void Function(MainPageDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MainPageDataBuilder toBuilder() => new MainPageDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MainPageData &&
        redisListOpen == other.redisListOpen &&
        logOpen == other.logOpen &&
        connectedRedisMap == other.connectedRedisMap &&
        panelList == other.panelList &&
        activePanelIndex == other.activePanelIndex;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, redisListOpen.hashCode), logOpen.hashCode),
                connectedRedisMap.hashCode),
            panelList.hashCode),
        activePanelIndex.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('MainPageData')
          ..add('redisListOpen', redisListOpen)
          ..add('logOpen', logOpen)
          ..add('connectedRedisMap', connectedRedisMap)
          ..add('panelList', panelList)
          ..add('activePanelIndex', activePanelIndex))
        .toString();
  }
}

class MainPageDataBuilder
    implements Builder<MainPageData, MainPageDataBuilder> {
  _$MainPageData _$v;

  bool _redisListOpen;
  bool get redisListOpen => _$this._redisListOpen;
  set redisListOpen(bool redisListOpen) =>
      _$this._redisListOpen = redisListOpen;

  bool _logOpen;
  bool get logOpen => _$this._logOpen;
  set logOpen(bool logOpen) => _$this._logOpen = logOpen;

  MapBuilder<String, ConnectionDetail> _connectedRedisMap;
  MapBuilder<String, ConnectionDetail> get connectedRedisMap =>
      _$this._connectedRedisMap ??= new MapBuilder<String, ConnectionDetail>();
  set connectedRedisMap(
          MapBuilder<String, ConnectionDetail> connectedRedisMap) =>
      _$this._connectedRedisMap = connectedRedisMap;

  ListBuilder<PanelInfo> _panelList;
  ListBuilder<PanelInfo> get panelList =>
      _$this._panelList ??= new ListBuilder<PanelInfo>();
  set panelList(ListBuilder<PanelInfo> panelList) =>
      _$this._panelList = panelList;

  int _activePanelIndex;
  int get activePanelIndex => _$this._activePanelIndex;
  set activePanelIndex(int activePanelIndex) =>
      _$this._activePanelIndex = activePanelIndex;

  MainPageDataBuilder();

  MainPageDataBuilder get _$this {
    if (_$v != null) {
      _redisListOpen = _$v.redisListOpen;
      _logOpen = _$v.logOpen;
      _connectedRedisMap = _$v.connectedRedisMap?.toBuilder();
      _panelList = _$v.panelList?.toBuilder();
      _activePanelIndex = _$v.activePanelIndex;
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
    _$MainPageData _$result;
    try {
      _$result = _$v ??
          new _$MainPageData._(
              redisListOpen: redisListOpen,
              logOpen: logOpen,
              connectedRedisMap: _connectedRedisMap?.build(),
              panelList: _panelList?.build(),
              activePanelIndex: activePanelIndex);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'connectedRedisMap';
        _connectedRedisMap?.build();
        _$failedField = 'panelList';
        _panelList?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'MainPageData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ConnectionDetail extends ConnectionDetail {
  @override
  final bool expanded;
  @override
  final int dbNum;
  @override
  final BuiltMap<String, int> dbKeyNumMap;

  factory _$ConnectionDetail(
          [void Function(ConnectionDetailBuilder) updates]) =>
      (new ConnectionDetailBuilder()..update(updates)).build();

  _$ConnectionDetail._({this.expanded, this.dbNum, this.dbKeyNumMap})
      : super._();

  @override
  ConnectionDetail rebuild(void Function(ConnectionDetailBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ConnectionDetailBuilder toBuilder() =>
      new ConnectionDetailBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ConnectionDetail &&
        expanded == other.expanded &&
        dbNum == other.dbNum &&
        dbKeyNumMap == other.dbKeyNumMap;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc(0, expanded.hashCode), dbNum.hashCode), dbKeyNumMap.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ConnectionDetail')
          ..add('expanded', expanded)
          ..add('dbNum', dbNum)
          ..add('dbKeyNumMap', dbKeyNumMap))
        .toString();
  }
}

class ConnectionDetailBuilder
    implements Builder<ConnectionDetail, ConnectionDetailBuilder> {
  _$ConnectionDetail _$v;

  bool _expanded;
  bool get expanded => _$this._expanded;
  set expanded(bool expanded) => _$this._expanded = expanded;

  int _dbNum;
  int get dbNum => _$this._dbNum;
  set dbNum(int dbNum) => _$this._dbNum = dbNum;

  MapBuilder<String, int> _dbKeyNumMap;
  MapBuilder<String, int> get dbKeyNumMap =>
      _$this._dbKeyNumMap ??= new MapBuilder<String, int>();
  set dbKeyNumMap(MapBuilder<String, int> dbKeyNumMap) =>
      _$this._dbKeyNumMap = dbKeyNumMap;

  ConnectionDetailBuilder();

  ConnectionDetailBuilder get _$this {
    if (_$v != null) {
      _expanded = _$v.expanded;
      _dbNum = _$v.dbNum;
      _dbKeyNumMap = _$v.dbKeyNumMap?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ConnectionDetail other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ConnectionDetail;
  }

  @override
  void update(void Function(ConnectionDetailBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ConnectionDetail build() {
    _$ConnectionDetail _$result;
    try {
      _$result = _$v ??
          new _$ConnectionDetail._(
              expanded: expanded,
              dbNum: dbNum,
              dbKeyNumMap: _dbKeyNumMap?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'dbKeyNumMap';
        _dbKeyNumMap?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ConnectionDetail', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$PanelInfo extends PanelInfo {
  @override
  final String uuid;
  @override
  final String type;
  @override
  final String name;
  @override
  final NewConnectionData connection;
  @override
  final String dbIndex;
  @override
  final BaseKeyDetail keyDetail;

  factory _$PanelInfo([void Function(PanelInfoBuilder) updates]) =>
      (new PanelInfoBuilder()..update(updates)).build();

  _$PanelInfo._(
      {this.uuid,
      this.type,
      this.name,
      this.connection,
      this.dbIndex,
      this.keyDetail})
      : super._();

  @override
  PanelInfo rebuild(void Function(PanelInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PanelInfoBuilder toBuilder() => new PanelInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PanelInfo &&
        uuid == other.uuid &&
        type == other.type &&
        name == other.name &&
        connection == other.connection &&
        dbIndex == other.dbIndex &&
        keyDetail == other.keyDetail;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc($jc(0, uuid.hashCode), type.hashCode), name.hashCode),
                connection.hashCode),
            dbIndex.hashCode),
        keyDetail.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PanelInfo')
          ..add('uuid', uuid)
          ..add('type', type)
          ..add('name', name)
          ..add('connection', connection)
          ..add('dbIndex', dbIndex)
          ..add('keyDetail', keyDetail))
        .toString();
  }
}

class PanelInfoBuilder implements Builder<PanelInfo, PanelInfoBuilder> {
  _$PanelInfo _$v;

  String _uuid;
  String get uuid => _$this._uuid;
  set uuid(String uuid) => _$this._uuid = uuid;

  String _type;
  String get type => _$this._type;
  set type(String type) => _$this._type = type;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  NewConnectionDataBuilder _connection;
  NewConnectionDataBuilder get connection =>
      _$this._connection ??= new NewConnectionDataBuilder();
  set connection(NewConnectionDataBuilder connection) =>
      _$this._connection = connection;

  String _dbIndex;
  String get dbIndex => _$this._dbIndex;
  set dbIndex(String dbIndex) => _$this._dbIndex = dbIndex;

  BaseKeyDetail _keyDetail;
  BaseKeyDetail get keyDetail => _$this._keyDetail;
  set keyDetail(BaseKeyDetail keyDetail) => _$this._keyDetail = keyDetail;

  PanelInfoBuilder();

  PanelInfoBuilder get _$this {
    if (_$v != null) {
      _uuid = _$v.uuid;
      _type = _$v.type;
      _name = _$v.name;
      _connection = _$v.connection?.toBuilder();
      _dbIndex = _$v.dbIndex;
      _keyDetail = _$v.keyDetail;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PanelInfo other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$PanelInfo;
  }

  @override
  void update(void Function(PanelInfoBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$PanelInfo build() {
    _$PanelInfo _$result;
    try {
      _$result = _$v ??
          new _$PanelInfo._(
              uuid: uuid,
              type: type,
              name: name,
              connection: _connection?.build(),
              dbIndex: dbIndex,
              keyDetail: keyDetail);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'connection';
        _connection?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'PanelInfo', _$failedField, e.toString());
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
