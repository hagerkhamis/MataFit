import '../../../domain/entities/exercise_cat_entity.dart';

typedef AllExercisesCatList = List<ExerciseCatEntity>?;

class ExerciseCat extends ExerciseCatEntity {
  const ExerciseCat({
    super.catId,
    super.catName,
  });

  factory ExerciseCat.fromJson(Map<String, dynamic> json) => ExerciseCat(
        catId: json["cat_id"],
        catName: json["cat_name"],
      );

  Map<String, dynamic> toJson() => {
        "cat_id": catId,
        "cat_name": catName,
      };
}
