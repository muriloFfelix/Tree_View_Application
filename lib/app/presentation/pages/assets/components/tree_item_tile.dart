import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractian_mobile_app/app/domain/entities/asset_entity.dart';
import 'package:tractian_mobile_app/app/presentation/controllers/assets_controller.dart';
import 'package:tractian_mobile_app/app/presentation/widgets/asset_icon.dart';
import 'package:tractian_mobile_app/core/common/tree_item_tile_data.dart';

class TreeItemTile extends GetView<AssetsController> {
  // Represents a tile for given [AssetEntity or LocationEntity] from the list

  final TreeItemTileData data;
  final RxBool isOpen = false.obs;

  TreeItemTile({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    isOpen.value = !controller.closedIds.contains(data.entity.id);

    final String leadingIcon = data.entity is! AssetEntity
        ? 'assets/images/location_icon.png'
        : (data.entity as AssetEntity).sensorType != null
            ? 'assets/images/codepen_icon.png'
            : 'assets/images/cube_icon.png';

    return Obx(
      () => Column(
        children: [
          TapRegion(
            onTapInside: (_) => {
              controller.handleTreeItemTap(isOpen.value, data.entity.id),
            },
            child: Row(
              children: [
                //Setting leading components based on [data.depth] and children
                if (data.depth == 0)
                  const SizedBox(
                    height: 35,
                  ),
                for (var i = 0; i < data.depth; i++)
                  Container(
                    height: 35,
                    width: 1,
                    color: const Color(0xFFD8DFE6),
                  ).marginOnly(left: 15),
                SizedBox(
                  width: 30,
                  child: controller.getItemsGroup(data.entity.id).isNotEmpty
                      ? RotatedBox(
                          quarterTurns: isOpen.value ? 1 : 0,
                          child: const Icon(
                            Icons.chevron_right,
                            size: 20,
                          ),
                        )
                      : Container(
                          height: data.depth == 0 ? 0 : 1,
                          color: const Color(0xFFD8DFE6),
                        ),
                ),

                //Setting main content based on [BasicEntity] type and [name]
                AssetIcon(
                  assetPath: leadingIcon,
                  color: const Color(0xFF2188FF),
                  scale: 1.5,
                ).marginOnly(right: 5),
                Text(data.entity.name).marginOnly(right: 5),

                //Setting trailing icon based on possible [sensorType] and/or [status]
                if (data.entity is AssetEntity &&
                    (data.entity as AssetEntity).sensorType != null)
                  AssetIcon(
                    assetPath: (data.entity as AssetEntity).sensorType!.icon,
                    color: (data.entity as AssetEntity).status!.color,
                    scale: 2,
                  )
              ],
            ),
          ),
          if (isOpen.value) const SizedBox()
        ],
      ),
    );
  }
}
