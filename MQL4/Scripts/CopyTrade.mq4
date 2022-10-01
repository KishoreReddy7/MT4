#property link          "https://www.sanjureddy.in"
#property version       "1.00"
#property strict
#property copyright     "SanjuReddy.in - 2022"
#property show_inputs
#property description   "This script will open all the chats of currency pairs"
#property description   "in a specified time frame"
#property icon          "\\Files\\EF-Icon-64x64px.ico"

#define ORDERS_FILE "OCTAFX/open_orders.csv"

extern int MAGIC = 77;
extern double VOLUME = 0.01;
extern int SLIPPAGE = 0;
extern double SL = 100;

bool FINISHED_Execution = false;

string orders[99];
void OnStart() {
   while(!FINISHED_Execution){
      if(IsStopped() != 0 || IsTesting()) FINISHED_Execution = true;
      else {
         //Process();
      }
   }
}

void Process() {
   ArrayFree(orders);
   ArrayResize(orders, 99, 0);
   ResetLastError();
   
   int fp = FileOpen(ORDERS_FILE, FILE_READ, ",");
   int line_number = 0;
   if(fp != INVALID_HANDLE) {
      int str_size;
      string str;
      while(!FileIsEnding(fp)) {
         str_size = FileReadInteger(fp, INT_VALUE);
         str = FileReadString(fp, str_size);
         if(StringLen(str) < 5) continue;
         orders[line_number] = str;
         line_number++;
      }
   }
   FileClose(fp);
   
   for(int i = 0; i < ArraySize(orders); i++) {
      if(StringLen(orders[i]) == 0) continue;
      string str = orders[i];
      string result[];
      int split = StringSplit(str, StringGetCharacter("|",0) , result);
      
      if(split > 0) {
         datetime now = TimeLocal();
         int date = TimeDay(now);
         int month = TimeMonth(now);
         int year = TimeYear(now);
         int hour = TimeHour(now);
         int min = TimeMinute(now);
         
         string master = result[0];
         string symbol = result[1];
         string order = result[2];
         string d = result[3]; StringReplace(d, "-", "");
         string t = result[4]; StringReplace(t, ":", "");
         double volume = NormalizeDouble(StrToDouble(result[5]), 2);
         
         string dateTime = StringFormat("%04d", year) + "-" + StringFormat("%02d", month) + "-" + StringFormat("%02d", date) + "|" + StringFormat("%02d", hour) + ":";
         int val = StringFind(str, dateTime + StringFormat("%02d", min));

         if(val != -1) {
            string comment = master + symbol + order + d + t;
            if(!HasThisOrder(comment, order, symbol)) {
               PlaceThisOrder(comment, order, volume, symbol);
            }
         }
      }
   }
   CheckAndCloseOrders();
}

bool HasThisOrder(string comment, string orderType, string symbol) {
   for(int cpt = OrdersTotal(); cpt >=0; cpt--) {
      OrderSelect(cpt, SELECT_BY_POS, MODE_TRADES);
      if(OrderMagicNumber() == MAGIC && OrderSymbol() == symbol) {
         if(OrderType() == OP_BUY || OrderType() == OP_SELL) {
            if(OrderComment() == comment) return true;
         }
      }
   }
   return false;
}

void PlaceThisOrder(string comment, string orderType, double volume, string symbol) {
   if(Symbol() != symbol) {
      ChartOpen(symbol, PERIOD_M1);
      ChartClose(ChartID());
   }
   int point = 100000;
   if(StringFind(symbol, "JPY") != -1) point = 1000;
   if(StringFind(symbol, "XAU") != -1) point = 100;
   if(orderType == "buy") {
      OrderSend(symbol, OP_BUY, VOLUME, Ask, SLIPPAGE, (Bid - SL / point), 0, comment, MAGIC, 0, clrBlue);
   } else if(orderType == "sell") {
      OrderSend(symbol, OP_SELL, VOLUME, Bid, SLIPPAGE, (Ask + SL / point), 0, comment, MAGIC, 0, clrRed);
   }
}

void CheckAndCloseOrders() {
   for(int cpt = OrdersTotal(); cpt >= 0; cpt--) {
      OrderSelect(cpt, SELECT_BY_POS, MODE_TRADES);
      if(OrderMagicNumber() == MAGIC) {
         if(OrderType() == OP_BUY || OrderType() == OP_SELL) {
            if(!IsThisOrderStillOpen(OrderComment())) {
               if(OrderType() == OP_BUY) {
                  OrderClose(OrderTicket(), OrderLots(), Bid, 0);
               } else if(OrderType() == OP_SELL) {
                  OrderClose(OrderTicket(), OrderLots(), Ask, 0);
               }
            }
         }
      }
   }
}

bool IsThisOrderStillOpen(string comment) {
   for(int i = 0; i < ArraySize(orders); i++) {
      if(StringLen(orders[i]) == 0) continue;
      string str = orders[i];
      StringReplace(str, "|", "");
      StringReplace(str, "-", "");
      StringReplace(str, ":", "");
      if(StringFind(str, comment) != -1) {
         return true;
      }
   }
   return false;
}
