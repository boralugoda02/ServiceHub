package com.mycompany.servicehub.dao;

import java.io.IOException;

public class BackupRestoreDAO {
    // MySQL bin folder path - පද්ධතියට අනුව මෙය වෙනස් කරගන්න
    private final String mysqlPath = "C:\\Program Files\\MySQL\\MySQL Server 8.0\\bin\\";
    private final String dbName = "servicehub";
    private final String dbUser = "root";
    private final String dbPass = "password";
    private final String backupPath = "C:\\Backups\\backup.sql";

    public void performBackup() throws IOException {
        String command = mysqlPath + "mysqldump -u " + dbUser + " -p" + dbPass + " " + dbName + " -r " + backupPath;
        Runtime.getRuntime().exec(command);
    }

    public void performRestore() throws IOException {
        String[] command = {"cmd.exe", "/c", mysqlPath + "mysql -u " + dbUser + " -p" + dbPass + " " + dbName + " < " + backupPath};
        Runtime.getRuntime().exec(command);
    }
}