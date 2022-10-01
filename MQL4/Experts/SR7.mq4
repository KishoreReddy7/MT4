//+------------------------------------------------------------------+
//|                                                          SR7.mq4 |
//|                                     Copyright 2022, Sanju Reddy. |
//|                                            https://sanjureddy.in |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, Sanju Reddy."
#property link      "https://sanjureddy.in"
#property version   "1.00"
#property strict
#property copyright     "Sanju Reddy - 2022"
#property show_inputs
#property description   "This is going to bring a big change to your bank balance"
#property icon          "\\Files\\SR7.ico"

#include <Controls\Dialog.mqh>

#include <Controls\Panel.mqh>

#include <Controls\Label.mqh>

CAppDialog MyAppDialog;

CPanel      dashboard_panel;

CLabel      dashboard_text_title;

CLabel      dashboard_text_balance;

CLabel      dashboard_text_equity;

CLabel      dashboard_text_profit_loss;

CLabel      dashboard_text_draw_down;

CLabel      dashboard_text_pip_spread;

CLabel      dashboard_text_symbol;

CLabel      dashboard_text_server;

CLabel      dashboard_text_date;

enum UsageOptions{
   RISK = 1,
   LOT = 2,
};

extern int PAIR_POINTS = 5; // NUMBER OF POINTS FOR THIS PAIR
extern UsageOptions USE = RISK;
extern double USEVAL = 25; // RISK PERCENTAGE / LOT SIZE
extern int MAGIC = 77; // MAGIC NUMBER
extern int SLIPPAGE = 3;
extern double SL = 250; // STOP LOSS
extern double SMART_SL = 100; // SMART STOP LOSS
extern double TP = 250; // TAKE PROFIT
extern ENUM_TIMEFRAMES TIMEFRAME = PERIOD_M15;
extern int TRADE_START_HOUR = 1; // TRADE START HOUR
extern int TRADE_END_HOUR = 23; // TRADE END HOUR
extern int MAX_ALLOWED_CANDLE_SIZE_FOR_SINGAL = 150; // MAX CANDLE SIZE TO CONSIDER FOR SIGNAL
extern int DAILY_TARGET = 350; // DAILY TARGET PIPS + 100

double DEF_NULL = 2147483647.0;

datetime NewCandleTime = TimeCurrent();
bool IS_NEW_CANDLE = false;
int SPREAD = 0;
double MAXLOT = 0.01;
bool CAN_TRADE = false;
int STOPLEVEL = 25;

double OrderLot = 0;

int SIGNAL = 0;
// 0  -  No Signal
// 1  -  Buy
// 2  -  Sell

bool TRADE_TODAY = true;

int OnInit() {
   MyAppDialog.Create(0,"MyAppDialog",0,10,20,340,300); 
   dashboard_panel.Create(0,"dashboard_panel",0,10,20,340,300);
   dashboard_panel.ColorBackground(clrBlack);
   ChartSetInteger(0, CHART_SHOW_GRID, false);
   ChartSetInteger(0, CHART_SHOW_ASK_LINE, true); 
   ChartSetInteger(0, CHART_MODE, CHART_CANDLES);
   ChartSetSymbolPeriod(0, NULL, TIMEFRAME);
   return(INIT_SUCCEEDED);
}

void OnDeinit(const int reason) {
}

void OnTick() {
   SetValues();
   
   if(IS_NEW_CANDLE) {
      StartProcess();
   }
   
   ShowAccountInfo("SR7");
}

void SetValues() {
   if(Hour() < TRADE_START_HOUR) TRADE_TODAY = true;

   if(Hour() >= TRADE_START_HOUR && Hour() <= TRADE_END_HOUR && TRADE_TODAY) {
      CAN_TRADE = true;
      if(OrderLot == 0) {
         OrderLot = GetLotSize();
      }
   } else {
      CAN_TRADE = false;
      OrderLot = 0;
   }
   
   SPREAD = MarketInfo(Symbol(), MODE_SPREAD);
   IS_NEW_CANDLE = IsNewCandle();
   MAXLOT = MarketInfo(Symbol(), MODE_MAXLOT);
   STOPLEVEL = MarketInfo(Symbol(), MODE_STOPLEVEL);
   
}

