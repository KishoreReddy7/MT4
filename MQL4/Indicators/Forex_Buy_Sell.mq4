#property copyright "Copyright © 2022, SanjuReddy."
#property link      "http://www.sanjureddy.in"

#property indicator_chart_window
#property indicator_levelcolor DimGray
#property indicator_buffers 7
#property indicator_color1 Silver
#property indicator_color2 RoyalBlue
#property indicator_color3 Tomato
#property indicator_color4 RoyalBlue
#property indicator_color5 Tomato
#property indicator_color6 Gray
#property indicator_color7 Gray
#property indicator_width1 2

extern int TimeFrame = 0;
extern bool AlertOn = FALSE;
extern bool EmailOn = FALSE;
extern bool SignalOnClosedCandle = TRUE;
extern int MathMode = 0;
extern int Price = 0;
extern int Length = 27;
extern int PreSmooth = 1;
extern int Smooth = 5;
extern int MA_Method = 5;
extern int RangeAvgLength = 27;
extern double Multiplier = 4.236;
extern int SignalMode = 1;
extern int LevelsMode = 2;
extern bool ShowArrows = TRUE;
extern color ArrowsUpColor = Green;
extern color ArrowsDnColor = Red;
extern int ArrowWidth = 1;
extern double OverboughtLevel = 90.0;
extern double OversoldLevel = 10.0;
extern int LookBackPeriod = 25;
extern double UpperMultiplier = 1.0;
extern double LowerMultiplier = 1.0;
extern string MAMode = "";
extern string __0 = "SMA";
extern string __1 = "EMA";
extern string __2 = "Wilder";
extern string __3 = "LWMA";
extern string __4 = "SineWMA";
extern string __5 = "TriMA";
extern string __6 = "LSMA";
extern string __7 = "SMMA";
extern string __8 = "HMA";
extern string __9 = "ZeroLagEMA";
extern string __10 = "DEMA";
extern string __11 = "T3_basic";
extern string __12 = "ITrend";
extern string __13 = "Median";
extern string __14 = "GeoMean";
extern string __15 = "REMA";
extern string __16 = "ILRS";
extern string __17 = "IE/2";
extern string __18 = "TriMAgen";
extern string __19 = "VWMA";
extern string __20 = "JSmooth";
extern string __21 = "SMA_eq ";
extern string __22 = "ALMA";
extern string __23 = "TEMA";
extern string __24 = "T3";
extern string __25 = "Laguerre";
extern string Prices = "";
extern string _0 = "Close";
extern string _1 = "Open";
extern string _2 = "High";
extern string _3 = "Low";
extern string _4 = "Median Price";
extern string _5 = "Typical Price";
extern string _6 = "Weighted";
extern string KEY = "FBS";
double G_ibuf_468[];
double G_ibuf_472[];
double G_ibuf_476[];
double G_ibuf_480[];
double G_ibuf_484[];
double G_ibuf_488[];
double G_ibuf_492[];
double Gda_496[][7][2];
double Gda_500[7][3];
double Gda_504[];
double Gda_508[];
double Gda_512[];
double Gda_516[];
double Gda_520[2];
double Gda_524[2];
double Gda_528[2];
double Gda_unused_532[2];
double Gda_unused_536[2];
double Gda_540[];
double Gda_544[];
int Gi_552;
int Gi_556;
int Gi_560 = 0;
int Gi_564 = 0;
string Gs_568;
string Gs_576;
string Gs_584;
string Gs_592;
string Gs_600;
string Gs_608;
string Gs_dummy_616;
double Gd_624;
double Gd_632;
double Gd_640;
double Gda_648[2];
double Gda_652[2];
double Gda_656[2];
double Gda_660[2];
double Gd_664;
int Gia_672[7];
datetime G_time_676;

string f0_16() {
   string timeframe_4;
   switch (Period()) {
   case PERIOD_M1:
      timeframe_4 = "M1";
      break;
   case PERIOD_M5:
      timeframe_4 = "M5";
      break;
   case PERIOD_M15:
      timeframe_4 = "M15";
      break;
   case PERIOD_M30:
      timeframe_4 = "M30";
      break;
   case PERIOD_H1:
      timeframe_4 = "H1";
      break;
   case PERIOD_H4:
      timeframe_4 = "H4";
      break;
   case PERIOD_D1:
      timeframe_4 = "D1";
      break;
   case PERIOD_W1:
      timeframe_4 = "W1";
      break;
   case PERIOD_MN1:
      timeframe_4 = "MN1";
      break;
   default:
      timeframe_4 = Period();
   }
   return (timeframe_4);
}

int init() {
   if (TimeFrame <= Period()) TimeFrame = Period();
   IndicatorDigits(MarketInfo(Symbol(), MODE_DIGITS));
   IndicatorBuffers(7);
   SetIndexBuffer(0, G_ibuf_468);
   SetIndexStyle(0, DRAW_NONE);
   SetIndexLabel(0, NULL); 
   SetIndexBuffer(1, G_ibuf_472);
   SetIndexStyle(1, DRAW_NONE);
   SetIndexLabel(1, NULL); 
   SetIndexBuffer(2, G_ibuf_476);
   SetIndexStyle(2, DRAW_NONE);
   SetIndexLabel(2, NULL); 
   SetIndexBuffer(3, G_ibuf_480);
   SetIndexStyle(3, DRAW_ARROW);
   SetIndexArrow(3, 159);
   SetIndexBuffer(4, G_ibuf_484);
   SetIndexStyle(4, DRAW_ARROW);
   SetIndexArrow(4, 159);
   SetIndexBuffer(5, G_ibuf_488);
   SetIndexStyle(5, DRAW_NONE);
   SetIndexLabel(5, NULL); 
   SetIndexBuffer(6, G_ibuf_492);
   SetIndexStyle(6, DRAW_NONE);
   SetIndexLabel(6, NULL); 
   switch (TimeFrame) {
   case 1:
      Gs_568 = "M1";
      break;
   case 5:
      Gs_568 = "M5";
      break;
   case 15:
      Gs_568 = "M15";
      break;
   case 30:
      Gs_568 = "M30";
      break;
   case 60:
      Gs_568 = "H1";
      break;
   case 240:
      Gs_568 = "H4";
      break;
   case 1440:
      Gs_568 = "D1";
      break;
   case 10080:
      Gs_568 = "W1";
      break;
   case 43200:
      Gs_568 = "MN1";
   }
   switch (Price) {
   case 0:
      Gs_600 = "Close";
      break;
   case 1:
      Gs_600 = "Open";
      break;
   case 2:
      Gs_600 = "High";
      break;
   case 3:
      Gs_600 = "Low";
      break;
   case 4:
      Gs_600 = "Median";
      break;
   case 5:
      Gs_600 = "Typical";
      break;
   case 6:
      Gs_600 = "Weighted Close";
   }
   switch (MathMode) {
   case 0:
      Gs_592 = "RSI";
      break;
   case 1:
      Gs_592 = "Stoch";
      break;
   case 2:
      Gs_592 = "DMI";
   }
   Gs_608 = f0_46(MA_Method, Gi_552);
   Gs_576 = WindowExpertName();
   Gs_584 = "[" + Gs_568 + "](" + Gs_592 + "," + Gs_600 + "," + Length + "," + PreSmooth + "," + Smooth + "," + SignalMode + "," + Gs_608 + "," + LevelsMode + ")";
   IndicatorShortName(Gs_576 + Gs_584);
   int Li_12 = Bars - iBars(NULL, TimeFrame) * TimeFrame / Period() + Length + PreSmooth + Smooth + RangeAvgLength + LookBackPeriod;
   SetIndexDrawBegin(0, Li_12);
   SetIndexDrawBegin(1, Li_12);
   SetIndexDrawBegin(2, Li_12);
   SetIndexDrawBegin(3, Li_12);
   SetIndexDrawBegin(4, Li_12);
   SetIndexDrawBegin(5, Li_12);
   SetIndexDrawBegin(6, Li_12);
   SetIndexLabel(0, "AbsoluteDifference");
   SetIndexLabel(1, "UpTrend");
   SetIndexLabel(2, "DnTrend");
   SetIndexLabel(3, "UpTrend Signal");
   SetIndexLabel(4, "DnTrend Signal");
   SetIndexLabel(5, "Overbought");
   SetIndexLabel(6, "Oversold");
   Gi_556 = LookBackPeriod;
   ArrayResize(Gda_496, Gi_552);
   ArrayResize(Gda_540, Gi_556);
   ArrayResize(Gda_544, Gi_556);
   Gd_640 = 2.0 / (RangeAvgLength + 1);
   Gd_664 = MarketInfo(Symbol(), MODE_POINT) * MathPow(10, Digits % 2);
   if (SignalOnClosedCandle) Gi_560 = 1;
   return (0);
}

void f0_48() {
   for (int Li_0 = ObjectsTotal() - 1; Li_0 >= 0; Li_0--)
      if (StringFind(ObjectName(Li_0), KEY) > -1) ObjectDelete(ObjectName(Li_0));
}

void deinit() {
   Comment("");
   f0_48();
}

