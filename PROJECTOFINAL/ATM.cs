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


        public static void setATM(int atmid, string atmname)
        {
             ID = atmid;
             name = atmname;
        }




    }
}