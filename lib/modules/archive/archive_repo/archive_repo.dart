import 'package:tethys/modules/archive/archive_models/requests_archived_model.dart';
import 'package:tethys/modules/archive/archive_models/returns_archived_model.dart';

abstract class ArchiveRepo {
  Future<RequestsArchivedModel> getArchivedRequest(Map data);
  Future<ReturnsArchivedModel> getArchivedReturn(Map data);
}