int start() {
   int Li_0;
   int shift_16;
   int ind_counted_12 = IndicatorCounted();
   if (ind_counted_12 > 0) Li_0 = Bars - ind_counted_12 - 1;
   if (ind_counted_12 < 0) return (0);
   if (ind_counted_12 < 1) {
      Li_0 = Bars - 1;
      for (int Li_4 = Li_0; Li_4 >= 0; Li_4--) {
         G_ibuf_468[Li_4] = 0;
         G_ibuf_472[Li_4] = EMPTY_VALUE;
         G_ibuf_476[Li_4] = EMPTY_VALUE;
         G_ibuf_480[Li_4] = EMPTY_VALUE;
         G_ibuf_484[Li_4] = EMPTY_VALUE;
         G_ibuf_488[Li_4] = EMPTY_VALUE;
         G_ibuf_492[Li_4] = EMPTY_VALUE;
      }
   }
   if (TimeFrame != Period()) {
      Li_0 = MathMax(Li_0, TimeFrame / Period());
      for (int index_8 = 0; index_8 < Li_0; index_8++) {
         shift_16 = iBarShift(NULL, TimeFrame, Time[index_8]);
         G_ibuf_468[index_8] = iCustom(NULL, TimeFrame, Gs_576, 0, 0, 0, 0, MathMode, Price, Length, PreSmooth, Smooth, MA_Method, RangeAvgLength, Multiplier, SignalMode,
            LevelsMode, 0, 32768, 255, 2, OverboughtLevel, OversoldLevel, LookBackPeriod, UpperMultiplier, LowerMultiplier, 0, shift_16);
         G_ibuf_472[index_8] = iCustom(NULL, TimeFrame, Gs_576, 0, 0, 0, 0, MathMode, Price, Length, PreSmooth, Smooth, MA_Method, RangeAvgLength, Multiplier, SignalMode,
            LevelsMode, 0, 32768, 255, 2, OverboughtLevel, OversoldLevel, LookBackPeriod, UpperMultiplier, LowerMultiplier, 1, shift_16);
         G_ibuf_476[index_8] = iCustom(NULL, TimeFrame, Gs_576, 0, 0, 0, 0, MathMode, Price, Length, PreSmooth, Smooth, MA_Method, RangeAvgLength, Multiplier, SignalMode,
            LevelsMode, 0, 32768, 255, 2, OverboughtLevel, OversoldLevel, LookBackPeriod, UpperMultiplier, LowerMultiplier, 2, shift_16);
         G_ibuf_480[index_8] = iCustom(NULL, TimeFrame, Gs_576, 0, 0, 0, 0, MathMode, Price, Length, PreSmooth, Smooth, MA_Method, RangeAvgLength, Multiplier, SignalMode,
            LevelsMode, 0, 32768, 255, 2, OverboughtLevel, OversoldLevel, LookBackPeriod, UpperMultiplier, LowerMultiplier, 3, shift_16);
         if (ShowArrows) {
            if (G_ibuf_480[index_8] != EMPTY_VALUE) f0_27(index_8, Low[index_8], ArrowsUpColor, 233, 1);
            else f0_26(index_8, 1);
         }
         G_ibuf_484[index_8] = iCustom(NULL, TimeFrame, Gs_576, 0, 0, 0, 0, MathMode, Price, Length, PreSmooth, Smooth, MA_Method, RangeAvgLength, Multiplier, SignalMode,
            LevelsMode, 0, 32768, 255, 2, OverboughtLevel, OversoldLevel, LookBackPeriod, UpperMultiplier, LowerMultiplier, 4, shift_16);
         if (ShowArrows) {
            if (G_ibuf_484[index_8] != EMPTY_VALUE) f0_27(index_8, High[index_8], ArrowsDnColor, 234, 0);
            else f0_26(index_8, 0);
         }
         if (OverboughtLevel > 0.0 || OversoldLevel > 0.0) {
            G_ibuf_488[index_8] = iCustom(NULL, TimeFrame, Gs_576, 0, 0, 0, 0, MathMode, Price, Length, PreSmooth, Smooth, MA_Method, RangeAvgLength, Multiplier, SignalMode,
               LevelsMode, 0, 32768, 255, 2, OverboughtLevel, OversoldLevel, LookBackPeriod, UpperMultiplier, LowerMultiplier, 5, shift_16);
            G_ibuf_492[index_8] = iCustom(NULL, TimeFrame, Gs_576, 0, 0, 0, 0, MathMode, Price, Length, PreSmooth, Smooth, MA_Method, RangeAvgLength, Multiplier, SignalMode,
               LevelsMode, 0, 32768, 255, 2, OverboughtLevel, OversoldLevel, LookBackPeriod, UpperMultiplier, LowerMultiplier, 6, shift_16);
         }
      }
      return (0);
   }
   f0_19(Li_0);
   if (G_ibuf_472[Gi_560] != EMPTY_VALUE && Gi_564 < 1) {
      if (AlertOn) Alert("ForexBuySell Uptrend Alert on " + Symbol() + "[" + f0_16() + "]");
      if (EmailOn) SendMail("ForexBuySell Uptrend Alert!", "Buy alert on " + Symbol() + "[" + f0_16() + "]");
      Gi_564 = 1;
   } else {
      if (G_ibuf_476[Gi_560] != EMPTY_VALUE && Gi_564 > -1) {
         if (AlertOn) Alert("ForexBuySell Downtrend Alert on " + Symbol() + "[" + f0_16() + "]");
         if (EmailOn) SendMail("ForexBuySell Downtrend Alert!", "Sell alert on " + Symbol() + "[" + f0_16() + "]");
         Gi_564 = -1;
      }
   }
   return (0);
}

void f0_19(int Ai_0) {
   double Ld_4;
   double Ld_12;
   int Li_24;
   double Ld_28;
   double Ld_36;
   bool Li_48;
   double Ld_52;
   double Ld_60;
   double Ld_68;
   if (ArraySize(Gda_504) != Bars) {
      ArraySetAsSeries(Gda_504, FALSE);
      ArraySetAsSeries(Gda_512, FALSE);
      ArraySetAsSeries(Gda_508, FALSE);
      ArraySetAsSeries(Gda_516, FALSE);
      ArrayResize(Gda_504, Bars);
      ArrayResize(Gda_512, Bars);
      ArrayResize(Gda_508, Bars);
      ArrayResize(Gda_516, Bars);
      ArraySetAsSeries(Gda_504, TRUE);
      ArraySetAsSeries(Gda_512, TRUE);
      ArraySetAsSeries(Gda_508, TRUE);
      ArraySetAsSeries(Gda_516, TRUE);
   }
   for (int Li_20 = Ai_0; Li_20 >= 0; Li_20--) {
      if (G_time_676 != Time[Li_20]) {
         Gda_524[1] = Gda_524[0];
         Gda_528[1] = Gda_528[0];
         Gda_520[1] = Gda_520[0];
         Gda_656[1] = Gda_656[0];
         Gda_660[1] = Gda_660[0];
         Gda_648[1] = Gda_648[0];
         Gda_652[1] = Gda_652[0];
         G_time_676 = Time[Li_20];
      }
      if (MathMode < 2) Li_24 = Price;
      else Li_24 = 2;
      Gda_524[0] = f0_31(0, Li_24, PreSmooth, MA_Method, Gi_552, Li_20);
      if (Li_20 < Bars - 2) {
         if (MathMode == 0) {
            Gda_504[Li_20] = (MathAbs(Gda_524[0] - Gda_524[1]) + (Gda_524[0] - Gda_524[1])) / 2.0;
            Gda_508[Li_20] = (MathAbs(Gda_524[0] - Gda_524[1]) - (Gda_524[0] - Gda_524[1])) / 2.0;
         } else {
            if (MathMode == 1) {
               Ld_28 = 0;
               Ld_36 = EMPTY_VALUE;
               for (int count_44 = 0; count_44 < Length; count_44++) {
                  Ld_28 = MathMax(Ld_28, High[Li_20 + count_44]);
                  Ld_36 = MathMin(Ld_36, Low[Li_20 + count_44]);
               }
               Gda_504[Li_20] = Gda_524[0] - Ld_36;
               Gda_508[Li_20] = Ld_28 - Gda_524[0];
            } else {
               if (MathMode == 2) {
                  Gda_528[0] = f0_31(1, 3, PreSmooth, MA_Method, Gi_552, Li_20);
                  Gda_504[Li_20] = MathMax(0, (MathAbs(Gda_524[0] - Gda_524[1]) + (Gda_524[0] - Gda_524[1])) / 2.0);
                  Gda_508[Li_20] = MathMax(0, (MathAbs(Gda_528[1] - Gda_528[0]) + (Gda_528[1] - Gda_528[0])) / 2.0);
                  if (Gda_504[Li_20] > Gda_508[Li_20]) Gda_508[Li_20] = 0;
                  else {
                     if (Gda_504[Li_20] < Gda_508[Li_20]) Gda_504[Li_20] = 0;
                     else {
                        if (Gda_504[Li_20] == Gda_508[Li_20]) {
                           Gda_504[Li_20] = 0;
                           Gda_508[Li_20] = 0;
                        }
                     }
                  }
               }
            }
         }
         if (MathMode == 1) Li_48 = TRUE;
         else Li_48 = Length;
         Gda_512[Li_20] = f0_8(2, Gda_504, Li_48, MA_Method, Gi_552, Li_20);
         Gda_516[Li_20] = f0_8(3, Gda_508, Li_48, MA_Method, Gi_552, Li_20);
         Ld_52 = f0_8(4, Gda_512, Smooth, MA_Method, Gi_552, Li_20) / Gd_664;
         Ld_60 = f0_8(5, Gda_516, Smooth, MA_Method, Gi_552, Li_20) / Gd_664;
         G_ibuf_468[Li_20] = Ld_52 - Ld_60;
         if (G_ibuf_468[Li_20] > G_ibuf_468[Li_20 + 1]) {
            Gd_624 = G_ibuf_468[Li_20];
            Gd_632 = G_ibuf_468[Li_20 + 1];
         } else {
            if (G_ibuf_468[Li_20] < G_ibuf_468[Li_20 + 1]) {
               Gd_624 = G_ibuf_468[Li_20 + 1];
               Gd_632 = G_ibuf_468[Li_20];
            } else {
               Gd_624 = G_ibuf_468[Li_20];
               Gd_632 = G_ibuf_468[Li_20];
            }
         }
         Ld_68 = Gd_624 - Gd_632;
         Gda_648[0] = Gda_648[1] + Gd_640 * (Ld_68 - Gda_648[1]);
         Gda_652[0] = Gda_652[1] + Gd_640 * (Gda_648[0] - Gda_652[1]);
         Gda_656[0] = G_ibuf_468[Li_20] + Multiplier * Gda_652[0];
         Gda_660[0] = G_ibuf_468[Li_20] - Multiplier * Gda_652[0];
         Gda_520[0] = Gda_520[1];
         if (G_ibuf_468[Li_20] > Gda_656[1]) Gda_520[0] = 1;
         if (G_ibuf_468[Li_20] < Gda_660[1]) Gda_520[0] = -1;
         G_ibuf_472[Li_20] = EMPTY_VALUE;
         G_ibuf_476[Li_20] = EMPTY_VALUE;
         G_ibuf_480[Li_20] = EMPTY_VALUE;
         G_ibuf_484[Li_20] = EMPTY_VALUE;
         if (Gda_520[0] > 0.0) {
            if (Gda_660[0] < Gda_660[1]) Gda_660[0] = Gda_660[1];
            G_ibuf_472[Li_20] = Gda_660[0];
            if (SignalMode > 0 && Gda_520[1] < 0.0) G_ibuf_480[Li_20] = Gda_660[0];
         } else {
            if (Gda_520[0] < 0.0) {
               if (Gda_656[0] > Gda_656[1]) Gda_656[0] = Gda_656[1];
               G_ibuf_476[Li_20] = Gda_656[0];
               if (SignalMode > 0 && Gda_520[1] > 0.0) G_ibuf_484[Li_20] = Gda_656[0];
            }
         }
         if (ShowArrows) {
            if (G_ibuf_480[Li_20] != EMPTY_VALUE) f0_27(Li_20, Low[Li_20], ArrowsUpColor, 233, 1);
            else f0_26(Li_20, 1);
         }
         if (ShowArrows) {
            if (G_ibuf_484[Li_20] != EMPTY_VALUE) f0_27(Li_20, High[Li_20], ArrowsDnColor, 234, 0);
            else f0_26(Li_20, 0);
         }
         if (LevelsMode == 0) {
            if (OverboughtLevel > 0.0) G_ibuf_488[Li_20] = (OverboughtLevel / 50.0 - 1.0) * (Ld_52 + Ld_60);
            if (OversoldLevel <= 0.0) continue;
            G_ibuf_492[Li_20] = (OversoldLevel / 50.0 - 1.0) * (Ld_52 + Ld_60);
            continue;
         }
         if (LevelsMode == 1 && Li_20 < Bars - (LookBackPeriod + Length)) {
            for (int index_76 = 0; index_76 < LookBackPeriod; index_76++) {
               Gda_540[index_76] = G_ibuf_468[Li_20 + index_76];
               Gda_544[index_76] = G_ibuf_468[Li_20 + index_76];
            }
            if (UpperMultiplier > 0.0) G_ibuf_488[Li_20] = f0_0(Gda_540, LookBackPeriod, 0) + UpperMultiplier * f0_43(Gda_540, LookBackPeriod);
            if (LowerMultiplier <= 0.0) continue;
            G_ibuf_492[Li_20] = f0_0(Gda_544, LookBackPeriod, 0) - LowerMultiplier * f0_43(Gda_544, LookBackPeriod);
            continue;
         }
         if (LevelsMode == 2 && Li_20 < Bars - (LookBackPeriod + Length)) {
            for (index_76 = 0; index_76 < LookBackPeriod; index_76++) {
               Gda_540[index_76] = G_ibuf_468[Li_20 + index_76];
               Gda_544[index_76] = G_ibuf_468[Li_20 + index_76];
            }
            Ld_4 = f0_2(2, Gda_540, LookBackPeriod, 0);
            Ld_12 = f0_2(3, Gda_544, LookBackPeriod, 0);
            G_ibuf_488[Li_20] = Ld_4 - (Ld_4 - Ld_12) * (1 - OverboughtLevel / 100.0);
            G_ibuf_492[Li_20] = Ld_12 + (Ld_4 - Ld_12) * OversoldLevel / 100.0;
         }
      }
   }
}

