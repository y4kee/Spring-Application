CREATE TABLE IF NOT EXISTS persons(
    `id` bigint(20) NOT NULL AUTO_INCREMENT,
    `name` varchar(255) DEFAULT NULL,
    PRIMARY KEY (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT  INTO persons(name) VALUES('Nastya');
INSERT  INTO persons(name) VALUES('Maksym');
INSERT  INTO persons(name) VALUES('Andriy');
INSERT  INTO persons(name) VALUES('Dasha');
INSERT  INTO persons(name) VALUES('Masha');
