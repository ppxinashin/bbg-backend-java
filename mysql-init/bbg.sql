/*
 Navicat Premium Dump SQL

 Source Server         : mysql_on_local
 Source Server Type    : MySQL
 Source Server Version : 80039 (8.0.39)
 Source Host           : localhost:13306
 Source Schema         : bbg

 Target Server Type    : MySQL
 Target Server Version : 80039 (8.0.39)
 File Encoding         : 65001

 Date: 29/10/2024 14:41:16
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- 创建库
create database if not exists bbg;

-- 切换库
use bbg;

-- ----------------------------
-- Table structure for app
-- ----------------------------
DROP TABLE IF EXISTS `app`;
CREATE TABLE `app`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `appName` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '应用名',
  `appDesc` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '应用描述',
  `appIcon` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '应用图标',
  `appType` tinyint NOT NULL DEFAULT 0 COMMENT '应用类型（0-得分类，1-测评类，2-奖励类）',
  `scoringStrategy` tinyint NOT NULL DEFAULT 0 COMMENT '评分策略（0-自定义，1-AI）',
  `target` int NULL DEFAULT NULL COMMENT '目标分，仅供奖励类应用',
  `paymentType` tinyint NULL DEFAULT NULL COMMENT '支付类型：0-免费，1-可使用积分支付',
  `reviewStatus` int NOT NULL DEFAULT 0 COMMENT '审核状态：0-待审核, 1-通过, 2-拒绝',
  `reviewMessage` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '审核信息',
  `reviewerId` bigint NULL DEFAULT NULL COMMENT '审核人 id',
  `reviewTime` datetime NULL DEFAULT NULL COMMENT '审核时间',
  `userId` bigint NOT NULL COMMENT '创建用户 id',
  `createTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updateTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `isDelete` tinyint NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_appName`(`appName` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1848384029393731586 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '应用' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of app
-- ----------------------------
INSERT INTO `app` VALUES (1, '自定义MBTI性格测试', '测试性格', '11', 1, 0, NULL, NULL, 1, NULL, NULL, NULL, 1, '2024-04-24 15:58:05', '2024-05-09 15:09:53', 0);
INSERT INTO `app` VALUES (2, '自定义得分测试', '测试得分', '22', 0, 0, NULL, NULL, 1, NULL, NULL, NULL, 1, '2024-04-25 11:39:30', '2024-05-09 15:09:53', 0);
INSERT INTO `app` VALUES (3, 'AI MBTI 性格测试', '快来测测你的 MBTI', '11', 1, 1, NULL, NULL, 1, NULL, NULL, NULL, 1, '2024-04-26 16:38:12', '2024-05-09 15:09:53', 0);
INSERT INTO `app` VALUES (4, 'AI 得分测试', '看看你熟悉多少首都', '22', 0, 1, NULL, NULL, 1, NULL, NULL, NULL, 1, '2024-04-26 16:38:56', '2024-05-09 15:09:53', 0);
INSERT INTO `app` VALUES (1847154785439301633, '学生辅导', '学生辅导', 'aa', 0, 0, NULL, NULL, 0, NULL, NULL, NULL, 1, '2024-10-18 13:56:33', '2024-10-18 13:56:33', 0);
INSERT INTO `app` VALUES (1847540058836811777, '真心话大冒险', '看看你是否诚实', 'https://p5.qhimg.com/t0136d6bf557cd7edab.png', 1, 1, NULL, NULL, 1, '朕已阅', 1, '2024-10-19 15:28:57', 1, '2024-10-19 15:27:30', '2024-10-19 15:28:57', 0);
INSERT INTO `app` VALUES (1848382484107280385, '真心话大冒险2.0', '看看你是否真心', 'a.jpg', 1, 1, NULL, NULL, 1, '', 1, '2024-10-21 23:16:32', 1, '2024-10-21 23:15:00', '2024-10-21 23:16:31', 0);
INSERT INTO `app` VALUES (1848384029393731585, '翻译竞赛', '看看你能懂几种语言的对话', 'a.jpg', 0, 1, NULL, NULL, 1, '', 1, '2024-10-21 23:27:53', 1, '2024-10-21 23:21:08', '2024-10-21 23:27:52', 0);

-- ----------------------------
-- Table structure for question
-- ----------------------------
DROP TABLE IF EXISTS `question`;
CREATE TABLE `question`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `questionContent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '题目内容（json格式）',
  `appId` bigint NOT NULL COMMENT '应用 id',
  `userId` bigint NOT NULL COMMENT '创建用户 id',
  `createTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updateTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `isDelete` tinyint NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_appId`(`appId` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1848385561375850499 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '题目' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of question
-- ----------------------------
INSERT INTO `question` VALUES (1, '[{\"options\":[{\"result\":\"I\",\"value\":\"独自工作\",\"key\":\"A\"},{\"result\":\"E\",\"value\":\"与他人合作\",\"key\":\"B\"}],\"title\":\"1. 你通常更喜欢\"},{\"options\":[{\"result\":\"J\",\"value\":\"喜欢有明确的计划\",\"key\":\"A\"},{\"result\":\"P\",\"value\":\"更愿意随机应变\",\"key\":\"B\"}],\"title\":\"2. 当安排活动时\"},{\"options\":[{\"result\":\"T\",\"value\":\"认为应该严格遵守\",\"key\":\"A\"},{\"result\":\"F\",\"value\":\"认为应灵活运用\",\"key\":\"B\"}],\"title\":\"3. 你如何看待规则\"},{\"options\":[{\"result\":\"E\",\"value\":\"经常是说话的人\",\"key\":\"A\"},{\"result\":\"I\",\"value\":\"更倾向于倾听\",\"key\":\"B\"}],\"title\":\"4. 在社交场合中\"},{\"options\":[{\"result\":\"J\",\"value\":\"先研究再行动\",\"key\":\"A\"},{\"result\":\"P\",\"value\":\"边做边学习\",\"key\":\"B\"}],\"title\":\"5. 面对新的挑战\"},{\"options\":[{\"result\":\"S\",\"value\":\"注重细节和事实\",\"key\":\"A\"},{\"result\":\"N\",\"value\":\"注重概念和想象\",\"key\":\"B\"}],\"title\":\"6. 在日常生活中\"},{\"options\":[{\"result\":\"T\",\"value\":\"更多基于逻辑分析\",\"key\":\"A\"},{\"result\":\"F\",\"value\":\"更多基于个人情感\",\"key\":\"B\"}],\"title\":\"7. 做决定时\"},{\"options\":[{\"result\":\"S\",\"value\":\"喜欢有结构和常规\",\"key\":\"A\"},{\"result\":\"N\",\"value\":\"喜欢自由和灵活性\",\"key\":\"B\"}],\"title\":\"8. 对于日常安排\"},{\"options\":[{\"result\":\"P\",\"value\":\"首先考虑可能性\",\"key\":\"A\"},{\"result\":\"J\",\"value\":\"首先考虑后果\",\"key\":\"B\"}],\"title\":\"9. 当遇到问题时\"},{\"options\":[{\"result\":\"T\",\"value\":\"时间是一种宝贵的资源\",\"key\":\"A\"},{\"result\":\"F\",\"value\":\"时间是相对灵活的概念\",\"key\":\"B\"}],\"title\":\"10. 你如何看待时间\"}]', 1, 1, '2024-04-24 16:41:53', '2024-05-09 12:28:58', 0);
INSERT INTO `question` VALUES (2, '[{\"options\":[{\"score\":0,\"value\":\"利马\",\"key\":\"A\"},{\"score\":0,\"value\":\"圣多明各\",\"key\":\"B\"},{\"score\":0,\"value\":\"圣萨尔瓦多\",\"key\":\"C\"},{\"score\":1,\"value\":\"波哥大\",\"key\":\"D\"}],\"title\":\"哥伦比亚的首都是?\"},{\"options\":[{\"score\":0,\"value\":\"蒙特利尔\",\"key\":\"A\"},{\"score\":0,\"value\":\"多伦多\",\"key\":\"B\"},{\"score\":1,\"value\":\"渥太华\",\"key\":\"C\"},{\"score\":0,\"value\":\"温哥华\",\"key\":\"D\"}],\"title\":\"加拿大的首都是?\"},{\"options\":[{\"score\":0,\"value\":\"大阪\",\"key\":\"A\"},{\"score\":1,\"value\":\"东京\",\"key\":\"B\"},{\"score\":0,\"value\":\"京都\",\"key\":\"C\"},{\"score\":0,\"value\":\"名古屋\",\"key\":\"D\"}],\"title\":\"日本的首都是?\"},{\"options\":[{\"score\":0,\"value\":\"墨尔本\",\"key\":\"A\"},{\"score\":0,\"value\":\"悉尼\",\"key\":\"B\"},{\"score\":0,\"value\":\"布里斯班\",\"key\":\"C\"},{\"score\":1,\"value\":\"堪培拉\",\"key\":\"D\"}],\"title\":\"澳大利亚的首都是?\"},{\"options\":[{\"score\":1,\"value\":\"雅加达\",\"key\":\"A\"},{\"score\":0,\"value\":\"曼谷\",\"key\":\"B\"},{\"score\":0,\"value\":\"胡志明市\",\"key\":\"C\"},{\"score\":0,\"value\":\"吉隆坡\",\"key\":\"D\"}],\"title\":\"印度尼西亚的首都是?\"},{\"options\":[{\"score\":0,\"value\":\"上海\",\"key\":\"A\"},{\"score\":0,\"value\":\"杭州\",\"key\":\"B\"},{\"score\":1,\"value\":\"北京\",\"key\":\"C\"},{\"score\":0,\"value\":\"广州\",\"key\":\"D\"}],\"title\":\"中国的首都是?\"},{\"options\":[{\"score\":0,\"value\":\"汉堡\",\"key\":\"A\"},{\"score\":0,\"value\":\"慕尼黑\",\"key\":\"B\"},{\"score\":1,\"value\":\"柏林\",\"key\":\"C\"},{\"score\":0,\"value\":\"科隆\",\"key\":\"D\"}],\"title\":\"德国的首都是?\"},{\"options\":[{\"score\":0,\"value\":\"釜山\",\"key\":\"A\"},{\"score\":1,\"value\":\"首尔\",\"key\":\"B\"},{\"score\":0,\"value\":\"大田\",\"key\":\"C\"},{\"score\":0,\"value\":\"仁川\",\"key\":\"D\"}],\"title\":\"韩国的首都是?\"},{\"options\":[{\"score\":0,\"value\":\"瓜达拉哈拉\",\"key\":\"A\"},{\"score\":0,\"value\":\"蒙特雷\",\"key\":\"B\"},{\"score\":1,\"value\":\"墨西哥城\",\"key\":\"C\"},{\"score\":0,\"value\":\"坎昆\",\"key\":\"D\"}],\"title\":\"墨西哥的首都是?\"},{\"options\":[{\"score\":1,\"value\":\"开罗\",\"key\":\"A\"},{\"score\":0,\"value\":\"亚历山大\",\"key\":\"B\"},{\"score\":0,\"value\":\"卢克索\",\"key\":\"C\"},{\"score\":0,\"value\":\"卡利乌比亚\",\"key\":\"D\"}],\"title\":\"埃及的首都是?\"}]', 2, 1, '2024-04-25 15:03:07', '2024-05-09 12:28:58', 0);
INSERT INTO `question` VALUES (3, '[{\"options\":[{\"result\":\"I\",\"value\":\"独自工作\",\"key\":\"A\"},{\"result\":\"E\",\"value\":\"与他人合作\",\"key\":\"B\"}],\"title\":\"1. 你通常更喜欢\"},{\"options\":[{\"result\":\"J\",\"value\":\"喜欢有明确的计划\",\"key\":\"A\"},{\"result\":\"P\",\"value\":\"更愿意随机应变\",\"key\":\"B\"}],\"title\":\"2. 当安排活动时\"},{\"options\":[{\"result\":\"T\",\"value\":\"认为应该严格遵守\",\"key\":\"A\"},{\"result\":\"F\",\"value\":\"认为应灵活运用\",\"key\":\"B\"}],\"title\":\"3. 你如何看待规则\"},{\"options\":[{\"result\":\"E\",\"value\":\"经常是说话的人\",\"key\":\"A\"},{\"result\":\"I\",\"value\":\"更倾向于倾听\",\"key\":\"B\"}],\"title\":\"4. 在社交场合中\"},{\"options\":[{\"result\":\"J\",\"value\":\"先研究再行动\",\"key\":\"A\"},{\"result\":\"P\",\"value\":\"边做边学习\",\"key\":\"B\"}],\"title\":\"5. 面对新的挑战\"},{\"options\":[{\"result\":\"S\",\"value\":\"注重细节和事实\",\"key\":\"A\"},{\"result\":\"N\",\"value\":\"注重概念和想象\",\"key\":\"B\"}],\"title\":\"6. 在日常生活中\"},{\"options\":[{\"result\":\"T\",\"value\":\"更多基于逻辑分析\",\"key\":\"A\"},{\"result\":\"F\",\"value\":\"更多基于个人情感\",\"key\":\"B\"}],\"title\":\"7. 做决定时\"},{\"options\":[{\"result\":\"S\",\"value\":\"喜欢有结构和常规\",\"key\":\"A\"},{\"result\":\"N\",\"value\":\"喜欢自由和灵活性\",\"key\":\"B\"}],\"title\":\"8. 对于日常安排\"},{\"options\":[{\"result\":\"P\",\"value\":\"首先考虑可能性\",\"key\":\"A\"},{\"result\":\"J\",\"value\":\"首先考虑后果\",\"key\":\"B\"}],\"title\":\"9. 当遇到问题时\"},{\"options\":[{\"result\":\"T\",\"value\":\"时间是一种宝贵的资源\",\"key\":\"A\"},{\"result\":\"F\",\"value\":\"时间是相对灵活的概念\",\"key\":\"B\"}],\"title\":\"10. 你如何看待时间\"}]', 3, 1, '2024-04-26 16:39:29', '2024-05-09 12:28:58', 0);
INSERT INTO `question` VALUES (4, '[{\"options\":[{\"score\":0,\"value\":\"利马\",\"key\":\"A\"},{\"score\":0,\"value\":\"圣多明各\",\"key\":\"B\"},{\"score\":0,\"value\":\"圣萨尔瓦多\",\"key\":\"C\"},{\"score\":1,\"value\":\"波哥大\",\"key\":\"D\"}],\"title\":\"哥伦比亚的首都是?\"},{\"options\":[{\"score\":0,\"value\":\"蒙特利尔\",\"key\":\"A\"},{\"score\":0,\"value\":\"多伦多\",\"key\":\"B\"},{\"score\":1,\"value\":\"渥太华\",\"key\":\"C\"},{\"score\":0,\"value\":\"温哥华\",\"key\":\"D\"}],\"title\":\"加拿大的首都是?\"},{\"options\":[{\"score\":0,\"value\":\"大阪\",\"key\":\"A\"},{\"score\":1,\"value\":\"东京\",\"key\":\"B\"},{\"score\":0,\"value\":\"京都\",\"key\":\"C\"},{\"score\":0,\"value\":\"名古屋\",\"key\":\"D\"}],\"title\":\"日本的首都是?\"},{\"options\":[{\"score\":0,\"value\":\"墨尔本\",\"key\":\"A\"},{\"score\":0,\"value\":\"悉尼\",\"key\":\"B\"},{\"score\":0,\"value\":\"布里斯班\",\"key\":\"C\"},{\"score\":1,\"value\":\"堪培拉\",\"key\":\"D\"}],\"title\":\"澳大利亚的首都是?\"},{\"options\":[{\"score\":1,\"value\":\"雅加达\",\"key\":\"A\"},{\"score\":0,\"value\":\"曼谷\",\"key\":\"B\"},{\"score\":0,\"value\":\"胡志明市\",\"key\":\"C\"},{\"score\":0,\"value\":\"吉隆坡\",\"key\":\"D\"}],\"title\":\"印度尼西亚的首都是?\"},{\"options\":[{\"score\":0,\"value\":\"上海\",\"key\":\"A\"},{\"score\":0,\"value\":\"杭州\",\"key\":\"B\"},{\"score\":1,\"value\":\"北京\",\"key\":\"C\"},{\"score\":0,\"value\":\"广州\",\"key\":\"D\"}],\"title\":\"中国的首都是?\"},{\"options\":[{\"score\":0,\"value\":\"汉堡\",\"key\":\"A\"},{\"score\":0,\"value\":\"慕尼黑\",\"key\":\"B\"},{\"score\":1,\"value\":\"柏林\",\"key\":\"C\"},{\"score\":0,\"value\":\"科隆\",\"key\":\"D\"}],\"title\":\"德国的首都是?\"},{\"options\":[{\"score\":0,\"value\":\"釜山\",\"key\":\"A\"},{\"score\":1,\"value\":\"首尔\",\"key\":\"B\"},{\"score\":0,\"value\":\"大田\",\"key\":\"C\"},{\"score\":0,\"value\":\"仁川\",\"key\":\"D\"}],\"title\":\"韩国的首都是?\"},{\"options\":[{\"score\":0,\"value\":\"瓜达拉哈拉\",\"key\":\"A\"},{\"score\":0,\"value\":\"蒙特雷\",\"key\":\"B\"},{\"score\":1,\"value\":\"墨西哥城\",\"key\":\"C\"},{\"score\":0,\"value\":\"坎昆\",\"key\":\"D\"}],\"title\":\"墨西哥的首都是?\"},{\"options\":[{\"score\":1,\"value\":\"开罗\",\"key\":\"A\"},{\"score\":0,\"value\":\"亚历山大\",\"key\":\"B\"},{\"score\":0,\"value\":\"卢克索\",\"key\":\"C\"},{\"score\":0,\"value\":\"卡利乌比亚\",\"key\":\"D\"}],\"title\":\"埃及的首都是?\"}]', 4, 1, '2024-04-26 16:39:29', '2024-05-09 12:28:58', 0);
INSERT INTO `question` VALUES (1846179331442032642, '[{\"title\":\"你妈是谁？\",\"options\":[{\"result\":\"人类文明\",\"score\":0,\"value\":\"aa\",\"key\":\"A\"},{\"result\":\"人类\",\"score\":3,\"value\":\"bb\",\"key\":\"B\"}]}]', 1846169445631086594, 1846169370255249409, '2024-10-15 21:20:27', '2024-10-15 21:20:27', 0);
INSERT INTO `question` VALUES (1847542636496666625, '[{\"title\":\"你曾经撒过谎吗？\",\"options\":[{\"score\":0,\"value\":\"是\",\"key\":\"A\"},{\"score\":0,\"value\":\"否\",\"key\":\"B\"}]},{\"title\":\"你曾经偷吃过零食吗？\",\"options\":[{\"score\":0,\"value\":\"是\",\"key\":\"A\"},{\"score\":0,\"value\":\"否\",\"key\":\"B\"}]},{\"title\":\"你曾经迟到过吗？\",\"options\":[{\"score\":0,\"value\":\"是\",\"key\":\"A\"},{\"score\":0,\"value\":\"否\",\"key\":\"B\"}]},{\"title\":\"你曾经忘记带作业吗？\",\"options\":[{\"score\":0,\"value\":\"是\",\"key\":\"A\"},{\"score\":0,\"value\":\"否\",\"key\":\"B\"}]},{\"title\":\"你曾经偷偷看过别人的手机吗？\",\"options\":[{\"score\":0,\"value\":\"是\",\"key\":\"A\"},{\"score\":0,\"value\":\"否\",\"key\":\"B\"}]},{\"title\":\"你曾经说过别人的坏话吗？\",\"options\":[{\"score\":0,\"value\":\"是\",\"key\":\"A\"},{\"score\":0,\"value\":\"否\",\"key\":\"B\"}]},{\"title\":\"你曾经作弊过吗？\",\"options\":[{\"score\":0,\"value\":\"是\",\"key\":\"A\"},{\"score\":0,\"value\":\"否\",\"key\":\"B\"}]},{\"title\":\"你曾经逃过课吗？\",\"options\":[{\"score\":0,\"value\":\"是\",\"key\":\"A\"},{\"score\":0,\"value\":\"否\",\"key\":\"B\"}]},{\"title\":\"你曾经偷偷用过家里的钱吗？\",\"options\":[{\"score\":0,\"value\":\"是\",\"key\":\"A\"},{\"score\":0,\"value\":\"否\",\"key\":\"B\"}]},{\"title\":\"你曾经偷偷试穿过朋友的衣服吗？\",\"options\":[{\"score\":0,\"value\":\"是\",\"key\":\"A\"},{\"score\":0,\"value\":\"否\",\"key\":\"B\"}]}]', 1847540058836811777, 1, '2024-10-19 15:37:44', '2024-10-19 15:37:44', 0);
INSERT INTO `question` VALUES (1848382683630321666, '[{\"title\":\"你更愿意选择什么？\",\"options\":[{\"score\":0,\"value\":\"我愿意接受大冒险\",\"key\":\"A\"},{\"score\":0,\"value\":\"我选择回答真心话\",\"key\":\"B\"}]},{\"title\":\"你认为自己是一个诚实的人吗？\",\"options\":[{\"score\":0,\"value\":\"是的\",\"key\":\"A\"},{\"score\":0,\"value\":\"不是\",\"key\":\"B\"}]},{\"title\":\"你更愿意向谁分享秘密？\",\"options\":[{\"score\":0,\"value\":\"朋友\",\"key\":\"A\"},{\"score\":0,\"value\":\"家人\",\"key\":\"B\"}]},{\"title\":\"你曾经撒过谎吗？\",\"options\":[{\"score\":0,\"value\":\"是的\",\"key\":\"A\"},{\"score\":0,\"value\":\"不是\",\"key\":\"B\"}]},{\"title\":\"你相信一见钟情吗？\",\"options\":[{\"score\":0,\"value\":\"是的\",\"key\":\"A\"},{\"score\":0,\"value\":\"不是\",\"key\":\"B\"}]},{\"title\":\"你曾经暗恋过某个人吗？\",\"options\":[{\"score\":0,\"value\":\"是的\",\"key\":\"A\"},{\"score\":0,\"value\":\"不是\",\"key\":\"B\"}]},{\"title\":\"你有过一段刻骨铭心的经历吗？\",\"options\":[{\"score\":0,\"value\":\"是的\",\"key\":\"A\"},{\"score\":0,\"value\":\"不是\",\"key\":\"B\"}]},{\"title\":\"你曾经为了某个人改变过自己吗？\",\"options\":[{\"score\":0,\"value\":\"是的\",\"key\":\"A\"},{\"score\":0,\"value\":\"不是\",\"key\":\"B\"}]},{\"title\":\"你愿意为了爱情放弃一切吗？\",\"options\":[{\"score\":0,\"value\":\"是的\",\"key\":\"A\"},{\"score\":0,\"value\":\"不是\",\"key\":\"B\"}]},{\"title\":\"你相信命运吗？\",\"options\":[{\"score\":0,\"value\":\"是的\",\"key\":\"A\"},{\"score\":0,\"value\":\"不是\",\"key\":\"B\"}]}]', 1848382484107280385, 1, '2024-10-21 23:15:47', '2024-10-21 23:15:47', 0);
INSERT INTO `question` VALUES (1848385561375850498, '[{\"title\":\"What is the French word for \'Hello\' ?\",\"options\":[{\"score\":1,\"value\":\"Bonjour\",\"key\":\"A\"},{\"score\":0,\"value\":\"Hello\",\"key\":\"B\"}]},{\"title\":\"What is the German word for \'Hello\' ?\",\"options\":[{\"score\":1,\"value\":\"GutenTag\",\"key\":\"A\"},{\"score\":0,\"value\":\"Goodbye\",\"key\":\"B\"}]},{\"title\":\"What is the Italian word for \'Hello\' ?\",\"options\":[{\"score\":1,\"value\":\"Ciao\",\"key\":\"A\"},{\"score\":0,\"value\":\"Hola\",\"key\":\"B\"}]},{\"title\":\"What is the Spanish word for \'Hello\'?\",\"options\":[{\"score\":1,\"value\":\"Hola\",\"key\":\"A\"},{\"score\":0,\"value\":\"Adiós\",\"key\":\"B\"}]},{\"title\":\"What is the Romanian word for \'Hello\' ?\",\"options\":[{\"score\":1,\"value\":\"Salut\",\"key\":\"A\"},{\"score\":0,\"value\":\"Aurevoir\",\"key\":\"B\"}]},{\"title\":\"What is the Russian word for \'Hello\' ?\",\"options\":[{\"score\":1,\"value\":\"Zdravstvuyte\",\"key\":\"A\"},{\"score\":0,\"value\":\"Spasibo\",\"key\":\"B\"}]},{\"title\":\"What is the Japanese word for \'Hello\' ?\",\"options\":[{\"score\":1,\"value\":\"Konnichiwa\",\"key\":\"A\"},{\"score\":0,\"value\":\"Arigatou\",\"key\":\"B\"}]},{\"title\":\"What is the Korean word for \'Hello\' ?\",\"options\":[{\"score\":1,\"value\":\"Annyeonghaseyo\",\"key\":\"A\"},{\"score\":0,\"value\":\"Kamsahamnida\",\"key\":\"B\"}]},{\"title\":\"What is the Chinese word for \'Hello\' ?\",\"options\":[{\"score\":1,\"value\":\"Nǐhǎo\",\"key\":\"A\"},{\"score\":0,\"value\":\"Xièxiè\",\"key\":\"B\"}]},{\"title\":\"What is the Arabic word for \'Hello\'?\",\"options\":[{\"score\":1,\"value\":\"Salaam\",\"key\":\"A\"},{\"score\":0,\"value\":\"Shukran\",\"key\":\"B\"}]}]', 1848384029393731585, 1, '2024-10-21 23:27:13', '2024-10-21 23:27:13', 0);

-- ----------------------------
-- Table structure for scoring_result
-- ----------------------------
DROP TABLE IF EXISTS `scoring_result`;
CREATE TABLE `scoring_result`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `resultName` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '结果名称，如物流师',
  `resultDesc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '结果描述',
  `resultPicture` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '结果图片',
  `resultProp` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '结果属性集合 JSON，如 [I,S,T,J]',
  `resultScoreRange` int NULL DEFAULT NULL COMMENT '结果得分范围，如 80，表示 80及以上的分数命中此结果',
  `appId` bigint NOT NULL COMMENT '应用 id',
  `userId` bigint NOT NULL COMMENT '创建用户 id',
  `createTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updateTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `isDelete` tinyint NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_appId`(`appId` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1846811561642213379 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '评分结果' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of scoring_result
-- ----------------------------
INSERT INTO `scoring_result` VALUES (1, 'ISTJ（物流师）', '忠诚可靠，被公认为务实，注重细节。', 'icon_url_istj', '[\"I\",\"S\",\"T\",\"J\"]', NULL, 1, 1, '2024-04-24 16:57:02', '2024-05-09 12:28:21', 0);
INSERT INTO `scoring_result` VALUES (2, 'ISFJ（守护者）', '善良贴心，以同情心和责任为特点。', 'icon_url_isfj', '[\"I\",\"S\",\"F\",\"J\"]', NULL, 1, 1, '2024-04-24 16:57:02', '2024-05-09 12:28:21', 0);
INSERT INTO `scoring_result` VALUES (3, 'INFJ（占有者）', '理想主义者，有着深刻的洞察力，善于理解他人。', 'icon_url_infj', '[\"I\",\"N\",\"F\",\"J\"]', NULL, 1, 1, '2024-04-24 16:57:02', '2024-05-09 12:28:21', 0);
INSERT INTO `scoring_result` VALUES (4, 'INTJ（设计师）', '独立思考者，善于规划和实现目标，理性而果断。', 'icon_url_intj', '[\"I\",\"N\",\"T\",\"J\"]', NULL, 1, 1, '2024-04-24 16:57:02', '2024-05-09 12:28:21', 0);
INSERT INTO `scoring_result` VALUES (5, 'ISTP（运动员）', '冷静自持，善于解决问题，擅长实践技能。', 'icon_url_istp', '[\"I\",\"S\",\"T\",\"P\"]', NULL, 1, 1, '2024-04-24 16:57:02', '2024-05-09 12:28:21', 0);
INSERT INTO `scoring_result` VALUES (6, 'ISFP（艺术家）', '具有艺术感和敏感性，珍视个人空间和自由。', 'icon_url_isfp', '[\"I\",\"S\",\"F\",\"P\"]', NULL, 1, 1, '2024-04-24 16:57:02', '2024-05-09 12:28:21', 0);
INSERT INTO `scoring_result` VALUES (7, 'INFP（治愈者）', '理想主义者，富有创造力，以同情心和理解他人著称。', 'icon_url_infp', '[\"I\",\"N\",\"F\",\"P\"]', NULL, 1, 1, '2024-04-24 16:57:02', '2024-05-09 12:28:21', 0);
INSERT INTO `scoring_result` VALUES (8, 'INTP（学者）', '思维清晰，探索精神，独立思考且理性。', 'icon_url_intp', '[\"I\",\"N\",\"T\",\"P\"]', NULL, 1, 1, '2024-04-24 16:57:02', '2024-05-09 12:28:21', 0);
INSERT INTO `scoring_result` VALUES (9, 'ESTP（拓荒者）', '敢于冒险，乐于冒险，思维敏捷，行动果断。', 'icon_url_estp', '[\"E\",\"S\",\"T\",\"P\"]', NULL, 1, 1, '2024-04-24 16:57:02', '2024-05-09 12:28:21', 0);
INSERT INTO `scoring_result` VALUES (10, 'ESFP（表演者）', '热情开朗，善于社交，热爱生活，乐于助人。', 'icon_url_esfp', '[\"E\",\"S\",\"F\",\"P\"]', NULL, 1, 1, '2024-04-24 16:57:02', '2024-05-09 12:28:21', 0);
INSERT INTO `scoring_result` VALUES (11, 'ENFP（倡导者）', '富有想象力，充满热情，善于激发他人的活力和潜力。', 'icon_url_enfp', '[\"E\",\"N\",\"F\",\"P\"]', NULL, 1, 1, '2024-04-24 16:57:02', '2024-05-09 12:28:21', 0);
INSERT INTO `scoring_result` VALUES (12, 'ENTP（发明家）', '充满创造力，善于辩论，挑战传统，喜欢探索新领域。', 'icon_url_entp', '[\"E\",\"N\",\"T\",\"P\"]', NULL, 1, 1, '2024-04-24 16:57:02', '2024-05-09 12:28:21', 0);
INSERT INTO `scoring_result` VALUES (13, 'ESTJ（主管）', '务实果断，善于组织和管理，重视效率和目标。', 'icon_url_estj', '[\"E\",\"S\",\"T\",\"J\"]', NULL, 1, 1, '2024-04-24 16:57:02', '2024-05-09 12:28:21', 0);
INSERT INTO `scoring_result` VALUES (14, 'ESFJ（尽责者）', '友善热心，以协调、耐心和关怀为特点，善于团队合作。', 'icon_url_esfj', '[\"E\",\"S\",\"F\",\"J\"]', NULL, 1, 1, '2024-04-24 16:57:02', '2024-05-09 12:28:21', 0);
INSERT INTO `scoring_result` VALUES (15, 'ENFJ（教导着）', '热情关爱，善于帮助他人，具有领导力和社交能力。', 'icon_url_enfj', '[\"E\",\"N\",\"F\",\"J\"]', NULL, 1, 1, '2024-04-24 16:57:02', '2024-05-09 12:28:21', 0);
INSERT INTO `scoring_result` VALUES (16, 'ENTJ（统帅）', '果断自信，具有领导才能，善于规划和执行目标。', 'icon_url_entj', '[\"E\",\"N\",\"T\",\"J\"]', NULL, 1, 1, '2024-04-24 16:57:02', '2024-05-09 12:28:21', 0);
INSERT INTO `scoring_result` VALUES (17, '首都知识大师', '你真棒棒哦，首都知识非常出色！', NULL, NULL, 9, 2, 1, '2024-04-25 15:05:44', '2024-05-09 12:28:21', 0);
INSERT INTO `scoring_result` VALUES (18, '地理小能手！', '你对于世界各国的首都了解得相当不错，但还有一些小地方需要加强哦！', NULL, NULL, 7, 2, 1, '2024-04-25 15:05:44', '2024-05-09 12:28:21', 0);
INSERT INTO `scoring_result` VALUES (19, '继续加油！', '还需努力哦', NULL, NULL, 0, 2, 1, '2024-04-25 15:05:44', '2024-05-09 12:28:21', 0);

-- ----------------------------
-- Table structure for user_0
-- ----------------------------
DROP TABLE IF EXISTS `user_0`;
CREATE TABLE `user_0`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `userAccount` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '账号',
  `userPassword` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
  `userName` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户昵称',
  `userAvatar` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户头像',
  `userProfile` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户简介',
  `userRole` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'user' COMMENT '用户角色：user/admin/ban',
  `createTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updateTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `isDelete` tinyint NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_0
-- ----------------------------

-- ----------------------------
-- Table structure for user_1
-- ----------------------------
DROP TABLE IF EXISTS `user_1`;
CREATE TABLE `user_1`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `userAccount` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '账号',
  `userPassword` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
  `userName` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户昵称',
  `userAvatar` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户头像',
  `userProfile` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户简介',
  `userRole` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'user' COMMENT '用户角色：user/admin/ban',
  `createTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updateTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `isDelete` tinyint NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_1
-- ----------------------------
INSERT INTO `user_1` VALUES (1, 'yupi', 'b0dd3697a192885d7c055db46155b26a', '鱼皮', 'https://k.sinaimg.cn/n/sinakd20110/560/w1080h1080/20230930/915d-f3d7b580c33632b191e19afa0a858d31.jpg/w700d1q75cms.jpg', '欢迎来编程导航学习', 'admin', '2024-05-09 11:13:13', '2024-05-09 15:07:48', 0);

-- ----------------------------
-- Table structure for user_answer_0
-- ----------------------------
DROP TABLE IF EXISTS `user_answer_0`;
CREATE TABLE `user_answer_0`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `appId` bigint NOT NULL COMMENT '应用 id',
  `appType` tinyint NOT NULL DEFAULT 0 COMMENT '应用类型（0-得分类，1-角色测评类）',
  `scoringStrategy` tinyint NOT NULL DEFAULT 0 COMMENT '评分策略（0-自定义，1-AI）',
  `choices` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '用户答案（JSON 数组）',
  `resultId` bigint NULL DEFAULT NULL COMMENT '评分结果 id',
  `resultName` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '结果名称，如物流师',
  `resultDesc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '结果描述',
  `resultPicture` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '结果图标',
  `resultScore` int NULL DEFAULT NULL COMMENT '得分',
  `userId` bigint NOT NULL COMMENT '用户 id',
  `createTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updateTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `isDelete` tinyint NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_appId`(`appId` ASC) USING BTREE,
  INDEX `idx_userId`(`userId` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1849332139569766402 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户答题记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_answer_0
-- ----------------------------

-- ----------------------------
-- Table structure for user_answer_1
-- ----------------------------
DROP TABLE IF EXISTS `user_answer_1`;
CREATE TABLE `user_answer_1`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `appId` bigint NOT NULL COMMENT '应用 id',
  `appType` tinyint NOT NULL DEFAULT 0 COMMENT '应用类型（0-得分类，1-角色测评类）',
  `scoringStrategy` tinyint NOT NULL DEFAULT 0 COMMENT '评分策略（0-自定义，1-AI）',
  `choices` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '用户答案（JSON 数组）',
  `resultId` bigint NULL DEFAULT NULL COMMENT '评分结果 id',
  `resultName` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '结果名称，如物流师',
  `resultDesc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '结果描述',
  `resultPicture` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '结果图标',
  `resultScore` int NULL DEFAULT NULL COMMENT '得分',
  `userId` bigint NOT NULL COMMENT '用户 id',
  `createTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updateTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `isDelete` tinyint NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_appId`(`appId` ASC) USING BTREE,
  INDEX `idx_userId`(`userId` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1850712093331062785 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户答题记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_answer_1
-- ----------------------------
INSERT INTO `user_answer_1` VALUES (1849331754033528832, 1847540058836811777, 1, 1, '[\"A\",\"B\",\"A\",\"B\",\"B\",\"A\",\"B\",\"A\",\"A\",\"A\"]', NULL, '部分诚实', '从你的回答来看，你在某些方面表现出了诚实的态度，但也有不少问题上选择了不完全坦白。例如，你承认了自己曾经撒过谎、迟到过、说过别人的坏话、逃过课以及偷偷用过家里的钱，这些都显示了你在面对一些较为严重的问题时能够勇敢地承认错误。然而，在一些相对较小的事情上，如偷吃零食、忘记带作业、偷偷看别人的手机等方面，你选择了否认。这可能是因为你觉得这些行为并不严重，或者担心被批评。总的来说，你是一个有勇气面对自己缺点的人，但在一些细节上还需要更加坦诚。希望你能继续保持诚实的品质，并在小事上也做到真实无欺。', NULL, NULL, 1, '2024-10-24 14:07:16', '2024-10-24 14:50:13', 0);
INSERT INTO `user_answer_1` VALUES (1849345519181471744, 1, 1, 0, '[\"B\",\"A\",\"B\",\"A\",\"B\",\"B\",\"A\",\"B\",\"B\",\"A\"]', 16, 'ENTJ（统帅）', '果断自信，具有领导才能，善于规划和执行目标。', 'icon_url_entj', NULL, 1, '2024-10-24 15:01:56', '2024-10-24 15:01:56', 0);
INSERT INTO `user_answer_1` VALUES (1849345574160408576, 1, 1, 0, '[\"A\",\"B\",\"B\",\"A\",\"B\",\"A\",\"B\",\"B\",\"A\",\"A\"]', 6, 'ISFP（艺术家）', '具有艺术感和敏感性，珍视个人空间和自由。', 'icon_url_isfp', NULL, 1, '2024-10-24 15:02:09', '2024-10-24 15:02:09', 0);
INSERT INTO `user_answer_1` VALUES (1849345637309849600, 1, 1, 0, '[\"B\",\"B\",\"A\",\"A\",\"B\",\"A\",\"A\",\"A\",\"A\",\"A\"]', 9, 'ESTP（拓荒者）', '敢于冒险，乐于冒险，思维敏捷，行动果断。', 'icon_url_estp', NULL, 1, '2024-10-24 15:02:25', '2024-10-24 15:02:25', 0);
INSERT INTO `user_answer_1` VALUES (1849347273914687488, 1848384029393731585, 0, 1, '[\"B\",\"B\",\"B\",\"B\",\"B\",\"B\",\"B\",\"B\",\"B\",\"B\"]', NULL, '待提高', '从你的回答来看，你在本次翻译竞赛中的表现并不理想。所有题目都选择了错误的答案，这可能是因为对这些语言的基本词汇不够熟悉。建议你多花时间学习不同语言的基础词汇和常用表达，可以通过观看相关的语言学习视频、阅读相关书籍或使用语言学习软件来提升自己的语言能力。此外，可以尝试与说这些语言的人进行交流，以增强实际应用能力。希望你在今后的学习中能够取得更好的成绩！', NULL, 0, 1, '2024-10-24 15:08:54', '2024-10-24 15:09:05', 0);
INSERT INTO `user_answer_1` VALUES (1850589149082689536, 1, 1, 0, '[\"A\",\"B\",\"A\",\"B\",\"A\",\"B\",\"A\",\"B\",\"A\",\"B\"]', 8, 'INTP（学者）', '思维清晰，探索精神，独立思考且理性。', 'icon_url_intp', NULL, 1, '2024-10-28 01:23:51', '2024-10-28 01:23:53', 0);
INSERT INTO `user_answer_1` VALUES (1850589325579001856, 1847540058836811777, 1, 1, '[\"B\",\"A\",\"A\",\"A\",\"A\",\"A\",\"A\",\"A\",\"A\",\"A\"]', NULL, '诚实度较低', '根据你的回答，你在多个问题上选择了肯定的答案。这些问题涉及日常生活中的小谎言、不守时、学业上的疏忽以及对他人隐私的侵犯等行为。虽然这些行为在一定程度上是人之常情，但频繁发生可能会影响你的人际关系和信誉。建议你在日常生活中更加注重诚信和自律，尽量避免撒谎、偷窃、作弊等不诚实的行为，同时也要尊重他人的隐私和财物。通过不断努力，相信你可以成为一个更加值得信赖的人。', NULL, NULL, 1, '2024-10-28 01:24:25', '2024-10-28 01:24:33', 0);
INSERT INTO `user_answer_1` VALUES (1850589485289709568, 1847540058836811777, 1, 1, '[\"B\",\"A\",\"A\",\"A\",\"A\",\"A\",\"A\",\"A\",\"A\",\"A\"]', NULL, '诚实度较低', '根据你的回答，你在多个问题上选择了肯定的答案。这些问题涉及日常生活中的小谎言、不守时、学业上的疏忽以及对他人隐私的侵犯等行为。虽然这些行为在一定程度上是人之常情，但频繁发生可能会影响你的人际关系和信誉。建议你在日常生活中更加注重诚信和自律，尽量避免撒谎、偷窃、作弊等不诚实的行为，同时也要尊重他人的隐私和财物。通过不断努力，相信你可以成为一个更加值得信赖的人。', NULL, NULL, 1, '2024-10-28 01:25:00', '2024-10-28 01:25:00', 0);
INSERT INTO `user_answer_1` VALUES (1850711903639470080, 1848384029393731585, 0, 1, '[\"A\",\"A\",\"A\",\"A\",\"A\",\"A\",\"A\",\"A\",\"A\",\"A\"]', NULL, '语言大师', '你在本次翻译竞赛中表现非常出色，所有题目都回答正确，展现了你对多种语言的熟练掌握。继续保持这种学习热情和认真态度，你的语言能力将会更加卓越。建议你可以尝试更多复杂的语言应用场景，如阅读原版文学作品、观看外语电影或参与国际交流活动，以进一步提升你的语言水平和文化理解能力。同时，也可以尝试学习一些小众语言，拓宽你的语言知识面。', NULL, 10, 1, '2024-10-28 09:31:40', '2024-10-28 09:31:48', 0);
INSERT INTO `user_answer_1` VALUES (1850712093331062784, 1848384029393731585, 0, 1, '[\"A\",\"A\",\"A\",\"A\",\"A\",\"A\",\"A\",\"A\",\"A\",\"A\"]', NULL, '语言大师', '你在本次翻译竞赛中表现非常出色，所有题目都回答正确，展现了你对多种语言的熟练掌握。继续保持这种学习热情和认真态度，你的语言能力将会更加卓越。建议你可以尝试更多复杂的语言应用场景，如阅读原版文学作品、观看外语电影或参与国际交流活动，以进一步提升你的语言水平和文化理解能力。同时，也可以尝试学习一些小众语言，拓宽你的语言知识面。', NULL, 10, 1, '2024-10-28 09:32:12', '2024-10-28 09:32:12', 0);

SET FOREIGN_KEY_CHECKS = 1;