void StartProcess() {
   if(CanCheckForOrderAvailability()) {
      CheckAndPlaceOrder();
   } else {
      Manage();
   }
}

void CheckAndPlaceOrder() {
   if(BuyConditionsSatisfied()) {
      PlaceBuyOrder();
   } else if(SellConditionsSatisfied()) {
      PlaySellOrder();
   }
}

bool BuyConditionsSatisfied() {
   bool c1 = false, c2 = false, c3 = false, c4 = false;
   
   if(IsBullishCandle(0, 1) && iOpen(Symbol(), 0, 1) <= GetEMA(0, 1, 25) && iClose(Symbol(), 0, 1) >= GetEMA(0, 1, 25)) {
      if(Minute() >= 30) {
         if(IsBullishCandle(PERIOD_H1, 0) && iOpen(Symbol(), PERIOD_H1, 0) <= GetEMA(PERIOD_H1, 0, 25) && iClose(Symbol(), PERIOD_H1, 0) >= GetEMA(PERIOD_H1, 0, 25)) {
            return true;
         }
      } else {
         if(IsBullishCandle(PERIOD_H1, 1) && iOpen(Symbol(), PERIOD_H1, 1) <= GetEMA(PERIOD_H1, 1, 25) && iClose(Symbol(), PERIOD_H1, 1) >= GetEMA(PERIOD_H1, 1, 25)) {
            return true;
         }
      }
   }
   
   return false;
}

bool SellConditionsSatisfied() {
   bool c1 = false, c2 = false, c3 = false, c4 = false;
   
   if(IsBearishCandle(0, 1) && iOpen(Symbol(), 0, 1) >= GetEMA(0, 1, 25) && iClose(Symbol(), 0, 1) <= GetEMA(0, 1, 25)) {
      if(Minute() >= 30) {
         if(IsBearishCandle(PERIOD_H1, 0) && iOpen(Symbol(), PERIOD_H1, 0) >= GetEMA(PERIOD_H1, 0, 25) && iClose(Symbol(), PERIOD_H1, 0) <= GetEMA(PERIOD_H1, 0, 25)) {
            return true;
         }
      } else {
         if(IsBearishCandle(PERIOD_H1, 1) && iOpen(Symbol(), PERIOD_H1, 1) >= GetEMA(PERIOD_H1, 1, 25) && iClose(Symbol(), PERIOD_H1, 1) <= GetEMA(PERIOD_H1, 1, 25)) {
            return true;
         }
      }
   }
   
   return false;
}

void PlaceBuyOrder() {
   if(OrderLot > 0) {
      TRADE_TODAY = false;
      double sl = 0;
      if(SL > 0) {
         sl = Ask - SL * Point();
      }
      double tp = 0;
      if(TP > 0) {
         tp = Ask + TP * Point();
      }
      int ord = OrderSend(Symbol(), OP_BUY, OrderLot, Ask, SLIPPAGE, sl, tp, NULL, MAGIC, 0, clrBlue);
   }
}

void PlaySellOrder() {
   if(OrderLot > 0) {
      TRADE_TODAY = false;
      double sl = 0;
      if(SL > 0) {
         sl = Bid + SL * Point();
      }
      double tp = 0;
      if(TP > 0) {
         tp = Bid - TP * Point();
      }
      int ord = OrderSend(Symbol(), OP_SELL, OrderLot, Bid, SLIPPAGE, sl, tp, NULL, MAGIC, 0, clrRed);
   }
}

void Manage() {
}

void SetSL() {
   for(int cpt = OrdersTotal() - 1; cpt >= 0; cpt--) {
      int sel = OrderSelect(cpt, SELECT_BY_POS, MODE_TRADES);
      if(OrderSymbol() == Symbol() && OrderMagicNumber() == MAGIC) {
         if(OrderType() == OP_BUY) {
            double newSL = BankersRound(Bid - SMART_SL * Point(), PAIR_POINTS);
            double oldSL = BankersRound(OrderStopLoss(), PAIR_POINTS);
            
            if(newSL > oldSL || oldSL == 0) {
               int mod = OrderModify(OrderTicket(), OrderOpenPrice(), newSL, OrderTakeProfit(), 0);
            }
         } else if(OrderType() == OP_SELL) {
            double newSL = BankersRound(Ask + SMART_SL * Point(), PAIR_POINTS);
            double oldSL = BankersRound(OrderStopLoss(), PAIR_POINTS);
            
            if(newSL < oldSL || oldSL == 0) {
               int mod = OrderModify(OrderTicket(), OrderOpenPrice(), newSL, OrderTakeProfit(), 0);
            }
         }
      }
   }
}

