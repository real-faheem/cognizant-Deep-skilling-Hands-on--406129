class Logger {
    private static Logger instance;

    // Private constructor prevents instantiation from other classes
    private Logger() {
        System.out.println("Logger instance created");
    }

    // Public method to provide access to the instance
    public static Logger getInstance() {
        if (instance == null) {
            instance = new Logger();
        }
        return instance;
    }

    // A sample method to simulate logging
    public void log(String message) {
        System.out.println("Log: " + message);
    }
}

public class SingletonPatternExample {
    public static void main(String[] args) {
        // First access to the Logger - instance will be created
        Logger logger1 = Logger.getInstance();
        logger1.log("First log message");

        // Second access to the Logger - same instance will be used
        Logger logger2 = Logger.getInstance();
        logger2.log("Second log message");

        // Verifying if both references point to the same object
        System.out.println("Are both instances same: " + (logger1 == logger2));
    }
}
