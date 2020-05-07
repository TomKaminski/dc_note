import 'package:DC_Note/core/statics/application.dart';
import 'package:DC_Note/database/app_database.dart';
import 'package:moor_flutter/moor_flutter.dart';

enum CategoryKeyEnum { hair, face, colour, body, nail }

extension CategoryKeyEnumExtension on CategoryKeyEnum {
  String get name {
    switch (this) {
      case CategoryKeyEnum.body:
        return "CATEGORY_BODY";
      case CategoryKeyEnum.face:
        return "CATEGORY_FACE";
      case CategoryKeyEnum.colour:
        return "CATEGORY_COLOUR";
      case CategoryKeyEnum.hair:
        return "CATEGORY_HAIR";
      case CategoryKeyEnum.nail:
        return "CATEGORY_NAIL";
    }
    return null;
  }

  String get imageName {
    switch (this) {
      case CategoryKeyEnum.body:
        return "body.png";
      case CategoryKeyEnum.face:
        return "face-mask.png";
      case CategoryKeyEnum.colour:
        return "make-up.png";
      case CategoryKeyEnum.hair:
        return "comb.png";
      case CategoryKeyEnum.nail:
        return "nail-polish.png";
    }
    return null;
  }

  static CategoryKeyEnum fromString(String string) {
    if (string.startsWith("CATEGORY_BODY")) {
      return CategoryKeyEnum.body;
    }

    if (string.startsWith("CATEGORY_NAIL")) {
      return CategoryKeyEnum.nail;
    }

    if (string.startsWith("CATEGORY_FACE")) {
      return CategoryKeyEnum.face;
    }

    if (string.startsWith("CATEGORY_COLOUR")) {
      return CategoryKeyEnum.colour;
    }

    if (string.startsWith("CATEGORY_HAIR")) {
      return CategoryKeyEnum.hair;
    }

    return null;
  }
}

class CategoriesProvider {
  Future<List<CategoryEntity>> fetchCategories(String searchPhrase) async {
    final mainEntities = await Application.database.categoryDao
        .getAllByExpression((tbl) => isNull(tbl.parentId));

    List<CategoryEntity> result = [];

    for (var element in mainEntities) {
      result.add(element);
      final childEntities = await Application.database.categoryDao
          .getAllByExpression((tbl) => searchPhrase?.isNotEmpty == true
              ? tbl.parentId.equals(element.id) &
                  tbl.name.like("%$searchPhrase%")
              : tbl.parentId.equals(element.id));
      result.addAll(childEntities);
    }

    return result;
  }

  insertOrReplaceCategories() async {
    await _insertOrReplaceMainCategories();
    await _insertOrReplaceHairSubcategories();
    await _insertOrReplaceFaceSubcategories();
    await _insertOrReplaceColourSubcategories();
    await _insertOrReplaceBodySubcategories();
    await _insertOrReplaceNailSubcategories();
  }

  _insertOrReplaceMainCategories() async {
    List<CategoryEntity> entities = [
      CategoryEntity(
        id: null,
        name: "Włosy",
        parentId: null,
        key: CategoryKeyEnum.hair.name,
      ),
      CategoryEntity(
          id: null,
          name: "Twarz",
          parentId: null,
          key: CategoryKeyEnum.face.name),
      CategoryEntity(
        id: null,
        name: "Kolorówka",
        parentId: null,
        key: CategoryKeyEnum.colour.name,
      ),
      CategoryEntity(
        id: null,
        name: "Ciało",
        parentId: null,
        key: CategoryKeyEnum.body.name,
      ),
      CategoryEntity(
        id: null,
        name: "Paznokcie",
        parentId: null,
        key: CategoryKeyEnum.nail.name,
      ),
    ];

    await Application.database.categoryDao
        .insertAll(entities, InsertMode.insertOrIgnore);
  }

  _insertOrReplaceHairSubcategories() async {
    CategoryEntity parent = await Application.database.categoryDao
        .getSingle((tbl) => tbl.key.equals(CategoryKeyEnum.hair.name));

    List<String> categoryNames = [
      "do stylizacji włosów",
      "farby / henny",
      "odżywki",
      "maski",
      "olejki do włosów",
      "peeling do skóry głowy",
      "płukanki do włosów",
      "suche szampony",
      "szampony",
      "termoochrona włosów",
      "wcierki do skóry głowy",
      "inne",
    ];

    final entities = categoryNames
        .asMap()
        .entries
        .map((e) => CategoryEntity(
            id: null,
            name: e.value,
            parentId: parent.id,
            key: CategoryKeyEnum.hair.name + "_${e.key}"))
        .toList();

    for (var category in entities) {
      await Application.database.categoryDao
          .insert(category, InsertMode.insertOrIgnore);
    }
  }

