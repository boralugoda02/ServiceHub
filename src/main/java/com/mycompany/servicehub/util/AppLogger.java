package com.mycompany.servicehub.util;

import java.util.logging.*;
import java.io.File;
import java.io.IOException;

public class AppLogger {
    private static final Logger logger = Logger.getLogger("ServiceHubLogger");

    static {
        try {
            // 1. Define folder and file path
            String logPath = "logs/app.log";
            File logDir = new File("logs");
            
            // 2. Create the directory if it does not exist
            if (!logDir.exists()) {
                logDir.mkdir();
            }

            // 3. Initialize FileHandler
            FileHandler fh = new FileHandler(logPath, true);
            
            // 4. Set formatter
            SimpleFormatter formatter = new SimpleFormatter();
            fh.setFormatter(formatter);
            
            // 5. Add handler to logger
            logger.addHandler(fh);
            
        } catch (IOException | SecurityException e) {
            System.err.println("Could not setup logger: " + e.getMessage());
        }
    }

    public static void logInfo(String message) {
        logger.info(message);
    }

    public static void logError(String message) {
        logger.severe(message);
    }
}