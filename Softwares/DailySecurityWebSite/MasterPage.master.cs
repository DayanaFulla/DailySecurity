using DailyDB.App_Code.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Usuario user = (Usuario)Session["USUARIO"];
        if (user==null)
        {
            Response.Redirect("Home.aspx");
        }
    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        Session["USUARIO"] = null;
        Response.Redirect("Home.aspx");
    }
}