string f0_46(int Ai_0, int &Ai_4) {
   string Ls_ret_8 = "";
   switch (Ai_0) {
   case 1:
      Ls_ret_8 = "EMA";
      break;
   case 2:
      Ls_ret_8 = "Wilder";
      break;
   case 3:
      Ls_ret_8 = "LWMA";
      break;
   case 4:
      Ls_ret_8 = "SineWMA";
      break;
   case 5:
      Ls_ret_8 = "TriMA";
      break;
   case 6:
      Ls_ret_8 = "LSMA";
      break;
   case 7:
      Ls_ret_8 = "SMMA";
      break;
   case 8:
      Ls_ret_8 = "HMA";
      break;
   case 9:
      Ls_ret_8 = "ZeroLagEMA";
      break;
   case 10:
      Ls_ret_8 = "DEMA";
      Ai_4 = 2;
      break;
   case 11:
      Ls_ret_8 = "T3 basic";
      Ai_4 = 6;
      break;
   case 12:
      Ls_ret_8 = "InstTrend";
      break;
   case 13:
      Ls_ret_8 = "Median";
      break;
   case 14:
      Ls_ret_8 = "GeoMean";
      break;
   case 15:
      Ls_ret_8 = "REMA";
      break;
   case 16:
      Ls_ret_8 = "ILRS";
      break;
   case 17:
      Ls_ret_8 = "IE/2";
      break;
   case 18:
      Ls_ret_8 = "TriMA_gen";
      break;
   case 19:
      Ls_ret_8 = "VWMA";
      break;
   case 20:
      Ls_ret_8 = "JSmooth";
      Ai_4 = 5;
      break;
   case 21:
      Ls_ret_8 = "SMA_eq";
      break;
   case 22:
      Ls_ret_8 = "ALMA";
      break;
   case 23:
      Ls_ret_8 = "TEMA";
      Ai_4 = 4;
      break;
   case 24:
      Ls_ret_8 = "T3";
      Ai_4 = 6;
      break;
   case 25:
      Ls_ret_8 = "Laguerre";
      Ai_4 = 4;
      break;
   default:
      Ls_ret_8 = "SMA";
   }
   return (Ls_ret_8);
}

double f0_31(int Ai_0, int Ai_4, int Ai_8, int Ai_12, int Ai_16, int Ai_20) {
   double Lda_24[3];
   if (Gia_672[Ai_0] != Time[Ai_20]) {
      Gda_500[Ai_0][2] = Gda_500[Ai_0][1];
      Gda_500[Ai_0][1] = Gda_500[Ai_0][0];
      for (int index_28 = 0; index_28 < Ai_16; index_28++) Gda_496[index_28][Ai_0][1] = Gda_496[index_28][Ai_0][0];
      Gia_672[Ai_0] = Time[Ai_20];
   }
   for (index_28 = 0; index_28 < 3; index_28++) Lda_24[index_28] = Gda_500[Ai_0][index_28];
   switch (Ai_12) {
   case 1:
      Gda_500[Ai_0][0] = f0_28(Ai_4, Gda_500[Ai_0][1], Ai_8, Ai_20);
      break;
   case 2:
      Gda_500[Ai_0][0] = f0_4(Ai_4, Gda_500[Ai_0][1], Ai_8, Ai_20);
      break;
   case 3:
      Gda_500[Ai_0][0] = f0_42(Ai_4, Ai_8, Ai_20);
      break;
   case 4:
      Gda_500[Ai_0][0] = f0_44(Ai_4, Ai_8, Ai_20);
      break;
   case 5:
      Gda_500[Ai_0][0] = f0_22(Ai_4, Ai_8, Ai_20);
      break;
   case 6:
      Gda_500[Ai_0][0] = f0_17(Ai_4, Ai_8, Ai_20);
      break;
   case 7:
      Gda_500[Ai_0][0] = f0_55(Ai_4, Gda_500[Ai_0][1], Ai_8, Ai_20);
      break;
   case 8:
      Gda_500[Ai_0][0] = f0_49(Ai_4, Ai_8, Ai_20);
      break;
   case 9:
      Gda_500[Ai_0][0] = f0_29(Ai_4, Gda_500[Ai_0][1], Ai_8, Ai_20);
      break;
   case 10:
      Gda_500[Ai_0][0] = f0_9(Ai_0, 0, Ai_4, Ai_8, 1, Ai_20);
      break;
   case 11:
      Gda_500[Ai_0][0] = f0_25(Ai_0, 0, Ai_4, Ai_8, 0.7, Ai_20);
      break;
   case 12:
      Gda_500[Ai_0][0] = f0_7(Ai_4, Lda_24, Ai_8, Ai_20);
      break;
   case 13:
      Gda_500[Ai_0][0] = f0_24(Ai_4, Ai_8, Ai_20);
      break;
   case 14:
      Gda_500[Ai_0][0] = f0_6(Ai_4, Ai_8, Ai_20);
      break;
   case 15:
      Gda_500[Ai_0][0] = f0_14(Ai_4, Lda_24, Ai_8, 0.5, Ai_20);
      break;
   case 16:
      Gda_500[Ai_0][0] = f0_59(Ai_4, Ai_8, Ai_20);
      break;
   case 17:
      Gda_500[Ai_0][0] = f0_5(Ai_4, Ai_8, Ai_20);
      break;
   case 18:
      Gda_500[Ai_0][0] = f0_1(Ai_4, Ai_8, Ai_20);
      break;
   case 19:
      Gda_500[Ai_0][0] = f0_47(Ai_4, Ai_8, Ai_20);
      break;
   case 20:
      Gda_500[Ai_0][0] = f0_38(Ai_0, 0, Ai_4, Ai_8, 1, Ai_20);
      break;
   case 21:
      Gda_500[Ai_0][0] = f0_53(Ai_4, Lda_24, Ai_8, Ai_20);
      break;
   case 22:
      Gda_500[Ai_0][0] = f0_12(Ai_4, Ai_8, 0.85, 8, Ai_20);
      break;
   case 23:
      Gda_500[Ai_0][0] = f0_56(Ai_0, Ai_4, Ai_8, 1, Ai_20);
      break;
   case 24:
      Gda_500[Ai_0][0] = f0_20(Ai_0, 0, Ai_4, Ai_8, 0.7, Ai_20);
      break;
   case 25:
      Gda_500[Ai_0][0] = f0_30(Ai_0, Ai_4, Ai_8, 4, Ai_20);
      break;
   default:
      Gda_500[Ai_0][0] = f0_10(Ai_4, Ai_8, Ai_20);
   }
   return (Gda_500[Ai_0][0]);
}

