// Import of functions from User32. If their purpose isn't pretty much immediately

// clear, then documenting it here frankly isn't going to help much. Requires 

// "Allow DLL imports" to be turned on.

#import "user32.dll"

   int RegisterWindowMessageW(string MessageName);
   
   int PostMessageW(int hwnd,int msg,int wparam,uchar &Name[]);

   void keybd_event(int VirtualKey, int ScanCode, int Flags, int ExtraInfo);

#import

#include <Controls\Panel.mqh>

#include <Controls\Label.mqh>


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

void InitPanelDashboard() {
   
   dashboard_panel.Create(0, "dashboard_panel", 0, 10, 20, 240, 325);
   
   dashboard_panel.ColorBackground(clrBlack);
   
   dashboard_panel.ColorBorder(clrWhiteSmoke);

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
    
    dashboard_text_symbol.Create(0, "dashboard_text_symbol", 0, 30, 250, 3000, 4000);
    dashboard_text_symbol.Text("Symbol: " + Symbol());
    dashboard_text_symbol.Color(clrWhite);
    dashboard_text_symbol.Font("Arial Bold");
    dashboard_text_symbol.FontSize(10);
    
    dashboard_text_server.Create(0, "dashboard_text_server", 0, 30, 270, 3000, 4000);
    dashboard_text_server.Text(AccountServer());
    dashboard_text_server.Color(clrWhite);
    dashboard_text_server.Font("Arial Bold");
    dashboard_text_server.FontSize(10);
    
    dashboard_text_date.Create(0, "dashboard_text_date", 0, 30, 290, 3000, 4000);
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


void StartStandardIndicator(string IndicatorName, bool AutomaticallyAcceptDefaults = true)

{

   int hWnd = WindowHandle(Symbol(),0);
   
   uchar name[];
   
   StringToCharArray(IndicatorName, name, 0, StringLen(IndicatorName));
   
   int MessageNumber = RegisterWindowMessageW("MetaTrader4_Internal_Message");
   
   PostMessageW(hWnd, MessageNumber, 13, name);

   if (AutomaticallyAcceptDefaults) ClearConfigDialog();

}



void StartCustomIndicator(string IndicatorName, bool AutomaticallyAcceptDefaults = true)

{

   int hWnd = WindowHandle(Symbol(),0);
   
   uchar name[];
   
   StringToCharArray(IndicatorName, name, 0, StringLen(IndicatorName));
   
   int MessageNumber = RegisterWindowMessageW("MetaTrader4_Internal_Message");
   
   PostMessageW(hWnd, MessageNumber, 15, name);

   if (AutomaticallyAcceptDefaults) ClearConfigDialog();

}



void StartEA(string EAName, bool AutomaticallyAcceptDefaults = true)

{

   int hWnd = WindowHandle(Symbol(),0);
   
   uchar name[];
   
   StringToCharArray(EAName, name, 0, StringLen(EAName));
   
   int MessageNumber = RegisterWindowMessageW("MetaTrader4_Internal_Message");
   
   PostMessageW(hWnd, MessageNumber, 14, name);

   if (AutomaticallyAcceptDefaults) ClearConfigDialog();

}



void StartScript(string ScriptName, bool AutomaticallyAcceptDefaults = true)

{

   int hWnd = WindowHandle(Symbol(),0);
   
   uchar name[];
   
   StringToCharArray(ScriptName, name, 0, StringLen(ScriptName));
   
   int MessageNumber = RegisterWindowMessageW("MetaTrader4_Internal_Message");
   
   PostMessageW(hWnd, MessageNumber, 16, name);

   if (AutomaticallyAcceptDefaults) ClearConfigDialog();

}



void ClearConfigDialog()

{

   Sleep(100);

   keybd_event(13, 0, 0, 0);
}