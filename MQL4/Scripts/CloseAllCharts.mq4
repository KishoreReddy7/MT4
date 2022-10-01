#property link          "https://www.sanjureddy.in"
#property version       "1.00"
#property strict
#property copyright     "SanjuReddy.in - 2022"
#property show_inputs
#property description   "This script will open all the chats of currency pairs"
#property description   "in a specified time frame"
#property icon          "\\Files\\EF-Icon-64x64px.ico"

void OnStart()
{
   for(long ch=ChartFirst();ch >= 0;ch=ChartNext(ch))
      if(ch!=ChartID())
         ChartClose(ch);
   ChartClose(ChartID());
}