double f0_8(int Ai_0, double Ada_4[], int Ai_8, int Ai_12, int Ai_16, int Ai_20) {
   double Lda_24[3];
   if (Gia_672[Ai_0] != Time[Ai_20]) {
      Gda_500[Ai_0][2] = Gda_500[Ai_0][1];
      Gda_500[Ai_0][1] = Gda_500[Ai_0][0];
      for (int index_28 = 0; index_28 < Ai_16; index_28++) Gda_496[index_28][Ai_0][1] = Gda_496[index_28][Ai_0][0];
      Gia_672[Ai_0] = Time[Ai_20];
   }
   for (index_28 = 0; index_28 < 3; index_28++) Lda_24[index_28] = Gda_500[Ai_0][index_28];
   switch (Ai_12) {
   case 1:
      Gda_500[Ai_0][0] = f0_40(Ada_4[Ai_20], Gda_500[Ai_0][1], Ai_8, Ai_20);
      break;
   case 2:
      Gda_500[Ai_0][0] = f0_36(Ada_4[Ai_20], Gda_500[Ai_0][1], Ai_8, Ai_20);
      break;
   case 3:
      Gda_500[Ai_0][0] = f0_18(Ada_4, Ai_8, Ai_20);
      break;
   case 4:
      Gda_500[Ai_0][0] = f0_39(Ada_4, Ai_8, Ai_20);
      break;
   case 5:
      Gda_500[Ai_0][0] = f0_32(Ada_4, Ai_8, Ai_20);
      break;
   case 6:
      Gda_500[Ai_0][0] = f0_34(Ada_4, Ai_8, Ai_20);
      break;
   case 7:
      Gda_500[Ai_0][0] = f0_57(Ada_4, Gda_500[Ai_0][1], Ai_8, Ai_20);
      break;
   case 8:
      Gda_500[Ai_0][0] = f0_23(Ada_4, Ai_8, Ai_20);
      break;
   case 9:
      Gda_500[Ai_0][0] = f0_50(Ada_4, Gda_500[Ai_0][1], Ai_8, Ai_20);
      break;
   case 10:
      Gda_500[Ai_0][0] = f0_60(Ai_0, 0, Ada_4[Ai_20], Ai_8, 1, Ai_20);
      break;
   case 11:
      Gda_500[Ai_0][0] = f0_51(Ai_0, 0, Ada_4[Ai_20], Ai_8, 0.7, Ai_20);
      break;
   case 12:
      Gda_500[Ai_0][0] = f0_61(Ada_4, Lda_24, Ai_8, Ai_20);
      break;
   case 13:
      Gda_500[Ai_0][0] = f0_37(Ada_4, Ai_8, Ai_20);
      break;
   case 14:
      Gda_500[Ai_0][0] = f0_3(Ada_4, Ai_8, Ai_20);
      break;
   case 15:
      Gda_500[Ai_0][0] = f0_45(Ada_4[Ai_20], Lda_24, Ai_8, 0.5, Ai_20);
      break;
   case 16:
      Gda_500[Ai_0][0] = f0_35(Ada_4, Ai_8, Ai_20);
      break;
   case 17:
      Gda_500[Ai_0][0] = f0_13(Ada_4, Ai_8, Ai_20);
      break;
   case 18:
      Gda_500[Ai_0][0] = f0_15(Ada_4, Ai_8, Ai_20);
      break;
   case 19:
      Gda_500[Ai_0][0] = f0_41(Ada_4, Ai_8, Ai_20);
      break;
   case 20:
      Gda_500[Ai_0][0] = f0_58(Ai_0, 0, Ada_4[Ai_20], Ai_8, 1, Ai_20);
      break;
   case 21:
      Gda_500[Ai_0][0] = f0_52(Ada_4, Lda_24, Ai_8, Ai_20);
      break;
   case 22:
      Gda_500[Ai_0][0] = f0_21(Ada_4, Ai_8, 0.85, 8, Ai_20);
      break;
   case 23:
      Gda_500[Ai_0][0] = f0_11(Ai_0, Ada_4[Ai_20], Ai_8, 1, Ai_20);
      break;
   case 24:
      Gda_500[Ai_0][0] = f0_33(Ai_0, 0, Ada_4[Ai_20], Ai_8, 0.7, Ai_20);
      break;
   case 25:
      Gda_500[Ai_0][0] = f0_54(Ai_0, Ada_4[Ai_20], Ai_8, 4, Ai_20);
      break;
   default:
      Gda_500[Ai_0][0] = f0_0(Ada_4, Ai_8, Ai_20);
   }
   return (Gda_500[Ai_0][0]);
}

double f0_10(int A_applied_price_0, int Ai_4, int Ai_8) {
   double Ld_12 = 0;
   for (int count_20 = 0; count_20 < Ai_4; count_20++) Ld_12 += iMA(NULL, 0, 1, 0, MODE_SMA, A_applied_price_0, Ai_8 + count_20);
   return (Ld_12 / Ai_4);
}

double f0_0(double Ada_0[], int Ai_4, int Ai_8) {
   double Ld_12 = 0;
   for (int count_20 = 0; count_20 < Ai_4; count_20++) Ld_12 += Ada_0[Ai_8 + count_20];
   return (Ld_12 / Ai_4);
}

double f0_28(int A_applied_price_0, double Ad_4, int Ai_12, int Ai_16) {
   double Ld_ret_20;
   if (Ai_16 >= Bars - 2) Ld_ret_20 = iMA(NULL, 0, 1, 0, MODE_SMA, A_applied_price_0, Ai_16);
   else Ld_ret_20 = Ad_4 + 2.0 / (Ai_12 + 1) * (iMA(NULL, 0, 1, 0, MODE_SMA, A_applied_price_0, Ai_16) - Ad_4);
   return (Ld_ret_20);
}

double f0_40(double Ad_0, double Ad_8, int Ai_16, int Ai_20) {
   double Ld_ret_24;
   if (Ai_20 >= Bars - 2) Ld_ret_24 = Ad_0;
   else Ld_ret_24 = Ad_8 + 2.0 / (Ai_16 + 1) * (Ad_0 - Ad_8);
   return (Ld_ret_24);
}

double f0_4(int A_applied_price_0, double Ad_4, int Ai_12, int Ai_16) {
   double Ld_ret_20;
   if (Ai_16 >= Bars - 2) Ld_ret_20 = iMA(NULL, 0, 1, 0, MODE_SMA, A_applied_price_0, Ai_16);
   else Ld_ret_20 = Ad_4 + (iMA(NULL, 0, 1, 0, MODE_SMA, A_applied_price_0, Ai_16) - Ad_4) / Ai_12;
   return (Ld_ret_20);
}

double f0_36(double Ad_0, double Ad_8, int Ai_16, int Ai_20) {
   double Ld_ret_24;
   if (Ai_20 >= Bars - 2) Ld_ret_24 = Ad_0;
   else Ld_ret_24 = Ad_8 + (Ad_0 - Ad_8) / Ai_16;
   return (Ld_ret_24);
}

double f0_42(int A_applied_price_0, int Ai_4, int Ai_8) {
   double Ld_ret_32;
   double Ld_12 = 0;
   double Ld_20 = 0;
   for (int count_28 = 0; count_28 < Ai_4; count_28++) {
      Ld_20 += Ai_4 - count_28;
      Ld_12 += iMA(NULL, 0, 1, 0, MODE_SMA, A_applied_price_0, Ai_8 + count_28) * (Ai_4 - count_28);
   }
   if (Ld_20 > 0.0) Ld_ret_32 = Ld_12 / Ld_20;
   else Ld_ret_32 = 0;
   return (Ld_ret_32);
}

double f0_18(double Ada_0[], int Ai_4, int Ai_8) {
   double Ld_ret_32;
   double Ld_12 = 0;
   double Ld_20 = 0;
   for (int count_28 = 0; count_28 < Ai_4; count_28++) {
      Ld_20 += Ai_4 - count_28;
      Ld_12 += (Ada_0[Ai_8 + count_28]) * (Ai_4 - count_28);
   }
   if (Ld_20 > 0.0) Ld_ret_32 = Ld_12 / Ld_20;
   else Ld_ret_32 = 0;
   return (Ld_ret_32);
}

double f0_44(int A_applied_price_0, int Ai_4, int Ai_8) {
   double Ld_ret_40;
   double Ld_12 = 3.1415926535;
   double Ld_20 = 0;
   double Ld_28 = 0;
   for (int count_36 = 0; count_36 < Ai_4; count_36++) {
      Ld_28 += MathSin(Ld_12 * (count_36 + 1) / (Ai_4 + 1));
      Ld_20 += iMA(NULL, 0, 1, 0, MODE_SMA, A_applied_price_0, Ai_8 + count_36) * MathSin(Ld_12 * (count_36 + 1) / (Ai_4 + 1));
   }
   if (Ld_28 > 0.0) Ld_ret_40 = Ld_20 / Ld_28;
   else Ld_ret_40 = 0;
   return (Ld_ret_40);
}

double f0_39(double Ada_0[], int Ai_4, int Ai_8) {
   double Ld_ret_40;
   double Ld_12 = 3.1415926535;
   double Ld_20 = 0;
   double Ld_28 = 0;
   for (int count_36 = 0; count_36 < Ai_4; count_36++) {
      Ld_28 += MathSin(Ld_12 * (count_36 + 1) / (Ai_4 + 1));
      Ld_20 += (Ada_0[Ai_8 + count_36]) * MathSin(Ld_12 * (count_36 + 1) / (Ai_4 + 1));
   }
   if (Ld_28 > 0.0) Ld_ret_40 = Ld_20 / Ld_28;
   else Ld_ret_40 = 0;
   return (Ld_ret_40);
}

double f0_22(int Ai_0, int Ai_4, int Ai_8) {
   double Ld_12;
   int Li_20 = MathCeil((Ai_4 + 1) / 2.0);
   double Ld_24 = 0;
   for (int count_32 = 0; count_32 < Li_20; count_32++) {
      Ld_12 = f0_10(Ai_0, Li_20, Ai_8 + count_32);
      Ld_24 += Ld_12;
   }
   double Ld_ret_36 = Ld_24 / Li_20;
   return (Ld_ret_36);
}

