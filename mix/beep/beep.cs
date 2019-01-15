using System;
using System.Net.NetworkInformation;
using System.Threading;

class Program
{
    static void Main(string[] args)
    {
        Ping pinger = new Ping();
        while (true)
        {
            if (pinger.Send("8.8.8.8").Status == IPStatus.Success)
            {
                Console.Beep(4000, 60);
            }
            Thread.Sleep(1000);
        }
    }
}
