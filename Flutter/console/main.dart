import 'dart:math';

/*  Calculate - Creates an amortization table for a given loan, interest, and length of loan
    Input:
      annualRate - Double that represents an annual nominal interest rate
      loanAmount - Double that represents the total loan amount
      totalMonths - Integer that represents the number of months in the loan
    Algorithm:
      * Create placeholders for the the values that will be calculated in each iteration
      * Create lists to hold the values in the list for payments, interest, and principal
      * Print the original values of the loan
      * Iterate over the total length of the loan
        * Calculate the interest, principal, and remaining loan after the current month
        * Add the values to their respective lists
        * Print the data from the current month
      * Sum up the totals for each respective value
      * Print the final values of the array
    Output:
      This function does not return a value
*/
void Calculate(double annualRate, double loanAmount, int totalMonths) {
  double remaining_loan_amount = loanAmount;
  double monthly_payment = MonthlyPayment(annualRate, loanAmount, totalMonths);
  double monthly_effective_interest = MonthlyRate(annualRate);
  double monthly_interest_amount = 0;
  double monthly_principal_amount = 0;
  List<double> total_payments = [];
  List<double> total_interest = [];
  List<double> total_principal = [];
  print('Month: 0, Loan Left: \$${roundDollar(remaining_loan_amount, 2)}, Principal Paid: \$${roundDollar(monthly_principal_amount, 2)}, Interest Paid: \$${roundDollar(monthly_interest_amount, 2)}, Total Payment: \$${roundDollar(0, 2)}');
  for (int i = 1; i <= totalMonths; i++) {
    monthly_interest_amount = remaining_loan_amount * monthly_effective_interest;
    monthly_principal_amount = monthly_payment - monthly_interest_amount;
    remaining_loan_amount -= monthly_principal_amount;
    total_payments.add(roundDollar(monthly_payment, 2));
    total_interest.add(roundDollar(monthly_interest_amount, 2));
    total_principal.add(roundDollar(monthly_principal_amount, 2));
    print('Month: $i, Loan Left: \$${roundDollar(remaining_loan_amount, 2)}, Principal Paid: \$${roundDollar(monthly_principal_amount, 2)}, Interest Paid: \$${roundDollar(monthly_interest_amount, 2)}, Monthly Payment: \$${roundDollar(monthly_payment, 2)}');
  }
  double final_payments = roundDollar(total_payments.fold(0, (previousValue, element) => previousValue + element), 2);
  double final_interest = roundDollar(total_interest.fold(0, (previousValue, element) => previousValue + element), 2);
  double final_principal = roundDollar(total_principal.fold(0, (previousValue, element) => previousValue + element), 2);
  print('Total Principal Paid: \$${final_principal} , Total Interest Paid: \$${final_interest} , Total Paid: \$${final_payments}');
}

/*  MonthlyPayment - Calculates the monthly payment with the annual nominal rate, remaining loan amount, and remaining months
    Input:
      annualRate - Double that represents the annual nominal interest rate
      remainingAmount - Double that represents the remaining loan amount
      monthsRemaining - Integer that represents the remaining months of the loan
    Algorithm:
      * Calculate and return the monthly payment from the formula
    Output:
      This function returns the monthly payment for a given loan
*/
double MonthlyPayment(double annualRate, double remainingAmount, int monthsRemaining) {
  return remainingAmount * MonthlyRate(annualRate) / (1 - pow(1 + MonthlyRate(annualRate), -monthsRemaining));;
}

/*  MonthlyRate - Calculates the monthly interest rate from an annual nominal interest rate
    Input:
      annualRate - Double that represents the annual nominal interest rate for a given loan
    Algorithm:
      * Calculate and return the monthly interest rate from the formula
    Output:
      This function returns the effective monthly interest rate from an annual nominal interest rate
*/
double MonthlyRate(double annualRate) {
  return pow(1 + (annualRate / 100), 1.0 / 12.0) - 1.0;
}

/*  roundDollar - Rounds a currency to two decimal places
    Input:
      value - Double that is to be rounded
      places - Integer for the total number of decimal places that a value is to be rounded to
    Algorithm:
      * Round the value to the number of decimal places that it needs to be rounded to
    Output:
      This function returns the rounded value to the desired number of decimal places
*/
double roundDollar(double value, int places) {
  double mod = pow(10.0, places).toDouble();
  return ((value * mod).round().toDouble() / mod);
}

void main() {
  Calculate(8.5, 1000, 12);
}