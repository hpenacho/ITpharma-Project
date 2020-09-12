using Nemiro.OAuth;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Net.Mail;
using System.Security.Cryptography;
using System.Web;
using System.Web.Configuration;
using System.Web.UI.WebControls;

namespace PROJECTOFINAL
{
    public class Tools
    {
        //connection string 
        public static string connectionString = ConfigurationManager.ConnectionStrings["ITpharmaConnectionString"].ConnectionString;
        public static SqlConnection myConn { get; set; } = new SqlConnection(connectionString);

        public static SqlCommand SqlProcedure(string procName)
        {
            SqlCommand myCommand = new SqlCommand();

            myCommand.CommandType = CommandType.StoredProcedure;
            myCommand.CommandText = procName;
            myCommand.Connection = myConn;

            return myCommand;
        }

        public static SqlParameter errorOutput(string parameterName , SqlDbType outputType, int size)
        {
            SqlParameter output = new SqlParameter();
            output.ParameterName = parameterName;
            output.Direction = ParameterDirection.Output;
            output.SqlDbType = outputType;
            output.Size = size;

            return output;
        }


        public static byte[] imageUpload(FileUpload fileControl)
        {
            Stream imgstream = fileControl.PostedFile.InputStream;
            int imgLen = fileControl.PostedFile.ContentLength;
            byte[] imgBinaryData = new byte[imgLen];
            imgstream.Read(imgBinaryData, 0, imgLen);

            return imgBinaryData;
        }


        public static string EncryptString(string Message)
        {
            string Passphrase = "EXAME";
            byte[] Results;
            System.Text.UTF8Encoding UTF8 = new System.Text.UTF8Encoding();

            // Step 1. We hash the passphrase using MD5
            // We use the MD5 hash generator as the result is a 128 bit byte array
            // which is a valid length for the TripleDES encoder we use below

            MD5CryptoServiceProvider HashProvider = new MD5CryptoServiceProvider();
            byte[] TDESKey = HashProvider.ComputeHash(UTF8.GetBytes(Passphrase));

            // Step 2. Create a new TripleDESCryptoServiceProvider object
            TripleDESCryptoServiceProvider TDESAlgorithm = new TripleDESCryptoServiceProvider();

            // Step 3. Setup the encoder
            TDESAlgorithm.Key = TDESKey;
            TDESAlgorithm.Mode = CipherMode.ECB;
            TDESAlgorithm.Padding = PaddingMode.PKCS7;

            // Step 4. Convert the input string to a byte[]
            byte[] DataToEncrypt = UTF8.GetBytes(Message);

            // Step 5. Attempt to encrypt the string
            try
            {
                ICryptoTransform Encryptor = TDESAlgorithm.CreateEncryptor();
                Results = Encryptor.TransformFinalBlock(DataToEncrypt, 0, DataToEncrypt.Length);
            }
            finally
            {
                // Clear the TripleDes and Hashprovider services of any sensitive information
                TDESAlgorithm.Clear();
                HashProvider.Clear();
            }

            // Step 6. Return the encrypted string as a base64 encoded string

            string enc = Convert.ToBase64String(Results);
            enc = enc.Replace("+", "KKK");
            enc = enc.Replace("/", "JJJ");
            enc = enc.Replace("\\", "III");
            return enc;
        }


        public static string DecryptString(string Message)
        {
            string Passphrase = "EXAME";
            byte[] Results;
            System.Text.UTF8Encoding UTF8 = new System.Text.UTF8Encoding();

            // Step 1. We hash the passphrase using MD5
            // We use the MD5 hash generator as the result is a 128 bit byte array
            // which is a valid length for the TripleDES encoder we use below

            MD5CryptoServiceProvider HashProvider = new MD5CryptoServiceProvider();
            byte[] TDESKey = HashProvider.ComputeHash(UTF8.GetBytes(Passphrase));

            // Step 2. Create a new TripleDESCryptoServiceProvider object
            TripleDESCryptoServiceProvider TDESAlgorithm = new TripleDESCryptoServiceProvider();

            // Step 3. Setup the decoder
            TDESAlgorithm.Key = TDESKey;
            TDESAlgorithm.Mode = CipherMode.ECB;
            TDESAlgorithm.Padding = PaddingMode.PKCS7;

            // Step 4. Convert the input string to a byte[]

            Message = Message.Replace("KKK", "+");
            Message = Message.Replace("JJJ", "/");
            Message = Message.Replace("III", "\\");


            // Step 5. Attempt to decrypt the string
            try
            {
                byte[] DataToDecrypt = Convert.FromBase64String(Message);
                ICryptoTransform Decryptor = TDESAlgorithm.CreateDecryptor();
                Results = Decryptor.TransformFinalBlock(DataToDecrypt, 0, DataToDecrypt.Length);
            }
            finally
            {
                // Clear the TripleDes and Hashprovider services of any sensitive information
                TDESAlgorithm.Clear();
                HashProvider.Clear();
            }

            // Step 6. Return the decrypted string in UTF8 format
            return UTF8.GetString(Results);
        }

        /*
            Function to send emails 
            @email - destination email
            @body - the body of the email (can have html)
            @subject - subject of the email
        */

        public static void email(string email, string body, string subject)
        {

            MailMessage m = new MailMessage();
            SmtpClient sc = new SmtpClient();

            m.From = new MailAddress(WebConfigurationManager.AppSettings["username"]);
            m.To.Add(email);
            m.Subject = subject;
            m.IsBodyHtml = true;
            m.Body = body; //String com link de ativacao

            sc.Host = WebConfigurationManager.AppSettings["host"];
            sc.Port = int.Parse(WebConfigurationManager.AppSettings["port"]);
            sc.EnableSsl = true;
            sc.DeliveryMethod = SmtpDeliveryMethod.Network;

            sc.Credentials = new System.Net.NetworkCredential(WebConfigurationManager.AppSettings["username"], WebConfigurationManager.AppSettings["password"]);
            sc.EnableSsl = true;
            sc.Send(m);
            sc.Dispose();
        }


        //AUTHENTICATION USING NEMIRO LIBRARIES

        public static bool registry { get; set; } = false;

        public static void initiateAuth()
        {

            OAuthManager.RegisterClient(

                       "google",
                       "471126422232-se1ig73pabld0jjjf839kkedcvhjps1s.apps.googleusercontent.com",
                       "e974tjnTDry_lGRJWSpMOm4V"
               );

            OAuthManager.RegisterClient( 

                        "facebook",
                        "3362722117286494",
                        "e499b1245aba3d83e2c54e32cc35f516"
                );

            OAuthManager.RegisterClient(

                        "github",
                        "10d3bb7da759c244e45c",
                        "e59d4c4df61e645f3123d3ab67e6ebc45e386454"
               );
        }







    }
}