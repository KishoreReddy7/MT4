//+------------------------------------------------------------------+
//|                               Fibonacci Killer Indicator (R).mq4 |
//|                                                                  |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright ""
#property link      ""

#property indicator_chart_window
extern bool   soundAlerts = true;
extern bool   emailAlerts = false;

int init()
{
   return(0);
}

int deinit()
{
   return(0);
}

int start()
{
   if(Open[0] == Close[0] &&
      Open[0] == High[0] &&
      Open[0] == Low[0] &&
      GlobalVariableCheck("fiboalert"))
      GlobalVariableDel("fiboalert");
   
   //Find lowest low and highets High
   int il = iLowest(Symbol(), 0, MODE_LOW, 50, 0);
   int ih = iHighest(Symbol(), 0, MODE_HIGH, 50, 0);
   int later = MathMax(il, ih);
   double l = Low[il];
   double h = High[ih];
   
   //Plot 38.2
   double l382;
   if(il < ih)
      l382 = (h-l)*0.382 + l;
   else
      l382 = h-(h-l)*0.382;

   if(ObjectType("l3") != OBJ_TREND) ObjectDelete("l3");
   if(ObjectGet("l3", OBJPROP_PRICE1) != l382) ObjectDelete("l3");
   ObjectCreate("l3", OBJ_TREND, 0, Time[later], l382, Time[0], l382); 
   ObjectSet("l3", OBJPROP_STYLE, STYLE_DASH);

   //Write label: Fibonacci 38.2 is at :   
   if(ObjectType("fibo") != OBJ_LABEL) ObjectDelete("fibo");
   if(ObjectFind("fibo") == -1) ObjectCreate("fibo", OBJ_LABEL, 0, Time[5], Close[5]);
   ObjectSetText("fibo", "FibonacciKiller (R) :: 38.2 level is at " + DoubleToStr(l382,4));
   ObjectSet("fibo", OBJPROP_CORNER, 4);
   ObjectSet("fibo", OBJPROP_FONTSIZE, 12);
   ObjectSet("fibo", OBJPROP_XDISTANCE, 5);
   ObjectSet("fibo", OBJPROP_YDISTANCE, 20);
   
   //Alert if price is close
   double ATR = iATR(Symbol(), 0, 50, 1);
   if(MathAbs(Close[0] - l382) < ATR)
   {
      if(!GlobalVariableCheck("fiboalert"))
      {
         //Alert code here
         if(soundAlerts)
            Alert("Price is near Fibonacci Retracement at " + l382 + ", " + Symbol() + "! Get ready for trade.");
      
         if(emailAlerts)
            SendMail("Price is near Fibonacci Retracement at " + l382, "Price is near Fibonacci Retracement at " + l382 + ", " + Symbol() + "! Get ready for trade.");
         
         GlobalVariableSet("fiboalert", 1);
      }
   }
   
   return(0);
}