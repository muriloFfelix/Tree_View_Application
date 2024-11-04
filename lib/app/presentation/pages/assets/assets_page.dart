import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractian_mobile_app/app/presentation/pages/assets/components/assets_header.dart';
import 'package:tractian_mobile_app/app/presentation/pages/assets/components/tree_item_tile.dart';
import 'package:tractian_mobile_app/app/presentation/controllers/assets_controller.dart';

class AssetsPage extends GetView<AssetsController> {
  const AssetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: _createAppBar(),
        body: controller.isLoading
            // Display body replacement while screens load
            ? const Center(
                child: Text(
                  'Carregando...',
                  style: TextStyle(fontSize: 25, color: Color(0xFF17192D)),
                ),
              )
            : _createBody().paddingOnly(top: 15),
      ),
    );
  }

  AppBar _createAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFF17192D),
      leading: IconButton(
        icon: const Icon(
          CupertinoIcons.chevron_left,
          color: Colors.white,
        ),
        iconSize: 30,
        onPressed: () => Get.back(),
      ),
      title: const Text(
        'Assets',
        style: TextStyle(color: Colors.white),
      ),
      centerTitle: true,
    );
  }

  Widget _createBody() {
    final treeData = controller.getTreeList();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const AssetsHeader().paddingSymmetric(horizontal: 15),
        const Divider(
          thickness: 0.8,
        ).marginOnly(top: 10),
        Expanded(
          child: treeData.isNotEmpty
              ? ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: treeData.length,
                  itemBuilder: (context, i) {
                    return TreeItemTile(data: treeData[i]);
                  },
                )
              // Display body replacement if there's no item to be shown
              : const Text(
                  'Não há items para serem mostrados com as configurações desejadas',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF17192D),
                  ),
                ).marginOnly(top: 30),
        ),
      ],
    );
  }
}
