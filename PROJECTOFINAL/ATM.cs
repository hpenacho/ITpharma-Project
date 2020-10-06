using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PROJECTOFINAL
{
    public class ATM
    {
        public static int ID { get; set; }
        public static string name { get; set; } = null;
        public static int anonTunnelID { get; set; }


        public static void setATM(int atmid, string atmname, int atmAnonTunnelID)
        {
             ID = atmid;
             name = atmname;
             anonTunnelID = atmAnonTunnelID;
        }




    }
}