void SetSLToZero() {
   for(int cpt = OrdersTotal() - 1; cpt >= 0; cpt--) {
      int sel = OrderSelect(cpt, SELECT_BY_POS, MODE_TRADES);
      if(OrderSymbol() == Symbol() && OrderMagicNumber() == MAGIC) {
         if(OrderType() == OP_BUY) {
            double newSL = BankersRound(OrderOpenPrice(), PAIR_POINTS);
            if(BankersRound(Bid - OrderOpenPrice(), PAIR_POINTS) / Point() < STOPLEVEL) newSL = BankersRound(Bid - STOPLEVEL * Point(), PAIR_POINTS);
            double oldSL = BankersRound(OrderStopLoss(), PAIR_POINTS);
            
            if(newSL > oldSL || oldSL == 0) {
               int mod = OrderModify(OrderTicket(), OrderOpenPrice(), newSL, OrderTakeProfit(), 0);
            }
         } else if(OrderType() == OP_SELL) {
            double newSL = BankersRound(OrderOpenPrice(), PAIR_POINTS);
            if(BankersRound(OrderOpenPrice() - Ask, PAIR_POINTS) / Point() < STOPLEVEL) newSL = BankersRound(Ask + STOPLEVEL * Point(), PAIR_POINTS);
            double oldSL = BankersRound(OrderStopLoss(), PAIR_POINTS);
            
            if(newSL < oldSL || oldSL == 0) {
               int mod = OrderModify(OrderTicket(), OrderOpenPrice(), newSL, OrderTakeProfit(), 0);
            }
         }
      }
   }
}

void SetTPToZero() {
   for(int cpt = OrdersTotal() - 1; cpt >= 0; cpt--) {
      int sel = OrderSelect(cpt, SELECT_BY_POS, MODE_TRADES);
      if(OrderSymbol() == Symbol() && OrderMagicNumber() == MAGIC) {
         if(OrderType() == OP_BUY) {
            double newTP = BankersRound(OrderOpenPrice(), PAIR_POINTS);
            if(BankersRound(OrderOpenPrice() - Bid, PAIR_POINTS) / Point() < STOPLEVEL) newTP = BankersRound(Bid + STOPLEVEL * Point(), PAIR_POINTS);
            double oldTP = BankersRound(OrderStopLoss(), PAIR_POINTS);
            
            if(oldTP == 0) {
               int mod = OrderModify(OrderTicket(), OrderOpenPrice(), OrderStopLoss(), newTP, 0);
            }
         } else if(OrderType() == OP_SELL) {
            double newTP = BankersRound(OrderOpenPrice(), PAIR_POINTS);
            if(BankersRound(Ask - OrderOpenPrice(), PAIR_POINTS) / Point() < STOPLEVEL) newTP = BankersRound(Ask - STOPLEVEL * Point(), PAIR_POINTS);
            double oldTP = BankersRound(OrderStopLoss(), PAIR_POINTS);
            
            if(oldTP == 0) {
               int mod = OrderModify(OrderTicket(), OrderOpenPrice(), OrderStopLoss(), newTP, 0);
            }
         }
      }
   }
}

void ForceCloseOrder() {
   for(int cpt = OrdersTotal() - 1; cpt >= 0; cpt--) {
      int sel = OrderSelect(cpt, SELECT_BY_POS, MODE_TRADES);
      if(OrderSymbol() == Symbol() && OrderMagicNumber() == MAGIC) {
         if(OrderType() == OP_BUY) {
            int cls = OrderClose(OrderTicket(), OrderLots(), Bid, SLIPPAGE);
         } else if(OrderType() == OP_SELL) {
            int cls = OrderClose(OrderTicket(), OrderLots(), Ask, SLIPPAGE);
         } else if(OrderType() == OP_BUYSTOP || OrderType() == OP_SELLSTOP) {
            int del = OrderDelete(OrderTicket());
         }
      }
   }
}

