CREATE TABLE IF NOT EXISTS `castle24h_dominate_history` (
	`id` int unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`guild_id` int NOT NULL,
	`player_id` int NOT NULL,
	`created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

	FOREIGN KEY (`guild_id`) REFERENCES guilds(`id`),
	FOREIGN KEY (`player_id`) REFERENCES players(`id`)
)
