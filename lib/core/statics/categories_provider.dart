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
      "do stylizacji włosów", //0
      "farby / henny", //1
      "odżywki", //2
      "maski", //3
      "olejki do włosów", //4
      "peeling do skóry głowy", //5
      "płukanki do włosów", //6
      "suche szampony", //7
      "szampony", //8
      "termoochrona włosów", //9
      "wcierki do skóry głowy", //10
      "inne", //11
      "odżywki w sprayu" //12
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

    await Application.database.categoryDao
        .insertAll(entities, InsertMode.insertOrIgnore);
  }

  _insertOrReplaceFaceSubcategories() async {
    CategoryEntity parent = await Application.database.categoryDao
        .getSingle((tbl) => tbl.key.equals(CategoryKeyEnum.face.name));

    List<String> categoryNames = [
      "ampułki / serum / olejki do twarzy", //0
      "demakijaż", //1
      "do higieny jamy ustnej", //2
      "hydrolaty", //3
      "kremy do twarzy", //4
      "kremy pod oczy", //5
      "maseczki", //6
      "peeling do ust", //7
      "plasterki na nos", //8
      "toniki", //9
      "woda różana", //10
      "żele do oczyszczania twarzy", //11
      "pianki do oczyszczania twarzy", //12
      "inne" //13
          "peelingi do twarzy" //14
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

    await Application.database.categoryDao
        .insertAll(entities, InsertMode.insertOrIgnore);
  }

  _insertOrReplaceColourSubcategories() async {
    CategoryEntity parent = await Application.database.categoryDao
        .getSingle((tbl) => tbl.key.equals(CategoryKeyEnum.colour.name));

    List<String> categoryNames = [
      "bazy pod makijaż / pod cienie", //
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

    await Application.database.categoryDao
        .insertAll(entities, InsertMode.insertOrIgnore);
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
      "ochrona przeciwsłoneczna",
      "kosmetyk uniwersalny",
      "oleje",
      "po opalaniu",
      "samoopalacze",
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

    await Application.database.categoryDao
        .insertAll(entities, InsertMode.insertOrIgnore);
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
      "bazy hybrydowe",
      "topy hybrydowe"
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

    await Application.database.categoryDao
        .insertAll(entities, InsertMode.insertOrIgnore);
  }
}
