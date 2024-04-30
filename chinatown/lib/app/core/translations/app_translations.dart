import 'package:chinatown/app/core/translations/pt_BR/pt_br_translation.dart';

import 'en_US/en_US_translation.dart';
import 'es_MX/es_mx_translation.dart';

abstract class AppTranslation {
  static Map<String, Map<String, String>> translations = {
    'pt_BR': ptBR,
    'en_US': enUs,
    'es_MX': esMx
  };
}

// class AppTranslation extends Translations {
// //   static Map<String, Map<String, String>>
// //    translations =
// // {
// //     'pt_BR' : ptBR,
// //     'en_US' : enUs,
// //     'es_mx' : esMx
// // };

//   @override
//   Map<String, Map<String, String>> get keys => {
//         'pt_BR': ptBR,
//         'en_US': enUs,
//         'es_mx': esMx,
//       };

//   // @override
//   // Map<String, Map<String, String>> get keys => {
//   //       'en_US': {
//   //         'GetX': 'GetX',
//   //         'oi': 'Hello',
//   //       },
//   //       'es_MX': {
//   //         'GetX': 'obtener',
//   //         'oi': 'Holla',
//   //       }
//   //     };
// }
