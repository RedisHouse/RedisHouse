// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_connection_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$NewConnectionData extends NewConnectionData {
  @override
  final bool useSSLTLS;
  @override
  final bool useSSHTunnel;
  @override
  final bool useSSHPrivateKey;
  @override
  final String redisName;
  @override
  final String redisAddress;
  @override
  final String redisPort;
  @override
  final String redisPassword;
  @override
  final String sshAddress;
  @override
  final String sshPort;
  @override
  final String sshUser;
  @override
  final String sshPassword;
  @override
  final String sshPrivateKey;
  @override
  final String sshPrivateKeyPassword;

  factory _$NewConnectionData(
          [void Function(NewConnectionDataBuilder) updates]) =>
      (new NewConnectionDataBuilder()..update(updates)).build();

  _$NewConnectionData._(
      {this.useSSLTLS,
      this.useSSHTunnel,
      this.useSSHPrivateKey,
      this.redisName,
      this.redisAddress,
      this.redisPort,
      this.redisPassword,
      this.sshAddress,
      this.sshPort,
      this.sshUser,
      this.sshPassword,
      this.sshPrivateKey,
      this.sshPrivateKeyPassword})
      : super._();

  @override
  NewConnectionData rebuild(void Function(NewConnectionDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NewConnectionDataBuilder toBuilder() =>
      new NewConnectionDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NewConnectionData &&
        useSSLTLS == other.useSSLTLS &&
        useSSHTunnel == other.useSSHTunnel &&
        useSSHPrivateKey == other.useSSHPrivateKey &&
        redisName == other.redisName &&
        redisAddress == other.redisAddress &&
        redisPort == other.redisPort &&
        redisPassword == other.redisPassword &&
        sshAddress == other.sshAddress &&
        sshPort == other.sshPort &&
        sshUser == other.sshUser &&
        sshPassword == other.sshPassword &&
        sshPrivateKey == other.sshPrivateKey &&
        sshPrivateKeyPassword == other.sshPrivateKeyPassword;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc($jc(0, useSSLTLS.hashCode),
                                                    useSSHTunnel.hashCode),
                                                useSSHPrivateKey.hashCode),
                                            redisName.hashCode),
                                        redisAddress.hashCode),
                                    redisPort.hashCode),
                                redisPassword.hashCode),
                            sshAddress.hashCode),
                        sshPort.hashCode),
                    sshUser.hashCode),
                sshPassword.hashCode),
            sshPrivateKey.hashCode),
        sshPrivateKeyPassword.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('NewConnectionData')
          ..add('useSSLTLS', useSSLTLS)
          ..add('useSSHTunnel', useSSHTunnel)
          ..add('useSSHPrivateKey', useSSHPrivateKey)
          ..add('redisName', redisName)
          ..add('redisAddress', redisAddress)
          ..add('redisPort', redisPort)
          ..add('redisPassword', redisPassword)
          ..add('sshAddress', sshAddress)
          ..add('sshPort', sshPort)
          ..add('sshUser', sshUser)
          ..add('sshPassword', sshPassword)
          ..add('sshPrivateKey', sshPrivateKey)
          ..add('sshPrivateKeyPassword', sshPrivateKeyPassword))
        .toString();
  }
}

class NewConnectionDataBuilder
    implements Builder<NewConnectionData, NewConnectionDataBuilder> {
  _$NewConnectionData _$v;

  bool _useSSLTLS;
  bool get useSSLTLS => _$this._useSSLTLS;
  set useSSLTLS(bool useSSLTLS) => _$this._useSSLTLS = useSSLTLS;

  bool _useSSHTunnel;
  bool get useSSHTunnel => _$this._useSSHTunnel;
  set useSSHTunnel(bool useSSHTunnel) => _$this._useSSHTunnel = useSSHTunnel;

  bool _useSSHPrivateKey;
  bool get useSSHPrivateKey => _$this._useSSHPrivateKey;
  set useSSHPrivateKey(bool useSSHPrivateKey) =>
      _$this._useSSHPrivateKey = useSSHPrivateKey;

  String _redisName;
  String get redisName => _$this._redisName;
  set redisName(String redisName) => _$this._redisName = redisName;

  String _redisAddress;
  String get redisAddress => _$this._redisAddress;
  set redisAddress(String redisAddress) => _$this._redisAddress = redisAddress;

  String _redisPort;
  String get redisPort => _$this._redisPort;
  set redisPort(String redisPort) => _$this._redisPort = redisPort;

  String _redisPassword;
  String get redisPassword => _$this._redisPassword;
  set redisPassword(String redisPassword) =>
      _$this._redisPassword = redisPassword;

  String _sshAddress;
  String get sshAddress => _$this._sshAddress;
  set sshAddress(String sshAddress) => _$this._sshAddress = sshAddress;

  String _sshPort;
  String get sshPort => _$this._sshPort;
  set sshPort(String sshPort) => _$this._sshPort = sshPort;

  String _sshUser;
  String get sshUser => _$this._sshUser;
  set sshUser(String sshUser) => _$this._sshUser = sshUser;

  String _sshPassword;
  String get sshPassword => _$this._sshPassword;
  set sshPassword(String sshPassword) => _$this._sshPassword = sshPassword;

  String _sshPrivateKey;
  String get sshPrivateKey => _$this._sshPrivateKey;
  set sshPrivateKey(String sshPrivateKey) =>
      _$this._sshPrivateKey = sshPrivateKey;

  String _sshPrivateKeyPassword;
  String get sshPrivateKeyPassword => _$this._sshPrivateKeyPassword;
  set sshPrivateKeyPassword(String sshPrivateKeyPassword) =>
      _$this._sshPrivateKeyPassword = sshPrivateKeyPassword;

  NewConnectionDataBuilder();

  NewConnectionDataBuilder get _$this {
    if (_$v != null) {
      _useSSLTLS = _$v.useSSLTLS;
      _useSSHTunnel = _$v.useSSHTunnel;
      _useSSHPrivateKey = _$v.useSSHPrivateKey;
      _redisName = _$v.redisName;
      _redisAddress = _$v.redisAddress;
      _redisPort = _$v.redisPort;
      _redisPassword = _$v.redisPassword;
      _sshAddress = _$v.sshAddress;
      _sshPort = _$v.sshPort;
      _sshUser = _$v.sshUser;
      _sshPassword = _$v.sshPassword;
      _sshPrivateKey = _$v.sshPrivateKey;
      _sshPrivateKeyPassword = _$v.sshPrivateKeyPassword;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NewConnectionData other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$NewConnectionData;
  }

  @override
  void update(void Function(NewConnectionDataBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$NewConnectionData build() {
    final _$result = _$v ??
        new _$NewConnectionData._(
            useSSLTLS: useSSLTLS,
            useSSHTunnel: useSSHTunnel,
            useSSHPrivateKey: useSSHPrivateKey,
            redisName: redisName,
            redisAddress: redisAddress,
            redisPort: redisPort,
            redisPassword: redisPassword,
            sshAddress: sshAddress,
            sshPort: sshPort,
            sshUser: sshUser,
            sshPassword: sshPassword,
            sshPrivateKey: sshPrivateKey,
            sshPrivateKeyPassword: sshPrivateKeyPassword);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
