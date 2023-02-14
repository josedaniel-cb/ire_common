class ValidatorPatterns {
  /// Examples: "José Daniel", "Moisés Saavedra", "Alan García", etc.
  /// Source: https://stackoverflow.com/a/26900132/11026079
  static final spanishName = RegExp(r'^[A-zÀ-ú ]+$');

  /// Source: https://emailregex.com/
  static final email = RegExp(
      r'^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  /// Example: "987654321"
  static final peruPhone = RegExp(r'^\d{9}$');
}

class Validators {
  static String? spanishFirstName(String? value) {
    if (value != null && ValidatorPatterns.spanishName.hasMatch(value)) {
      return null;
    }
    return 'Nombres inválidos';
  }

  static String? spanishLastName(String? value) {
    if (value != null && ValidatorPatterns.spanishName.hasMatch(value)) {
      return null;
    }
    return 'Apellidos inválidos';
  }

  static String? email(String? value) {
    if (value != null && ValidatorPatterns.email.hasMatch(value)) {
      return null;
    }
    return 'Email inválido';
  }

  static String? peruPhone(String? value) {
    if (value != null && ValidatorPatterns.peruPhone.hasMatch(value)) {
      return null;
    }
    return 'Teléfono inválido';
  }

  static String? Function(String? value) length({int? min, int? max}) {
    return (value) {
      if (value == null) {
        return 'Campo vacío';
      }
      if (min != null && value.length < min) {
        return 'El valor no puede tener menos de $min caracteres';
      }
      if (max != null && value.length > max) {
        return 'El valor no puede tener más de $max caracteres';
      }

      return null;
    };
  }
}

extension WidgetIterableExtensions
    on Iterable<String? Function(String? value)> {
  String? Function(String? value) join() {
    return (value) {
      final list = toList();
      for (var i = 0; i < length; i++) {
        final errorMessage = list[i](value);
        if (errorMessage != null) {
          return errorMessage;
        }
      }
      return null;
    };
  }
}