bool IsBuyOrderInProgress() {
   for(int cpt = OrdersTotal() - 1; cpt >= 0; cpt--) {
      int sel = OrderSelect(cpt, SELECT_BY_POS, MODE_TRADES);
      if(OrderSymbol() == Symbol() && OrderMagicNumber() == MAGIC) {
         if(OrderType() == OP_BUY) {
            return true;
         }
      }
   }
   return false;
}

bool IsSellOrderInProgress() {
   for(int cpt = OrdersTotal() - 1; cpt >= 0; cpt--) {
      int sel = OrderSelect(cpt, SELECT_BY_POS, MODE_TRADES);
      if(OrderSymbol() == Symbol() && OrderMagicNumber() == MAGIC) {
         if(OrderType() == OP_SELL) {
            return true;
         }
      }
   }
   return false;
}

bool CanCheckForOrderAvailability() {
   if(!HasOpenOrders() && SPREAD <= 15 && CAN_TRADE) {
      return true;
   }
   return false;
}

bool HasOpenOrders() {
   for(int cpt = OrdersTotal() - 1; cpt >= 0; cpt--) {
      int sel = OrderSelect(cpt, SELECT_BY_POS, MODE_TRADES);
      if(OrderSymbol() == Symbol() && OrderMagicNumber() == MAGIC) {
         if(OrderType() == OP_BUY || OrderType() == OP_SELL) {
            return true;
         }
      }
   }
   return false;
}

double GetOpenPrice() {
   for(int cpt = OrdersTotal() - 1; cpt >= 0; cpt--) {
      int sel = OrderSelect(cpt, SELECT_BY_POS, MODE_TRADES);
      if(OrderSymbol() == Symbol() && OrderMagicNumber() == MAGIC) {
         if(OrderType() == OP_BUY || OrderType() == OP_SELL) {
            return OrderOpenPrice();
         }
      }
   }
   return 0;
}

double GetOverAllProfitLoss() {
   for(int cpt = OrdersTotal() - 1; cpt >= 0; cpt--) {
      int sel = OrderSelect(cpt, SELECT_BY_POS, MODE_TRADES);
      if(OrderSymbol() == Symbol() && OrderMagicNumber() == MAGIC) {
         if(OrderType() == OP_BUY) {
            double openPrice = OrderOpenPrice();
            double currentPrice = Bid;
            return BankersRound(currentPrice - openPrice, PAIR_POINTS) / Point();
         } else if(OrderType() == OP_SELL) {
            double openPrice = OrderOpenPrice();
            double currentPrice = Ask;
            return BankersRound(openPrice - currentPrice, PAIR_POINTS) / Point();
         }
      }
   }
   return 0;
}

double GetDayLow() {
   double DayLow = 999;
   int TotalBars = TotalBarsToday();
   for(int i = 1; i < TotalBars; i++) {
      double low = GetCandleLow(0, i);
      if(low < DayLow) {
         DayLow = low;
      }
   }
   return DayLow;
}

double GetDayHigh() {
   double DayHigh = 0;
   int TotalBars = TotalBarsToday();
   for(int i = 1; i < TotalBars; i++) {
      double high = GetCandleHigh(0, i);
      if(high > DayHigh) {
         DayHigh = high;
      }
   }
   return DayHigh;
}

int TotalBarsToday() {
   datetime TodayStart = StrToTime(StringConcatenate(Year(), ".", Month(), ".", Day()));
   return Bars(Symbol(), TIMEFRAME, TodayStart, TimeCurrent());
}

double GetLotSize() {
   double leverage = AccountEquity() - AccountCredit();
   double lot = 0.01;
   
   if(USE == RISK) {
      lot = MathFloor(leverage * 0.01 * USEVAL) / 100.0;
   } else if(USE == LOT) {
      lot = USEVAL;
   }
   
   if(lot > MAXLOT) {
      lot = MAXLOT;
   }
   
   return lot;
}

