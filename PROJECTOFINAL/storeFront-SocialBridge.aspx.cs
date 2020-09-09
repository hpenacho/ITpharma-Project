using Nemiro.OAuth;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PROJECTOFINAL
{
    public partial class storeFront_SocialBridge : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var result = OAuthWeb.VerifyAuthorization();

            if (result.IsSuccessfully)
            {
                var user = result.UserInfo;
                auth_success(user);

            }
        }


        private void auth_success(UserInfo user)
        {

           


        }
    }
}