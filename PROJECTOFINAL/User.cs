using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PROJECTOFINAL
{
    public class User
    {

        //Utility Variables
        public static bool isLogged { get; set; }

        //User Object Details
        public int userID { get; set; }
        public string name { get; set; }
        public string email { get; set; }
        public string address { get; set; }
        public string NIF { get; set; }
        public string nrSaude { get; set; }
        public char gender { get; set; }
        public DateTime birthday { get; set; }

    }
}
