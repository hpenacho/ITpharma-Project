using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

namespace PROJECTOFINAL.News
{
    public partial class newsUserControl : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Xml1.TransformSource = "news.xslt";
            XmlDocument xmldoc = new XmlDocument();
            xmldoc.Load("https://news.un.org/feed/subscribe/en/news/topic/health/feed/rss.xml"); 
            //xmldoc.Load("https://www.medpagetoday.com/rss/headlines.xml");


            Xml1.Document = xmldoc;
        }
    }
}