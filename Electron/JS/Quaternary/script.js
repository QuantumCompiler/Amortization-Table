// Interest rate function
function Rate() {
  // Get interest rate from user
  var rate = document.getElementById("Rate").value;
  var monthly = 1.0 / 12.0;
  rate /= 100;
  rate = Math.pow(1 + rate, monthly) - 1.0;
  return rate;
  document.getElementById("flurdbop").innerHTML = rate;
}
// Monthly payment
function MonthPay() {
  // Get remaining loan amount from user
  var amount = document.getElementById("Amount").value;
  // Get remaining months from user
  var months = document.getElementById("Months").value;
  // Monthly Rate
  var monthRate = Rate();
  // Montly pay amount
  var monthPay = amount * monthRate / (1 - Math.pow(1 + monthRate, -months));
  return monthPay;
}
/* Function that actually ammortizes the loan */
function Calculate() {
   // Disable Button so it can only be clicked once
   document.getElementById("Calculate").disabled = true;
   document.getElementById("Calculate").style.visibility = "hidden";
   // Collect Months Remaining from user for the for loop to end
   var months = document.getElementById("Months").value;
   // Collect Amount Remaining from user to be put in table
   var remaining = document.getElementById("Amount").value;
   // Get ID for table from HTML file
   var table = document.getElementById("Amortization");
   // Insert a default row from here:
   var Entry = table.insertRow(1);
   var col0 = Entry.insertCell(0);
   var col1 = Entry.insertCell(1);
   var col2 = Entry.insertCell(2);
   var col3 = Entry.insertCell(3);
   var col4 = Entry.insertCell(4);
   col0.innerHTML = months;
   col1.innerHTML = "-";
   col2.innerHTML = "-";
   col3.innerHTML = "-";
   col4.innerHTML = "$" + remaining;
   // -----> to here
   // For loop that will do the calculating for each additional row and column
   for (i = 1; i <= months; i++) {
     // Interest that is paid monthly
     var interest = remaining*Rate();
     // Principal paid monthly
     var principal = Math.abs(MonthPay()) - interest;
     // Remaining Payment
     remaining = remaining - principal;
     var Entry = table.insertRow(i + 1);
     var col0 = Entry.insertCell(0);
     var col1 = Entry.insertCell(1);
     var col2 = Entry.insertCell(2);
     var col3 = Entry.insertCell(3);
     var col4 = Entry.insertCell(4);
     col0.innerHTML = (months - i);
     col1.innerHTML = "$" + Math.abs(MonthPay()).toFixed(2);
     col2.innerHTML = "$" + principal.toFixed(2);
     col3.innerHTML = "$" + interest.toFixed(2);
     col4.innerHTML = "$" + Math.abs(remaining.toFixed(2));
    }
  }

  /* Function to clear table */
  function Remove() {
    document.getElementById("Calculate").disabled = false;
    document.getElementById("Calculate").style.visibility = "";
    document.getElementById("Amount").value = '';
    document.getElementById("Rate").value = '';
    document.getElementById("Months").value = '';
    var table = document.getElementById("Amortization");
    var rowCount = table.rows.length;
    while (table.rows.length >= 1) {
      table.deleteRow(1);
    }
  }

  /* Enter press detection */
  $(document).keypress(function(e) {
    if(e.which == 13) {
      document.getElementById("Calculate").click();
    }
  });