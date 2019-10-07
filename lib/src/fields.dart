void filterFields(int funcCode, List<FieldData> fields) {
  if (fields == null) return;
  for (int i = 0; i < fields.length; i++) {
    if ((fields[i].code & funcCode) == 0) {
      fields.removeAt(i--);
    }
  }
}

class FieldData {
  static const FieldData ACCOUNT_TYPE  = FieldData._('account_type',       0x1);
  static const FieldData ATTRIBUTION   = FieldData._('attribution',        0x2);
  static const FieldData BIO           = FieldData._('bio',                0x4);
  static const FieldData BOARD         = FieldData._('board',              0x8);
  static const FieldData COLOR         = FieldData._('color',             0x10);
  static const FieldData COUNTS        = FieldData._('counts',            0x20);
  static const FieldData CREATED_AT    = FieldData._('created_at',        0x40);
  static const FieldData CREATOR       = FieldData._('creator',           0x80);
  static const FieldData DESCRIPTION   = FieldData._('description',      0x100);
  static const FieldData FIRST_NAME    = FieldData._('first_name',       0x200);
  static const FieldData ID            = FieldData._('id',               0x400);
  static const FieldData IMAGE         = FieldData._('image',            0x800);
  static const FieldData LAST_NAME     = FieldData._('last_name',       0x1000);
  static const FieldData LINK          = FieldData._('link',            0x2000);
  static const FieldData MEDIA         = FieldData._('media',           0x4000);
  static const FieldData METADATA      = FieldData._('metadata',        0x8000);
  static const FieldData NAME          = FieldData._('name',           0x10000);
  static const FieldData NOTE          = FieldData._('note',           0x20000);
  static const FieldData ORIGINAL_LINK = FieldData._('original_link',  0x40000);
  static const FieldData PRIVACY       = FieldData._('privacy',        0x80000);
  static const FieldData REASON        = FieldData._('reason',        0x100000);
  static const FieldData URL           = FieldData._('url',           0x200000);
  static const FieldData USERNAME      = FieldData._('username',      0x400000);

  static const ConstCollection<FieldData> values = ConstCollection(<FieldData>[
    ACCOUNT_TYPE,
    ATTRIBUTION,
    BIO,
    BOARD,
    COLOR,
    COUNTS,
    CREATED_AT,
    CREATOR,
    DESCRIPTION,
    FIRST_NAME,
    ID,
    IMAGE,
    LAST_NAME,
    LINK,
    MEDIA,
    METADATA,
    NAME,
    NOTE,
    ORIGINAL_LINK,
    PRIVACY,
    REASON,
    URL,
    USERNAME
  ]);

  final String name;
  final int code;

  const FieldData._(this.name, this.code);

  @override
  String toString() => this.name;

  @override
  int get hashCode => this.code;

  @override
  bool operator ==(Object obj) => obj != null && obj is FieldData && obj.code == this.code;
}

class ConstCollection<T> {
  final List<T> _values;

  const ConstCollection(this._values);

  T operator [](int index) => this._values[index];
  int get length => this._values.length;
}
