//+------------------------------------------------------------------+
//|                                                CandleDisplay.mq4 |
//|                                     Copyright 2022, Sanju Reddy. |
//|                                            https://sanjureddy.in |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2022, Sanju Reddy."
#property link      "https://sanjureddy.in"
#property version   "1.00"
#property strict
#property icon      "\\Files\\SR7.ico"
#property description "Displays the candle size wicks' length above and below the candles."

#property indicator_chart_window
#property indicator_buffers 3

extern int    font_size = 10; // Font Size
extern color  cb = DodgerBlue; // Font Color
extern color  ColorBull = LightGreen; // Bull Font Color
extern color  ColorBear = Red; // Bear Font Color
extern string font_name = "Arial"; // Font Family
extern int    max_candles = 0; // Max Candles To Draw
extern bool show_on_chart = true; // Show On Chart?
extern int min_candle_size = 100; // Minimun Size Of Candle

string CandleSizeString = "CS-";
string CandleUpperWickSizeString = "CWU-";
string CandleLowerWickSizeString = "CWL-";

double LowerWick[], UpperWick[], CandleSize[];

int init()
{
    SetIndexBuffer(0, LowerWick);
    SetIndexBuffer(1, UpperWick);
    SetIndexBuffer(2, CandleSize);
    
    SetIndexStyle(0, DRAW_NONE);
    SetIndexStyle(1, DRAW_NONE);
    SetIndexStyle(2, DRAW_NONE);
    return(0);
}

int start()
{
    int counted_bars = IndicatorCounted();
    if (counted_bars > 0) counted_bars--;
    int limit = Bars - counted_bars;
    if ((max_candles != 0) && (limit > max_candles)) limit = max_candles;
    
    double k = (WindowPriceMax() - WindowPriceMin()) / 20;
    for(int i = limit; i > 0; i--)
    {
        double rs = (NormalizeDouble(Open[i], Digits) - NormalizeDouble(Close[i], Digits)) / Point;
        if(rs < 0 && MathAbs(rs) >= min_candle_size) {
            drawtext(i, High[i]+k, DoubleToStr(rs*(-1),0), cb, CandleSizeString + TimeToStr(Time[i], TIME_DATE|TIME_MINUTES));
            
            double top = (NormalizeDouble(High[i], Digits) - NormalizeDouble(Close[i], Digits)) / Point;
            double low = (NormalizeDouble(Open[i], Digits) - NormalizeDouble(Low[i], Digits)) / Point;
            
            drawtext(i, High[i] + 20 * Point(), DoubleToStr(top, 0), ColorBull, CandleUpperWickSizeString + TimeToStr(Time[i], TIME_DATE|TIME_MINUTES));
            drawtext(i, Low[i], DoubleToStr(low, 0), ColorBull, CandleLowerWickSizeString + TimeToStr(Time[i], TIME_DATE|TIME_MINUTES));
            
            LowerWick[i] = low;
            UpperWick[i] = top;
            CandleSize[i] = rs*(-1);
        }
        else if(rs > 0 && rs >= min_candle_size) {
            drawtext(i, High[i]+k, DoubleToStr(rs,0), cb, CandleSizeString + TimeToStr(Time[i], TIME_DATE|TIME_MINUTES));
            double top = (NormalizeDouble(High[i], Digits) - NormalizeDouble(Open[i], Digits)) / Point;
            double low = (NormalizeDouble(Close[i], Digits) - NormalizeDouble(Low[i], Digits)) / Point;
            
            drawtext(i, High[i] + 20 * Point(), DoubleToStr(top, 0), ColorBear, CandleUpperWickSizeString + TimeToStr(Time[i], TIME_DATE|TIME_MINUTES));
            drawtext(i, Low[i], DoubleToStr(low, 0), ColorBear, CandleLowerWickSizeString + TimeToStr(Time[i], TIME_DATE|TIME_MINUTES));
            
            LowerWick[i] = low;
            UpperWick[i] = top;
            CandleSize[i] = rs;
        } else if(rs == 0) {
            drawtext(i, High[i]+k, DoubleToStr(rs,0), cb, CandleSizeString + TimeToStr(Time[i], TIME_DATE|TIME_MINUTES));
            double top = (NormalizeDouble(High[i], Digits) - NormalizeDouble(Open[i], Digits)) / Point;
            double low = (NormalizeDouble(Open[i], Digits) - NormalizeDouble(Low[i], Digits)) / Point;
            
            drawtext(i, High[i] + 20 * Point(), DoubleToStr(top, 0), cb, CandleUpperWickSizeString + TimeToStr(Time[i], TIME_DATE|TIME_MINUTES));
            drawtext(i, Low[i], DoubleToStr(low, 0), cb, CandleLowerWickSizeString + TimeToStr(Time[i], TIME_DATE|TIME_MINUTES));
            
            LowerWick[i] = low;
            UpperWick[i] = top;
            CandleSize[i] = rs;
        }
    }
    return(0);
}

int deinit()
{
   ObjectsDeleteAll(0,OBJ_TEXT);
   return(0);  
}
  
void drawtext(int n, double Y1, string l,color c, string name)
{
   if(show_on_chart) {
      ObjectDelete (name);
      ObjectCreate (name, OBJ_TEXT, 0, Time[n], Y1, 0, 0, 0, 0);
      ObjectSetText(name, l, font_size, font_name);
      ObjectSet    (name, OBJPROP_COLOR, c);
   }
}
