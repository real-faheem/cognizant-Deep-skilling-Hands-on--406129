// FinancialForecast.java

public class FinancialForecast {

    // Step 2 & 3: Recursive function to calculate future value
    public static double predictFutureValue(double currentValue, double growthRate, int years) {
        if (years == 0) {
            return currentValue;
        }
        return predictFutureValue(currentValue * (1 + growthRate), growthRate, years - 1);
    }

    public static void main(String[] args) {
        double initialValue = 10000; // Starting value
        double growthRate = 0.08;    // 8% annual growth
        int years = 5;               // Predict for 5 years

        double futureValue = predictFutureValue(initialValue, growthRate, years);
        System.out.printf("Predicted value after %d years: %.2f\n", years, futureValue);
    }
}