  _insertOrReplaceFaceSubcategories() async {
    CategoryEntity parent = await Application.database.categoryDao
        .getSingle((tbl) => tbl.key.equals(CategoryKeyEnum.face.name));

    List<String> categoryNames = [
      "ampułki / serum / olejki do twarzy",
      "demakijaż",
      "do higieny jamy ustnej",
      "hydrolaty",
      "kremy do twarzy",
      "kremy pod oczy",
      "maseczki",
      "peeling do ust",
      "plasterki na nos",
      "toniki",
      "woda różana",
      "żele do oczyszczania twarzy",
      "pianki do oczyszczania twarzy",
      "inne"
    ];

    final entities = categoryNames
        .asMap()
        .entries
        .map((e) => CategoryEntity(
            id: null,
            name: e.value,
            parentId: parent.id,
            key: CategoryKeyEnum.face.name + "_${e.key}"))
        .toList();

    for (var category in entities) {
      await Application.database.categoryDao
          .insert(category, InsertMode.insertOrIgnore);
    }
  }

  _insertOrReplaceColourSubcategories() async {
    CategoryEntity parent = await Application.database.categoryDao
        .getSingle((tbl) => tbl.key.equals(CategoryKeyEnum.colour.name));

    List<String> categoryNames = [
      "bazy pod makijaż / pod cienie",
      "błyszczyki / szminki / pomadki",
      "bronzery",
      "cienie do oczu",
      "eyelinery / kredki do oczu",
      "fixery",
      "konturówki / kredki do ust",
      "korektory",
      "kosmetyki do brwi",
      "Podkłady / kremy BB/CC",
      "paletki",
      "pigmenty sypkie",
      "pudry",
      "róże",
      "rozświetlacze",
      "tusze do rzęs",
      "inne",
    ];

    final entities = categoryNames
        .asMap()
        .entries
        .map((e) => CategoryEntity(
            id: null,
            name: e.value,
            parentId: parent.id,
            key: CategoryKeyEnum.colour.name + "_${e.key}"))
        .toList();

    for (var category in entities) {
      await Application.database.categoryDao
          .insert(category, InsertMode.insertOrIgnore);
    }
  }

  _insertOrReplaceBodySubcategories() async {
    CategoryEntity parent = await Application.database.categoryDao
        .getSingle((tbl) => tbl.key.equals(CategoryKeyEnum.body.name));

    List<String> categoryNames = [
      "antyperspiranty / dezodoranty",
      "balsamy",
      "depilacja",
      "do dezynfekcji dłoni",
      "do higieny intymnej",
      "do pielęgnacji dłoni",
      "do pielęgnacji stóp",
      "do wanny",
      "mgiełki do ciała",
      "mydła",
      "oliwki do ciała/masażu",
      "peelingi",
      "perfumy",
      "pianki/musy do mycia ciała",
      "wyszczuplające / antycellulitowe / przeciw rozstępom",
      "żel aloesowy/żel bambusowy",
      "żele pod prysznic",
      "inne",
    ];

    final entities = categoryNames
        .asMap()
        .entries
        .map((e) => CategoryEntity(
            id: null,
            name: e.value,
            parentId: parent.id,
            key: CategoryKeyEnum.body.name + "_${e.key}"))
        .toList();

    for (var category in entities) {
      await Application.database.categoryDao
          .insert(category, InsertMode.insertOrIgnore);
    }
  }

  _insertOrReplaceNailSubcategories() async {
    CategoryEntity parent = await Application.database.categoryDao
        .getSingle((tbl) => tbl.key.equals(CategoryKeyEnum.nail.name));

    List<String> categoryNames = [
      "aceton",
      "cleaner",
      "do usuwania skórek",
      "lakiery do paznokci",
      "lakiery hybrydowe",
      "odżywki do paznokci",
      "oliwki do skórek",
      "primery kwasowe/bezkwasowe",
      "żele do paznokci",
      "zmywacze do paznokci",
      "inne",
    ];

    final entities = categoryNames
        .asMap()
        .entries
        .map((e) => CategoryEntity(
            id: null,
            name: e.value,
            parentId: parent.id,
            key: CategoryKeyEnum.nail.name + "_${e.key}"))
        .toList();

    for (var category in entities) {
      await Application.database.categoryDao
          .insert(category, InsertMode.insertOrIgnore);
    }
    ;
  }
}
