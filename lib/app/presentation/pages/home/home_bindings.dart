import 'package:get/get.dart';
import 'package:tractian_mobile_app/app/data/datasources/company_datasource.dart';
import 'package:tractian_mobile_app/app/data/datasources/protocols/i_company_datasource.dart';
import 'package:tractian_mobile_app/app/data/repositories/company_repository.dart';
import 'package:tractian_mobile_app/app/domain/repositories/i_company_repository.dart';
import 'package:tractian_mobile_app/app/domain/usecases/get_companies_usecase.dart';
import 'package:tractian_mobile_app/app/presentation/controllers/home_controller.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ICompanyRepository>(() => CompanyRepository(Get.find()));
    Get.lazyPut<ICompanyDatasource>(() => CompanyDatasource(GetConnect()));

    Get.lazyPut(() => GetCompaniesUsecase(Get.find()));

    Get.lazyPut(() => HomeController(Get.find()));
  }
}
