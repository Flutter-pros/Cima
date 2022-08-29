import 'package:get/get_navigation/src/root/internacionalization.dart';

class MyLocal implements Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "ar": {
          "mpaa": "الفئة العمرية",
          "genre": "نوع العرض",
          "release-year": "سنة الانتاج",
          "category": "كل الفئات",
          "Quality": " جودة العرض",
          "interest": "اهتماماتك",
          "language": "اللغة",
          "nation": "بلد الانتاج",
          "tv-y": "(TV-Y) مناسب للأطفال و جميع الأعمار",
          "tv-g": "(TV-G) ملائم لجميع الأعمار و لكنه غير موجه للأطفال",
          "g":
              "(G) فيلم مناسب لجميع الأعمار و لا يوجد به أى مشاهد فاضحة أو عنيفة أو أى أفكار تحتاج إرشادات",
        },
        "en": {}
      };
}