double f0_32(double Ada_0[], int Ai_4, int Ai_8) {
   double Ld_12;
   int Li_20 = MathCeil((Ai_4 + 1) / 2.0);
   double Ld_24 = 0;
   for (int count_32 = 0; count_32 < Li_20; count_32++) {
      Ld_12 = f0_0(Ada_0, Li_20, Ai_8 + count_32);
      Ld_24 += Ld_12;
   }
   double Ld_ret_36 = Ld_24 / Li_20;
   return (Ld_ret_36);
}

double f0_17(int A_applied_price_0, int Ai_4, int Ai_8) {
   double Ld_12 = 0;
   for (int Li_20 = Ai_4; Li_20 >= 1; Li_20--) Ld_12 += (Li_20 - (Ai_4 + 1) / 3.0) * iMA(NULL, 0, 1, 0, MODE_SMA, A_applied_price_0, Ai_8 + Ai_4 - Li_20);
   double Ld_ret_24 = 6.0 * Ld_12 / (Ai_4 * (Ai_4 + 1));
   return (Ld_ret_24);
}

double f0_34(double Ada_0[], int Ai_4, int Ai_8) {
   double Ld_12 = 0;
   for (int Li_20 = Ai_4; Li_20 >= 1; Li_20--) Ld_12 += (Li_20 - (Ai_4 + 1) / 3.0) * (Ada_0[Ai_8 + Ai_4 - Li_20]);
   double Ld_ret_24 = 6.0 * Ld_12 / (Ai_4 * (Ai_4 + 1));
   return (Ld_ret_24);
}

double f0_55(int A_applied_price_0, double Ad_4, int Ai_12, int Ai_16) {
   double Ld_ret_20;
   double Ld_28;
   if (Ai_16 == Bars - Ai_12) Ld_ret_20 = f0_10(A_applied_price_0, Ai_12, Ai_16);
   else {
      if (Ai_16 < Bars - Ai_12) {
         Ld_28 = 0;
         for (int count_36 = 0; count_36 < Ai_12; count_36++) Ld_28 += iMA(NULL, 0, 1, 0, MODE_SMA, A_applied_price_0, Ai_16 + count_36 + 1);
         Ld_ret_20 = (Ld_28 - Ad_4 + iMA(NULL, 0, 1, 0, MODE_SMA, A_applied_price_0, Ai_16)) / Ai_12;
      }
   }
   return (Ld_ret_20);
}

double f0_57(double Ada_0[], double Ad_4, int Ai_12, int Ai_16) {
   double Ld_ret_20;
   double Ld_28;
   if (Ai_16 == Bars - Ai_12) Ld_ret_20 = f0_0(Ada_0, Ai_12, Ai_16);
   else {
      if (Ai_16 < Bars - Ai_12) {
         Ld_28 = 0;
         for (int count_36 = 0; count_36 < Ai_12; count_36++) Ld_28 += Ada_0[Ai_16 + count_36 + 1];
         Ld_ret_20 = (Ld_28 - Ad_4 + Ada_0[Ai_16]) / Ai_12;
      }
   }
   return (Ld_ret_20);
}

double f0_49(int A_applied_price_0, int Ai_4, int Ai_8) {
   double Lda_12[];
   double ima_20;
   int Li_16 = MathSqrt(Ai_4);
   ArrayResize(Lda_12, Li_16);
   if (Ai_8 == Bars - Ai_4) ima_20 = iMA(NULL, 0, 1, 0, MODE_SMA, A_applied_price_0, Ai_8);
   else {
      if (Ai_8 < Bars - Ai_4) {
         for (int index_28 = 0; index_28 < Li_16; index_28++) Lda_12[index_28] = 2.0 * f0_42(A_applied_price_0, Ai_4 / 2, Ai_8 + index_28) - f0_42(A_applied_price_0, Ai_4, Ai_8 + index_28);
         ima_20 = f0_18(Lda_12, Li_16, 0);
      }
   }
   return (ima_20);
}

double f0_23(double Ada_0[], int Ai_4, int Ai_8) {
   double Lda_12[];
   double Ld_ret_20;
   int Li_16 = MathSqrt(Ai_4);
   ArrayResize(Lda_12, Li_16);
   if (Ai_8 == Bars - Ai_4) Ld_ret_20 = Ada_0[Ai_8];
   else {
      if (Ai_8 < Bars - Ai_4) {
         for (int index_28 = 0; index_28 < Li_16; index_28++) Lda_12[index_28] = 2.0 * f0_18(Ada_0, Ai_4 / 2, Ai_8 + index_28) - f0_18(Ada_0, Ai_4, Ai_8 + index_28);
         Ld_ret_20 = f0_18(Lda_12, Li_16, 0);
      }
   }
   return (Ld_ret_20);
}

double f0_29(int A_applied_price_0, double Ad_4, int Ai_12, int Ai_16) {
   double Ld_ret_32;
   double Ld_20 = 2.0 / (Ai_12 + 1);
   int Li_28 = (Ai_12 - 1) / 2.0;
   if (Ai_16 >= Bars - Li_28) Ld_ret_32 = iMA(NULL, 0, 1, 0, MODE_SMA, A_applied_price_0, Ai_16);
   else Ld_ret_32 = Ld_20 * (2.0 * iMA(NULL, 0, 1, 0, MODE_SMA, A_applied_price_0, Ai_16) - iMA(NULL, 0, 1, 0, MODE_SMA, A_applied_price_0, Ai_16 + Li_28)) + (1 - Ld_20) * Ad_4;
   return (Ld_ret_32);
}

double f0_50(double Ada_0[], double Ad_4, int Ai_12, int Ai_16) {
   double Ld_ret_32;
   double Ld_20 = 2.0 / (Ai_12 + 1);
   int Li_28 = (Ai_12 - 1) / 2.0;
   if (Ai_16 >= Bars - Li_28) Ld_ret_32 = Ada_0[Ai_16];
   else Ld_ret_32 = Ld_20 * (2.0 * Ada_0[Ai_16] - (Ada_0[Ai_16 + Li_28])) + (1 - Ld_20) * Ad_4;
   return (Ld_ret_32);
}

double f0_9(int Ai_0, int Ai_4, int A_applied_price_8, double Ad_12, double Ad_20, int Ai_28) {
   double Ld_ret_40;
   double Ld_32 = 2.0 / (Ad_12 + 1.0);
   if (Ai_28 == Bars - 2) {
      Ld_ret_40 = iMA(NULL, 0, 1, 0, MODE_SMA, A_applied_price_8, Ai_28);
      Gda_496[Ai_4][Ai_0][0] = Ld_ret_40;
      Gda_496[Ai_4 + 1][Ai_0][0] = Ld_ret_40;
   } else {
      if (Ai_28 < Bars - 2) {
         Gda_496[Ai_4][Ai_0][0] = Gda_496[Ai_4][Ai_0][1] + Ld_32 * (iMA(NULL, 0, 1, 0, MODE_SMA, A_applied_price_8, Ai_28) - Gda_496[Ai_4][Ai_0][1]);
         Gda_496[Ai_4 + 1][Ai_0][0] = Gda_496[Ai_4 + 1][Ai_0][1] + Ld_32 * (Gda_496[Ai_4][Ai_0][0] - Gda_496[Ai_4 + 1][Ai_0][1]);
         Ld_ret_40 = Gda_496[Ai_4][Ai_0][0] * (Ad_20 + 1.0) - Gda_496[Ai_4 + 1][Ai_0][0] * Ad_20;
      }
   }
   return (Ld_ret_40);
}

double f0_60(int Ai_0, int Ai_4, double Ad_8, double Ad_16, double Ad_24, int Ai_32) {
   double Ld_ret_44;
   double Ld_36 = 2.0 / (Ad_16 + 1.0);
   if (Ai_32 == Bars - 2) {
      Ld_ret_44 = Ad_8;
      Gda_496[Ai_4][Ai_0][0] = Ld_ret_44;
      Gda_496[Ai_4 + 1][Ai_0][0] = Ld_ret_44;
   } else {
      if (Ai_32 < Bars - 2) {
         Gda_496[Ai_4][Ai_0][0] = Gda_496[Ai_4][Ai_0][1] + Ld_36 * (Ad_8 - Gda_496[Ai_4][Ai_0][1]);
         Gda_496[Ai_4 + 1][Ai_0][0] = Gda_496[Ai_4 + 1][Ai_0][1] + Ld_36 * (Gda_496[Ai_4][Ai_0][0] - Gda_496[Ai_4 + 1][Ai_0][1]);
         Ld_ret_44 = Gda_496[Ai_4][Ai_0][0] * (Ad_24 + 1.0) - Gda_496[Ai_4 + 1][Ai_0][0] * Ad_24;
      }
   }
   return (Ld_ret_44);
}

double f0_25(int Ai_0, int Ai_4, int A_applied_price_8, int Ai_12, double Ad_16, int Ai_24) {
   double Ld_28;
   double Ld_36;
   double ima_44;
   if (Ai_24 == Bars - 2) {
      ima_44 = iMA(NULL, 0, 1, 0, MODE_SMA, A_applied_price_8, Ai_24);
      for (int count_52 = 0; count_52 < 6; count_52++) Gda_496[Ai_4 + count_52][Ai_0][0] = ima_44;
   } else {
      if (Ai_24 < Bars - 2) {
         ima_44 = iMA(NULL, 0, 1, 0, MODE_SMA, A_applied_price_8, Ai_24);
         Ld_28 = f0_60(Ai_0, Ai_4, ima_44, Ai_12, Ad_16, Ai_24);
         Ld_36 = f0_60(Ai_0, Ai_4 + 2, Ld_28, Ai_12, Ad_16, Ai_24);
         ima_44 = f0_60(Ai_0, Ai_4 + 4, Ld_36, Ai_12, Ad_16, Ai_24);
      }
   }
   return (ima_44);
}

