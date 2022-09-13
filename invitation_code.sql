SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `invitation_code`;
CREATE TABLE `invitation_code`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT "" COMMENT "邀請碼",
  `create_time` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT "建立時間",
  `update_time` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT "修改時間",
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT "狀態 1 已使用 0 未使用",
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT "" COMMENT "註冊的帳號",
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_code`(`code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;