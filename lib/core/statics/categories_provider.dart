import 'package:DC_Note/core/statics/application.dart';
import 'package:DC_Note/database/app_database.dart';

class CategoryKeys {
  static String hair = "CATEGORY_HAIR";
  static String face = "CATEGORY_FACE";
  static String colour = "CATEGORY_COLOUR";
  static String body = "CATEGORY_BODY";
  static String nail = "CATEGORY_NAIL";
}

class CategoriesProvider {
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
        key: CategoryKeys.hair,
      ),
      CategoryEntity(
        id: null,
        name: "Twarz",
        parentId: null,
        key: CategoryKeys.face,
      ),
      CategoryEntity(
        id: null,
        name: "Kolorówka",
        parentId: null,
        key: CategoryKeys.colour,
      ),
      CategoryEntity(
        id: null,
        name: "Ciało",
        parentId: null,
        key: CategoryKeys.body,
      ),
      CategoryEntity(
        id: null,
        name: "Paznokcie",
        parentId: null,
        key: CategoryKeys.nail,
      ),
    ];

    await Application.database.categoryDao.insertAll(entities);
  }

  _insertOrReplaceHairSubcategories() async {
    CategoryEntity parent = await Application.database.categoryDao
        .getSingle((tbl) => tbl.key.equals(CategoryKeys.face));

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
            key: CategoryKeys.hair + "_${e.key}"))
        .toList();

    await Application.database.categoryDao.insertAll(entities);
  }

  _insertOrReplaceFaceSubcategories() async {
    CategoryEntity parent = await Application.database.categoryDao
        .getSingle((tbl) => tbl.key.equals(CategoryKeys.face));

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
            key: CategoryKeys.face + "_${e.key}"))
        .toList();

    await Application.database.categoryDao.insertAll(entities);
  }

  _insertOrReplaceColourSubcategories() async {
    CategoryEntity parent = await Application.database.categoryDao
        .getSingle((tbl) => tbl.key.equals(CategoryKeys.colour));

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
            key: CategoryKeys.colour + "_${e.key}"))
        .toList();

    await Application.database.categoryDao.insertAll(entities);
  }

  _insertOrReplaceBodySubcategories() async {
    CategoryEntity parent = await Application.database.categoryDao
        .getSingle((tbl) => tbl.key.equals(CategoryKeys.body));

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
            key: CategoryKeys.body + "_${e.key}"))
        .toList();

    await Application.database.categoryDao.insertAll(entities);
  }

  _insertOrReplaceNailSubcategories() async {
    CategoryEntity parent = await Application.database.categoryDao
        .getSingle((tbl) => tbl.key.equals(CategoryKeys.nail));

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
            key: CategoryKeys.nail + "_${e.key}"))
        .toList();

    await Application.database.categoryDao.insertAll(entities);
  }
}
