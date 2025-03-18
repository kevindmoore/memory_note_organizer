enum CallbackType { add, delete, rename, refresh }

typedef StateChangeCallback = void Function(CallbackType type, Object? data);