double f0_51(int Ai_0, int Ai_4, double Ad_8, int Ai_16, double Ad_20, int Ai_28) {
   double Ld_32;
   double Ld_40;
   double Ld_ret_48;
   if (Ai_28 == Bars - 2) {
      Ld_ret_48 = Ad_8;
      for (int count_56 = 0; count_56 < 6; count_56++) Gda_496[Ai_4 + count_56][Ai_0][0] = Ad_8;
   } else {
      if (Ai_28 < Bars - 2) {
         Ld_32 = f0_60(Ai_0, Ai_4, Ad_8, Ai_16, Ad_20, Ai_28);
         Ld_40 = f0_60(Ai_0, Ai_4 + 2, Ld_32, Ai_16, Ad_20, Ai_28);
         Ld_ret_48 = f0_60(Ai_0, Ai_4 + 4, Ld_40, Ai_16, Ad_20, Ai_28);
      }
   }
   return (Ld_ret_48);
}

double f0_7(int A_applied_price_0, double Ada_4[3], int Ai_8, int Ai_12) {
   double Ld_ret_24;
   double Ld_16 = 2.0 / (Ai_8 + 1);
   if (Ai_12 < Bars - 7) {
      Ld_ret_24 = (Ld_16 - Ld_16 / 4.0 * Ld_16) * iMA(NULL, 0, 1, 0, MODE_SMA, A_applied_price_0, Ai_12) + Ld_16 / 2.0 * Ld_16 * iMA(NULL, 0, 1, 0, MODE_SMA, A_applied_price_0,
         Ai_12 + 1) - (Ld_16 - 0.75 * Ld_16 * Ld_16) * iMA(NULL, 0, 1, 0, MODE_SMA, A_applied_price_0, Ai_12 + 2) + 2.0 * (1 - Ld_16) * Ada_4[1] - (1 - Ld_16) * (1 - Ld_16) * Ada_4[2];
   } else {
      Ld_ret_24 = (iMA(NULL, 0, 1, 0, MODE_SMA, A_applied_price_0, Ai_12) + 2.0 * iMA(NULL, 0, 1, 0, MODE_SMA, A_applied_price_0, Ai_12 + 1) + iMA(NULL, 0, 1, 0, MODE_SMA,
         A_applied_price_0, Ai_12) + 2.0) / 4.0;
   }
   return (Ld_ret_24);
}

double f0_61(double Ada_0[], double Ada_4[3], int Ai_8, int Ai_12) {
   double Ld_ret_24;
   double Ld_16 = 2.0 / (Ai_8 + 1);
   if (Ai_12 < Bars - 7) Ld_ret_24 = (Ld_16 - Ld_16 / 4.0 * Ld_16) * Ada_0[Ai_12] + Ld_16 / 2.0 * Ld_16 * (Ada_0[Ai_12 + 1]) - (Ld_16 - 0.75 * Ld_16 * Ld_16) * (Ada_0[Ai_12 + 2]) + 2.0 * (1 - Ld_16) * Ada_4[1] - (1 - Ld_16) * (1 - Ld_16) * Ada_4[2];
   else Ld_ret_24 = (Ada_0[Ai_12] + 2.0 * (Ada_0[Ai_12 + 1]) + (Ada_0[Ai_12 + 2])) / 4.0;
   return (Ld_ret_24);
}

double f0_24(int A_applied_price_0, int Ai_4, int Ai_8) {
   double Lda_12[];
   double Ld_ret_24;
   ArrayResize(Lda_12, Ai_4);
   for (int index_16 = 0; index_16 < Ai_4; index_16++) Lda_12[index_16] = iMA(NULL, 0, 1, 0, MODE_SMA, A_applied_price_0, Ai_8 + index_16);
   ArraySort(Lda_12);
   int Li_20 = MathRound((Ai_4 - 1) / 2);
   if (MathMod(Ai_4, 2) > 0.0) Ld_ret_24 = Lda_12[Li_20];
   else Ld_ret_24 = (Lda_12[Li_20] + (Lda_12[Li_20 + 1])) / 2.0;
   return (Ld_ret_24);
}

double f0_37(double Ada_0[], int Ai_4, int Ai_8) {
   double Lda_12[];
   double Ld_ret_24;
   ArrayResize(Lda_12, Ai_4);
   for (int index_16 = 0; index_16 < Ai_4; index_16++) Lda_12[index_16] = Ada_0[Ai_8 + index_16];
   ArraySort(Lda_12);
   int Li_20 = MathRound((Ai_4 - 1) / 2);
   if (MathMod(Ai_4, 2) > 0.0) Ld_ret_24 = Lda_12[Li_20];
   else Ld_ret_24 = (Lda_12[Li_20] + (Lda_12[Li_20 + 1])) / 2.0;
   return (Ld_ret_24);
}

double f0_6(int A_applied_price_0, int Ai_4, int Ai_8) {
   double Ld_ret_12;
   if (Ai_8 < Bars - Ai_4) {
      Ld_ret_12 = MathPow(iMA(NULL, 0, 1, 0, MODE_SMA, A_applied_price_0, Ai_8), 1.0 / Ai_4);
      for (int Li_20 = 1; Li_20 < Ai_4; Li_20++) Ld_ret_12 *= MathPow(iMA(NULL, 0, 1, 0, MODE_SMA, A_applied_price_0, Ai_8 + Li_20), 1.0 / Ai_4);
   }
   return (Ld_ret_12);
}

double f0_3(double Ada_0[], int Ai_4, int Ai_8) {
   double Ld_ret_12;
   if (Ai_8 < Bars - Ai_4) {
      Ld_ret_12 = MathPow(Ada_0[Ai_8], 1.0 / Ai_4);
      for (int Li_20 = 1; Li_20 < Ai_4; Li_20++) Ld_ret_12 *= MathPow(Ada_0[Ai_8 + Li_20], 1.0 / Ai_4);
   }
   return (Ld_ret_12);
}

double f0_14(int A_applied_price_0, double Ada_4[3], int Ai_8, double Ad_12, int Ai_20) {
   double Ld_ret_32;
   double Ld_24 = 2.0 / (Ai_8 + 1);
   if (Ai_20 >= Bars - 3) Ld_ret_32 = iMA(NULL, 0, 1, 0, MODE_SMA, A_applied_price_0, Ai_20);
   else Ld_ret_32 = (Ada_4[1] * (2.0 * Ad_12 + 1.0) + Ld_24 * (iMA(NULL, 0, 1, 0, MODE_SMA, A_applied_price_0, Ai_20) - Ada_4[1]) - Ad_12 * Ada_4[2]) / (Ad_12 + 1.0);
   return (Ld_ret_32);
}

double f0_45(double Ad_0, double Ada_8[3], int Ai_12, double Ad_16, int Ai_24) {
   double Ld_ret_36;
   double Ld_28 = 2.0 / (Ai_12 + 1);
   if (Ai_24 >= Bars - 3) Ld_ret_36 = Ad_0;
   else Ld_ret_36 = (Ada_8[1] * (2.0 * Ad_16 + 1.0) + Ld_28 * (Ad_0 - Ada_8[1]) - Ad_16 * Ada_8[2]) / (Ad_16 + 1.0);
   return (Ld_ret_36);
}

double f0_59(int A_applied_price_0, int Ai_4, int Ai_8) {
   double Ld_64;
   double Ld_12 = Ai_4 * (Ai_4 - 1) / 2.0;
   double Ld_20 = (Ai_4 - 1) * Ai_4 * (Ai_4 * 2 - 1) / 6.0;
   double Ld_28 = 0;
   double Ld_36 = 0;
   for (int count_44 = 0; count_44 < Ai_4; count_44++) {
      Ld_28 += count_44 * iMA(NULL, 0, 1, 0, MODE_SMA, A_applied_price_0, Ai_8 + count_44);
      Ld_36 += iMA(NULL, 0, 1, 0, MODE_SMA, A_applied_price_0, Ai_8 + count_44);
   }
   double Ld_48 = Ai_4 * Ld_28 - Ld_12 * Ld_36;
   double Ld_56 = Ld_12 * Ld_12 - Ai_4 * Ld_20;
   if (Ld_56 != 0.0) Ld_64 = Ld_48 / Ld_56;
   else Ld_64 = 0;
   double Ld_ret_72 = Ld_64 + f0_10(A_applied_price_0, Ai_4, Ai_8);
   return (Ld_ret_72);
}

double f0_35(double Ada_0[], int Ai_4, int Ai_8) {
   double Ld_64;
   double Ld_12 = Ai_4 * (Ai_4 - 1) / 2.0;
   double Ld_20 = (Ai_4 - 1) * Ai_4 * (Ai_4 * 2 - 1) / 6.0;
   double Ld_28 = 0;
   double Ld_36 = 0;
   for (int count_44 = 0; count_44 < Ai_4; count_44++) {
      Ld_28 += count_44 * (Ada_0[Ai_8 + count_44]);
      Ld_36 += Ada_0[Ai_8 + count_44];
   }
   double Ld_48 = Ai_4 * Ld_28 - Ld_12 * Ld_36;
   double Ld_56 = Ld_12 * Ld_12 - Ai_4 * Ld_20;
   if (Ld_56 != 0.0) Ld_64 = Ld_48 / Ld_56;
   else Ld_64 = 0;
   double Ld_ret_72 = Ld_64 + f0_0(Ada_0, Ai_4, Ai_8);
   return (Ld_ret_72);
}

double f0_5(int Ai_0, int Ai_4, int Ai_8) {
   double Ld_ret_12 = (f0_59(Ai_0, Ai_4, Ai_8) + f0_17(Ai_0, Ai_4, Ai_8)) / 2.0;
   return (Ld_ret_12);
}

double f0_13(double Ada_0[], int Ai_4, int Ai_8) {
   double Ld_ret_12 = (f0_35(Ada_0, Ai_4, Ai_8) + f0_34(Ada_0, Ai_4, Ai_8)) / 2.0;
   return (Ld_ret_12);
}

