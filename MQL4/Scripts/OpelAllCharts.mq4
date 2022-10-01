#property link          "https://www.sanjureddy.in"
#property version       "1.00"
#property strict
#property copyright     "SanjuReddy.in - 2022"
#property show_inputs
#property description   "This script will open all the chats of currency pairs"
#property description   "in a specified time frame"
#property icon          "\\Files\\EF-Icon-64x64px.ico"

#define TEMPLATE "EA_OCTAFX"

input ENUM_TIMEFRAMES Timeframe = PERIOD_M1;


void OnStart()
{
   int total_symbols = SymbolsTotal(false);
   for (int i = 0; i < total_symbols; i++) {
      string symbol = SymbolName(i, false);
      if (StringFind(symbol, "EUR", 0) != -1 ||
          StringFind(symbol, "USD", 0) != -1 ||
          StringFind(symbol, "GBP", 0) != -1 ||
          StringFind(symbol, "JPY", 0) != -1 ||
          StringFind(symbol, "CAD", 0) != -1 ||
          StringFind(symbol, "CHF", 0) != -1 ||
          StringFind(symbol, "AUD", 0) != -1 ||
          StringFind(symbol, "NZD", 0) != -1 ||
          StringFind(symbol, "XAU", 0) != -1) {
         long chartId = ChartOpen(symbol, Timeframe);
         if (chartId == 0) {
            Print("Error opening " + symbol + " chart: " + IntegerToString(GetLastError()));
         } else {
            ChartApplyTemplate(chartId, TEMPLATE); 
         }
      }
   }
}