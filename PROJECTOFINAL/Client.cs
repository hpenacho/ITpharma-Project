using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Web;

namespace PROJECTOFINAL
{
    public class Client
    {

        //Utility Variables
        public static bool isLogged { get; set; } = false;
        public static bool social { get; set; } = false;

        //User Object Details
        public static int userID { get; set; } = 0;
        public static string name { get; set; }
        public static string email { get; set; }
        public static string address { get; set; }
        public static string NIF { get; set; }
        public static string nrSaude { get; set; }
        public static char gender { get; set; }
        public static string codPostal { get; set; }
        public static DateTime birthday { get; set; }



        public static void resetClient() //Melhorar este método, talvez restruturar para usar instâncias
        {
            isLogged = false;
            social = false;
            userID = 0;

            name = null;
            email = null;
            address = null;
            NIF = null;
            nrSaude = null;
            codPostal = null;

        }



    }
}