double f0_1(int Ai_0, int Ai_4, int Ai_8) {
   int Li_12 = MathFloor((Ai_4 + 1) / 2.0);
   int Li_16 = MathCeil((Ai_4 + 1) / 2.0);
   double Ld_20 = 0;
   for (int count_28 = 0; count_28 < Li_16; count_28++) Ld_20 += f0_10(Ai_0, Li_12, Ai_8 + count_28);
   double Ld_ret_32 = Ld_20 / Li_16;
   return (Ld_ret_32);
}

double f0_15(double Ada_0[], int Ai_4, int Ai_8) {
   int Li_12 = MathFloor((Ai_4 + 1) / 2.0);
   int Li_16 = MathCeil((Ai_4 + 1) / 2.0);
   double Ld_20 = 0;
   for (int count_28 = 0; count_28 < Li_16; count_28++) Ld_20 += f0_0(Ada_0, Li_12, Ai_8 + count_28);
   double Ld_ret_32 = Ld_20 / Li_16;
   return (Ld_ret_32);
}

double f0_47(int A_applied_price_0, int Ai_4, int Ai_8) {
   double Ld_ret_32;
   double Ld_12 = 0;
   double Ld_20 = 0;
   for (int count_28 = 0; count_28 < Ai_4; count_28++) {
      Ld_20 += Volume[Ai_8 + count_28];
      Ld_12 += iMA(NULL, 0, 1, 0, MODE_SMA, A_applied_price_0, Ai_8 + count_28) * (Volume[Ai_8 + count_28]);
   }
   if (Ld_20 > 0.0) Ld_ret_32 = Ld_12 / Ld_20;
   else Ld_ret_32 = 0;
   return (Ld_ret_32);
}

double f0_41(double Ada_0[], int Ai_4, int Ai_8) {
   double Ld_ret_32;
   double Ld_12 = 0;
   double Ld_20 = 0;
   for (int count_28 = 0; count_28 < Ai_4; count_28++) {
      Ld_20 += Volume[Ai_8 + count_28];
      Ld_12 += (Ada_0[Ai_8 + count_28]) * (Volume[Ai_8 + count_28]);
   }
   if (Ld_20 > 0.0) Ld_ret_32 = Ld_12 / Ld_20;
   else Ld_ret_32 = 0;
   return (Ld_ret_32);
}

double f0_38(int Ai_0, int Ai_4, int A_applied_price_8, int Ai_12, double Ad_16, int Ai_24) {
   double Ld_28 = (Ai_12 - 1) / 2.0 / ((Ai_12 - 1) / 2.0 + 2.0);
   double Ld_36 = MathPow(Ld_28, Ad_16);
   double ima_44 = iMA(NULL, 0, 1, 0, MODE_SMA, A_applied_price_8, Ai_24);
   if (Ai_24 == Bars - 2) {
      Gda_496[Ai_4 + 4][Ai_0][0] = ima_44;
      Gda_496[Ai_4 + 0][Ai_0][0] = ima_44;
      Gda_496[Ai_4 + 2][Ai_0][0] = ima_44;
   } else {
      if (Ai_24 < Bars - 2) {
         Gda_496[Ai_4 + 0][Ai_0][0] = (1 - Ld_36) * ima_44 + Ld_36 * Gda_496[Ai_4 + 0][Ai_0][1];
         Gda_496[Ai_4 + 1][Ai_0][0] = (ima_44 - Gda_496[Ai_4 + 0][Ai_0][0]) * (1 - Ld_28) + Ld_28 * Gda_496[Ai_4 + 1][Ai_0][1];
         Gda_496[Ai_4 + 2][Ai_0][0] = Gda_496[Ai_4 + 0][Ai_0][0] + Gda_496[Ai_4 + 1][Ai_0][0];
         Gda_496[Ai_4 + 3][Ai_0][0] = (Gda_496[Ai_4 + 2][Ai_0][0] - Gda_496[Ai_4 + 4][Ai_0][1]) * MathPow(1 - Ld_36, 2) + MathPow(Ld_36, 2) * Gda_496[Ai_4 + 3][Ai_0][1];
         Gda_496[Ai_4 + 4][Ai_0][0] = Gda_496[Ai_4 + 4][Ai_0][1] + Gda_496[Ai_4 + 3][Ai_0][0];
      }
   }
   return (Gda_496[Ai_4 + 4][Ai_0][0]);
}

double f0_58(int Ai_0, int Ai_4, double Ad_8, int Ai_16, double Ad_20, int Ai_28) {
   double Ld_32 = (Ai_16 - 1) / 2.0 / ((Ai_16 - 1) / 2.0 + 2.0);
   double Ld_40 = MathPow(Ld_32, Ad_20);
   if (Ai_28 == Bars - 2) {
      Gda_496[Ai_4 + 4][Ai_0][0] = Ad_8;
      Gda_496[Ai_4 + 0][Ai_0][0] = Ad_8;
      Gda_496[Ai_4 + 2][Ai_0][0] = Ad_8;
   } else {
      if (Ai_28 < Bars - 2) {
         Gda_496[Ai_4 + 0][Ai_0][0] = (1 - Ld_40) * Ad_8 + Ld_40 * Gda_496[Ai_4 + 0][Ai_0][1];
         Gda_496[Ai_4 + 1][Ai_0][0] = (Ad_8 - Gda_496[Ai_4 + 0][Ai_0][0]) * (1 - Ld_32) + Ld_32 * Gda_496[Ai_4 + 1][Ai_0][1];
         Gda_496[Ai_4 + 2][Ai_0][0] = Gda_496[Ai_4 + 0][Ai_0][0] + Gda_496[Ai_4 + 1][Ai_0][0];
         Gda_496[Ai_4 + 3][Ai_0][0] = (Gda_496[Ai_4 + 2][Ai_0][0] - Gda_496[Ai_4 + 4][Ai_0][1]) * MathPow(1 - Ld_40, 2) + MathPow(Ld_40, 2) * Gda_496[Ai_4 + 3][Ai_0][1];
         Gda_496[Ai_4 + 4][Ai_0][0] = Gda_496[Ai_4 + 4][Ai_0][1] + Gda_496[Ai_4 + 3][Ai_0][0];
      }
   }
   return (Gda_496[Ai_4 + 4][Ai_0][0]);
}

double f0_53(int A_applied_price_0, double Ada_4[3], int Ai_8, int Ai_12) {
   double Ld_ret_16;
   if (Ai_12 == Bars - Ai_8) Ld_ret_16 = f0_10(A_applied_price_0, Ai_8, Ai_12);
   else
      if (Ai_12 < Bars - Ai_8) Ld_ret_16 = (iMA(NULL, 0, 1, 0, MODE_SMA, A_applied_price_0, Ai_12) - iMA(NULL, 0, 1, 0, MODE_SMA, A_applied_price_0, Ai_12 + Ai_8)) / Ai_8 + Ada_4[1];
   return (Ld_ret_16);
}

double f0_52(double Ada_0[], double Ada_4[3], int Ai_8, int Ai_12) {
   double Ld_ret_16;
   if (Ai_12 == Bars - Ai_8) Ld_ret_16 = f0_0(Ada_0, Ai_8, Ai_12);
   else
      if (Ai_12 < Bars - Ai_8) Ld_ret_16 = (Ada_0[Ai_12] - (Ada_0[Ai_12 + Ai_8])) / Ai_8 + Ada_4[1];
   return (Ld_ret_16);
}

double f0_12(int A_applied_price_0, int Ai_4, double Ad_8, double Ad_16, int Ai_24) {
   double Ld_44;
   double Ld_ret_72;
   double Ld_28 = MathFloor(Ad_8 * (Ai_4 - 1));
   double Ld_36 = Ai_4 / Ad_16;
   double Ld_52 = 0;
   double Ld_60 = 0;
   for (int count_68 = 0; count_68 < Ai_4; count_68++) {
      Ld_44 = MathExp(-((count_68 - Ld_28) * (count_68 - Ld_28)) / (2.0 * Ld_36 * Ld_36));
      Ld_60 += Ld_44;
      Ld_52 += iMA(NULL, 0, 1, 0, MODE_SMA, A_applied_price_0, Ai_24 + (Ai_4 - 1 - count_68)) * Ld_44;
   }
   if (Ld_60 != 0.0) Ld_ret_72 = Ld_52 / Ld_60;
   return (Ld_ret_72);
}

double f0_21(double Ada_0[], int Ai_4, double Ad_8, double Ad_16, int Ai_24) {
   double Ld_44;
   double Ld_ret_72;
   double Ld_28 = MathFloor(Ad_8 * (Ai_4 - 1));
   double Ld_36 = Ai_4 / Ad_16;
   double Ld_52 = 0;
   double Ld_60 = 0;
   for (int count_68 = 0; count_68 < Ai_4; count_68++) {
      Ld_44 = MathExp(-((count_68 - Ld_28) * (count_68 - Ld_28)) / (2.0 * Ld_36 * Ld_36));
      Ld_60 += Ld_44;
      Ld_52 += (Ada_0[Ai_24 + (Ai_4 - 1 - count_68)]) * Ld_44;
   }
   if (Ld_60 != 0.0) Ld_ret_72 = Ld_52 / Ld_60;
   return (Ld_ret_72);
}

double f0_56(int Ai_0, int A_applied_price_4, int Ai_8, double Ad_12, int Ai_20) {
   double Ld_24 = 2.0 / (Ai_8 + 1);
   double ima_32 = iMA(NULL, 0, 1, 0, MODE_SMA, A_applied_price_4, Ai_20);
   if (Ai_20 == Bars - 2) {
      Gda_496[0][Ai_0][0] = ima_32;
      Gda_496[1][Ai_0][0] = ima_32;
      Gda_496[2][Ai_0][0] = ima_32;
   } else {
      if (Ai_20 < Bars - 2) {
         Gda_496[0][Ai_0][0] = Gda_496[0][Ai_0][1] + Ld_24 * (ima_32 - Gda_496[0][Ai_0][1]);
         Gda_496[1][Ai_0][0] = Gda_496[1][Ai_0][1] + Ld_24 * (Gda_496[0][Ai_0][0] - Gda_496[1][Ai_0][1]);
         Gda_496[2][Ai_0][0] = Gda_496[2][Ai_0][1] + Ld_24 * (Gda_496[1][Ai_0][0] - Gda_496[2][Ai_0][1]);
         Gda_496[3][Ai_0][0] = Gda_496[0][Ai_0][0] + Ad_12 * (Gda_496[0][Ai_0][0] + Ad_12 * (Gda_496[0][Ai_0][0] - Gda_496[1][Ai_0][0]) - Gda_496[1][Ai_0][0] - Ad_12 * (Gda_496[1][Ai_0][0] - Gda_496[2][Ai_0][0]));
      }
   }
   return (Gda_496[3][Ai_0][0]);
}