bool IsNewCandle() {
   if (NewCandleTime == iTime(Symbol(), 0, 0)) return false;
   else
   {
      NewCandleTime = iTime(Symbol(), 0, 0);
      return true;
   }
}

bool IsBullishCandle(int timeframe, int shift) {
   double openPrice = iOpen(Symbol(), timeframe, shift);
   double closePrice = iClose(Symbol(), timeframe, shift);
   if(closePrice > openPrice) return true;
   else return false;
}

bool IsBearishCandle(int timeframe, int shift) {
   double openPrice = iOpen(Symbol(), timeframe, shift);
   double closePrice = iClose(Symbol(), timeframe, shift);
   if(closePrice < openPrice) return true;
   else return false;
}

double GetCandleLow(int timeframe, int shift) {
   return iLow(Symbol(), timeframe, shift);
}

double GetCandleHigh(int timeframe, int shift) {
   return iHigh(Symbol(), timeframe, shift);
}

double GetLowerWick(int timeframe, int shift) {
   if(IsBullishCandle(timeframe, shift)) {
      return (iOpen(Symbol(), timeframe, shift) - GetCandleLow(timeframe, shift)) / Point(); 
   } else if(IsBearishCandle(timeframe, shift)) {
      return (iClose(Symbol(), timeframe, shift) - GetCandleLow(timeframe, shift)) / Point(); 
   }
   
   return 0;
}

double GetUpperWick(int timeframe, int shift) {
   if(IsBullishCandle(timeframe, shift)) {
      return (GetCandleHigh(timeframe, shift) - iClose(Symbol(), timeframe, shift)) / Point(); 
   } else if(IsBearishCandle(timeframe, shift)) {
      return (GetCandleHigh(timeframe, shift) - iOpen(Symbol(), timeframe, shift)) / Point(); 
   }
   
   return 0;
}

double GetCandleTotalPips(int timeframe, int shift) {
   double openPrice = iOpen(Symbol(), timeframe, shift);
   double closePrice = iClose(Symbol(), timeframe, shift);
   return MathAbs(openPrice / Point() - closePrice / Point());
}

double GetCandleTotalSize(int timeframe, int shift) {
   double highPrice = iHigh(Symbol(), timeframe, shift);
   double lowPrice = iLow(Symbol(), timeframe, shift);
   return MathAbs(highPrice / Point() - lowPrice / Point());
}

long GetVolume(int timeframe, int shift) {
   return iVolume(Symbol(), timeframe, shift);
}

double GetEMA(int timeframe, int shift, int period) {
   return iMA(Symbol(), timeframe, period, 0, MODE_EMA, PRICE_CLOSE, shift);
}

double GetUpperBand(int timeframe, int shift) {
   return BankersRound(iBands(Symbol(), timeframe, 20, 2, 0, PRICE_WEIGHTED, MODE_UPPER, shift), PAIR_POINTS);
}

double GetLowerBand(int timeframe, int shift) {
   return BankersRound(iBands(Symbol(), timeframe, 20, 2, 0, PRICE_WEIGHTED, MODE_LOWER, shift), PAIR_POINTS);
}

double GetMidBand(int timeframe, int shift) {
   return BankersRound(iBands(Symbol(), timeframe, 20, 2, 0, PRICE_WEIGHTED, MODE_MAIN, shift), PAIR_POINTS);
}

double BankersRound(double value, int precision) {
   value = value * MathPow(10, precision);
   if (MathCeil(value) - value == 0.5 && value - MathFloor(value) == 0.5) {
      if (MathMod(MathCeil(value), 2) == 0)
         return (MathCeil(value) / MathPow(10, precision));
      else  
         return (MathFloor(value) / MathPow(10, precision));
   }
   return (MathRound(value) / MathPow(10, precision));
}

double NormalRound(double value, int precision) {
   value = value * MathPow(10, precision);
   return (MathFloor(value) / MathPow(10, precision));
}




