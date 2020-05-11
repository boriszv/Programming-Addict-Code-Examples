CREATE TABLE IF NOT EXISTS `__EFMigrationsHistory` (
    `MigrationId` varchar(95) NOT NULL,
    `ProductVersion` varchar(32) NOT NULL,
    CONSTRAINT `PK___EFMigrationsHistory` PRIMARY KEY (`MigrationId`)
);

CREATE TABLE `APIKey` (
    `ID` char(36) NOT NULL,
    CONSTRAINT `PK_APIKey` PRIMARY KEY (`ID`)
);

CREATE TABLE `Note` (
    `NoteID` char(36) NOT NULL,
    `NoteTitle` varchar(50) NOT NULL,
    `NoteContent` longtext NOT NULL,
    `CreateDateTime` datetime(6) NOT NULL,
    `LatestEditDateTime` datetime(6) NULL,
    `APIKeyID` char(36) NOT NULL,
    CONSTRAINT `PK_Note` PRIMARY KEY (`NoteID`),
    CONSTRAINT `FK_Note_APIKey_APIKeyID` FOREIGN KEY (`APIKeyID`) REFERENCES `APIKey` (`ID`) ON DELETE CASCADE
);

CREATE INDEX `IX_Note_APIKeyID` ON `Note` (`APIKeyID`);

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20190911084815_InitialMigration', '2.2.2-servicing-10034');