double f0_11(int Ai_0, double Ad_4, int Ai_12, double Ad_16, int Ai_24) {
   double Ld_28 = 2.0 / (Ai_12 + 1);
   if (Ai_24 == Bars - 2) {
      Gda_496[0][Ai_0][0] = Ad_4;
      Gda_496[1][Ai_0][0] = Ad_4;
      Gda_496[2][Ai_0][0] = Ad_4;
   } else {
      if (Ai_24 < Bars - 2) {
         Gda_496[0][Ai_0][0] = Gda_496[0][Ai_0][1] + Ld_28 * (Ad_4 - Gda_496[0][Ai_0][1]);
         Gda_496[1][Ai_0][0] = Gda_496[1][Ai_0][1] + Ld_28 * (Gda_496[0][Ai_0][0] - Gda_496[1][Ai_0][1]);
         Gda_496[2][Ai_0][0] = Gda_496[2][Ai_0][1] + Ld_28 * (Gda_496[1][Ai_0][0] - Gda_496[2][Ai_0][1]);
         Gda_496[3][Ai_0][0] = Gda_496[0][Ai_0][0] + Ad_16 * (Gda_496[0][Ai_0][0] + Ad_16 * (Gda_496[0][Ai_0][0] - Gda_496[1][Ai_0][0]) - Gda_496[1][Ai_0][0] - Ad_16 * (Gda_496[1][Ai_0][0] - Gda_496[2][Ai_0][0]));
      }
   }
   return (Gda_496[3][Ai_0][0]);
}

double f0_20(int Ai_0, int Ai_4, double A_applied_price_8, int Ai_16, double Ad_20, int Ai_28) {
   double Ld_40;
   double Ld_48;
   double Ld_ret_56;
   double Ld_32 = MathMax((Ai_16 + 5.0) / 3.0 - 1.0, 1);
   double ima_64 = iMA(NULL, 0, 1, 0, MODE_SMA, A_applied_price_8, Ai_28);
   if (Ai_28 == Bars - 2) for (int count_72 = 0; count_72 < 6; count_72++) Gda_496[Ai_4 + count_72][Ai_0][0] = ima_64;
   else {
      if (Ai_28 < Bars - 2) {
         Ld_40 = f0_60(Ai_0, Ai_4, ima_64, Ld_32, Ad_20, Ai_28);
         Ld_48 = f0_60(Ai_0, Ai_4 + 2, Ld_40, Ld_32, Ad_20, Ai_28);
         Ld_ret_56 = f0_60(Ai_0, Ai_4 + 4, Ld_48, Ld_32, Ad_20, Ai_28);
      }
   }
   return (Ld_ret_56);
}

double f0_33(int Ai_0, int Ai_4, double Ad_8, int Ai_16, double Ad_20, int Ai_28) {
   double Ld_40;
   double Ld_48;
   double Ld_ret_56;
   double Ld_32 = MathMax((Ai_16 + 5.0) / 3.0 - 1.0, 1);
   if (Ai_28 == Bars - 2) {
      Ld_ret_56 = Ad_8;
      for (int count_64 = 0; count_64 < 6; count_64++) Gda_496[Ai_4 + count_64][Ai_0][0] = Ld_ret_56;
   } else {
      if (Ai_28 < Bars - 2) {
         Ld_40 = f0_60(Ai_0, Ai_4, Ad_8, Ld_32, Ad_20, Ai_28);
         Ld_48 = f0_60(Ai_0, Ai_4 + 2, Ld_40, Ld_32, Ad_20, Ai_28);
         Ld_ret_56 = f0_60(Ai_0, Ai_4 + 4, Ld_48, Ld_32, Ad_20, Ai_28);
      }
   }
   return (Ld_ret_56);
}

double f0_30(int Ai_0, int A_applied_price_4, int Ai_8, int Ai_12, int Ai_16) {
   double Lda_36[];
   double Ld_20 = 1 - 10.0 / (Ai_8 + 9);
   double ima_28 = iMA(NULL, 0, 1, 0, MODE_SMA, A_applied_price_4, Ai_16);
   ArrayResize(Lda_36, Ai_12);
   for (int index_40 = 0; index_40 < Ai_12; index_40++) {
      if (Ai_16 >= Bars - Ai_12) Gda_496[index_40][Ai_0][0] = ima_28;
      else {
         if (index_40 == 0) Gda_496[index_40][Ai_0][0] = (1 - Ld_20) * ima_28 + Ld_20 * Gda_496[index_40][Ai_0][1];
         else Gda_496[index_40][Ai_0][0] = (-Ld_20) * Gda_496[index_40 - 1][Ai_0][0] + Gda_496[index_40 - 1][Ai_0][1] + Ld_20 * Gda_496[index_40][Ai_0][1];
         Lda_36[index_40] = Gda_496[index_40][Ai_0][0];
      }
   }
   double Ld_44 = f0_15(Lda_36, Ai_12, 0);
   return (Ld_44);
}

double f0_54(int Ai_0, double Ad_4, int Ai_12, int Ai_16, int Ai_20) {
   double Lda_32[];
   double Ld_24 = 1 - 10.0 / (Ai_12 + 9);
   ArrayResize(Lda_32, Ai_16);
   for (int index_36 = 0; index_36 < Ai_16; index_36++) {
      if (Ai_20 >= Bars - Ai_16) Gda_496[index_36][Ai_0][0] = Ad_4;
      else {
         if (index_36 == 0) Gda_496[index_36][Ai_0][0] = (1 - Ld_24) * Ad_4 + Ld_24 * Gda_496[index_36][Ai_0][1];
         else Gda_496[index_36][Ai_0][0] = (-Ld_24) * Gda_496[index_36 - 1][Ai_0][0] + Gda_496[index_36 - 1][Ai_0][1] + Ld_24 * Gda_496[index_36][Ai_0][1];
         Lda_32[index_36] = Gda_496[index_36][Ai_0][0];
      }
   }
   double Ld_40 = f0_15(Lda_32, Ai_16, 0);
   return (Ld_40);
}

double f0_2(int Ai_0, double Ada_4[], int Ai_8, double Ad_12) {
   int Li_20;
   if (Ai_0 < 2) Li_20 = 2.0 * MathMax(1, Ai_8) + 1.0;
   else Li_20 = Ai_8;
   bool Li_24 = FALSE;
   bool Li_28 = FALSE;
   double Ld_ret_32 = 0;
   double Ld_ret_40 = 100000000;
   for (int index_48 = 0; index_48 < Li_20; index_48++) {
      if (Ai_0 == 0 || Ai_0 == 2 && Ada_4[index_48] > Ld_ret_32 && Ada_4[index_48] < 1000000.0) {
         Ld_ret_32 = Ada_4[index_48];
         Li_24 = index_48;
      }
      if (Ai_0 == 1 || Ai_0 == 3 && Ada_4[index_48] < Ld_ret_40) {
         Ld_ret_40 = Ada_4[index_48];
         Li_28 = index_48;
      }
   }
   if (Ai_0 < 2) {
      if (Li_24 == Ai_8 && Ld_ret_32 - Ada_4[0] > Ad_12 && Ld_ret_32 - (Ada_4[Li_20 - 1]) > Ad_12) return (Ld_ret_32);
      if (!(Li_28 == Ai_8 && Ada_4[0] - Ld_ret_40 > Ad_12 && Ada_4[Li_20 - 1] - Ld_ret_40 > Ad_12)) return (0);
      return (Ld_ret_40);
   }
   if (Ai_0 == 2) return (Ld_ret_32);
   if (Ai_0 == 3) return (Ld_ret_40);
   return (0);
}

double f0_43(double Ada_0[], int Ai_4) {
   double Ld_8 = 0;
   for (int index_16 = 0; index_16 < Ai_4; index_16++) Ld_8 += Ada_0[index_16] / Ai_4;
   double Ld_20 = 0;
   for (index_16 = 0; index_16 < Ai_4; index_16++) Ld_20 += MathPow(Ada_0[index_16] - Ld_8, 2);
   return (MathSqrt(Ld_20 / Ai_4));
}

void f0_27(int Ai_0, double Ad_4, color A_color_12, int Ai_16, bool Ai_20) {
   string name_24;
   if (Ai_20) name_24 = KEY + "U:" + Time[Ai_0];
   else name_24 = KEY + "D:" + Time[Ai_0];
   double Ld_32 = 1.5 * iATR(NULL, 0, 20, Ai_0);
   if (ObjectFind(name_24) < 0) {
      ObjectCreate(name_24, OBJ_ARROW, 0, Time[Ai_0], 0);
      ObjectSet(name_24, OBJPROP_ARROWCODE, Ai_16);
      ObjectSet(name_24, OBJPROP_COLOR, A_color_12);
      ObjectSet(name_24, OBJPROP_WIDTH, ArrowWidth);
   }
   if (Ai_20) {
      ObjectSet(name_24, OBJPROP_PRICE1, Ad_4 - Ld_32);
      return;
   }
   ObjectSet(name_24, OBJPROP_PRICE1, Ad_4 + Ld_32);
}

void f0_26(int Ai_0, bool Ai_4) {
   string name_8;
   if (Ai_4) name_8 = KEY + "U:" + Time[Ai_0];
   else name_8 = KEY + "D:" + Time[Ai_0];
   if (ObjectFind(name_8) > -1) ObjectDelete(name_8);
}