void ShowAccountInfo(string title) {

    double acc_balance = NormalizeDouble(AccountBalance(), 2);
    double acc_profit_loss = NormalizeDouble(CheckProfits(), 2);
    double acc_equity = NormalizeDouble(AccountEquity(), 2);
    double acc_draw_down_percent = 0;
    if(acc_equity < acc_balance) {
      acc_draw_down_percent = NormalizeDouble(100 * (acc_balance - acc_equity) / acc_balance, 2);
    }
    
    dashboard_text_title.Create(0, "dashboard_text_title", 0, 30, 40, 3000, 4000);
    dashboard_text_title.Text(title);
    dashboard_text_title.Color(clrWhite);
    dashboard_text_title.Font("Arial Bold");
    dashboard_text_title.FontSize(12);
    
    dashboard_text_balance.Create(0, "dashboard_text_balance", 0, 30, 70, 3000, 4000);
    dashboard_text_balance.Text("Account Balance: $" + acc_balance);
    dashboard_text_balance.Color(clrWhite);
    dashboard_text_balance.Font("Arial Bold");
    dashboard_text_balance.FontSize(10);
    
    dashboard_text_equity.Create(0, "dashboard_text_equity", 0, 30, 90, 3000, 4000);
    dashboard_text_equity.Text("Account Equity: $" + acc_equity);
    dashboard_text_equity.Color(clrWhite);
    dashboard_text_equity.Font("Arial Bold");
    dashboard_text_equity.FontSize(10);
    
    dashboard_text_profit_loss.Create(0, "dashboard_text_profit_loss", 0, 30, 110, 3000, 4000);
    dashboard_text_profit_loss.Text("Floating Profit/Loss: $" + acc_profit_loss);
    dashboard_text_profit_loss.Color(clrWhite);
    dashboard_text_profit_loss.Font("Arial Bold");
    dashboard_text_profit_loss.FontSize(10);
    
    dashboard_text_draw_down.Create(0, "dashboard_text_draw_down", 0, 30, 130, 3000, 4000);
    dashboard_text_draw_down.Text("Draw Down Percentage: %" + acc_draw_down_percent);
    dashboard_text_draw_down.Color(clrWhite);
    dashboard_text_draw_down.Font("Arial Bold");
    dashboard_text_draw_down.FontSize(10);
    
    dashboard_text_pip_spread.Create(0, "dashboard_text_pip_spread", 0, 30, 150, 3000, 4000);
    dashboard_text_pip_spread.Text("Pip Spread: "+ MarketInfo(Symbol(),MODE_SPREAD));
    dashboard_text_pip_spread.Color(clrWhite);
    dashboard_text_pip_spread.Font("Arial Bold");
    dashboard_text_pip_spread.FontSize(10);
    
    dashboard_text_symbol.Create(0, "dashboard_text_symbol", 0, 30, 170, 3000, 4000);
    dashboard_text_symbol.Text("Symbol: " + Symbol());
    dashboard_text_symbol.Color(clrWhite);
    dashboard_text_symbol.Font("Arial Bold");
    dashboard_text_symbol.FontSize(10);
    
    dashboard_text_server.Create(0, "dashboard_text_server", 0, 30, 190, 3000, 4000);
    dashboard_text_server.Text(AccountServer());
    dashboard_text_server.Color(clrWhite);
    dashboard_text_server.Font("Arial Bold");
    dashboard_text_server.FontSize(10);
    
    dashboard_text_date.Create(0, "dashboard_text_date", 0, 30, 210, 3000, 4000);
    dashboard_text_date.Text(Month() + "-" + Day() + "-" + Year() + " " + Hour() + ":" + Minute() + ":" + Seconds());
    dashboard_text_date.Color(clrWhite);
    dashboard_text_date.Font("Arial Bold");
    dashboard_text_date.FontSize(10);
    
}

double CheckProfits()
{
   double profit = 0;
   for(int cpt = 0; cpt < OrdersTotal(); cpt++)
   {
      OrderSelect(cpt, SELECT_BY_POS, MODE_TRADES);
      if(OrderType() == OP_BUY) profit += (Bid - OrderOpenPrice()) / Point * OrderLots();
      if(OrderType() == OP_SELL) profit += (OrderOpenPrice()-Ask) / Point * OrderLots();
   }
   return profit;
}
